class WebcfaceAT2 < Formula
  desc "Web-based IPC & Dashboard-like UI"
  homepage "https://na-trium-144.github.io/webcface/"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v2.0.3.tar.gz"
  sha256 "8860eceff13471009fbd9010c97fc739ede135641accfd9574890cf2c7d23db9"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface@2-2.0.3"
    sha256 cellar: :any, arm64_sonoma: "cf8ba0caec0c2db1fa4507a20ab7c83eb3434f06a1b4c8c48807512e5a14db2c"
    sha256 cellar: :any, ventura:      "1fdf65082220d405117e78f20ae0e00e12fe08d27be0b5ff38010e0dee124f09"
    sha256 cellar: :any, monterey:     "9e3077e532f6eb61560c012fef428c5167003592105a5d273c5a136539cfab27"
    sha256               x86_64_linux: "4884ba0b8da84572a53c045730c3e3f4a132067654f3f0cbd5f7d74c4d068b58"
  end

  depends_on "asio" => :build
  depends_on "cli11" => :build
  depends_on "cmake" => [:build, :test]
  depends_on "meson" => :build
  depends_on "msgpack-cxx" => :build
  depends_on "na-trium-144/webcface/crow-unix-socket" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "utf8cpp" => :build
  depends_on "na-trium-144/webcface/curl-ws"
  depends_on "na-trium-144/webcface/imagemagick-no-openmp"
  depends_on "spdlog"

  def install
    system "meson", "setup", "build", *std_meson_args,
      "-Dtests=disabled", "-Ddownload_webui=disabled", "-Dcv_examples=disabled"
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    system "#{bin}/webcface-server", "-h"

    (testpath/"CMakeLists.txt").write <<EOS
      cmake_minimum_required(VERSION 3.0)
      project(hoge)
      find_package(webcface 2.0 REQUIRED)
      add_executable(hoge ${CMAKE_CURRENT_SOURCE_DIR}/main.cc)
      target_link_libraries(hoge webcface::webcface)
EOS
    (testpath/"main.cc").write <<EOS
      #include <webcface/webcface.h>
      #include <iostream>
      #include <thread>
      #include <chrono>
      int main(){
        webcface::Client cli("sandbox");
        cli.start();
        std::this_thread::sleep_for(std::chrono::milliseconds(100));
        cli.value("aaa") = 123;
        cli.loopSync();
      }
EOS
    system "cmake", "-B", "build"
    system "cmake", "--build", "build"
  end
end
