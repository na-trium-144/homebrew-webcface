class WebcfaceAT2 < Formula
  desc "Web-based IPC & Dashboard-like UI"
  homepage "https://na-trium-144.github.io/webcface/"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v2.0.3.tar.gz"
  sha256 "8860eceff13471009fbd9010c97fc739ede135641accfd9574890cf2c7d23db9"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface@2-2.0.1"
    sha256 cellar: :any, arm64_sonoma: "b4e1443940a5320f7d9f638471e97729a9bac382a6c5b92ca46d1aa2f36eb113"
    sha256 cellar: :any, ventura:      "c67fd221cf28d840fdedc427bc4ef4549b330fb2948f6f7a9461c40fb405663b"
    sha256 cellar: :any, monterey:     "579c5f5e62c6f59c7b4833f0e6e48f7778dfc70fff7e01c33782f39aeae1f992"
    sha256               x86_64_linux: "853523d22c12feac2a06220ef0b7e76db1b759cbbed2f89a9eabd0dfd921c33f"
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
