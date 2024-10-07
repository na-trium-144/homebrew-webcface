class WebcfaceAT2 < Formula
  desc "Web-based IPC & Dashboard-like UI"
  homepage "https://na-trium-144.github.io/webcface/"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v2.4.1.tar.gz"
  sha256 "3c7639ad3e12d8af1c41b866ffd80475a44f80ac2123d9378a0e2c5a8ab0906d"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface@2-2.4.0"
    sha256 cellar: :any, arm64_sonoma: "a129589e2dbef01397836a8c932cd505e445f03729aee3cd6c85788818786bc5"
    sha256 cellar: :any, ventura:      "e82205e020b038bf393f6e64c10cf824eddd2f8141bfe6c6f148e6c1c46ad377"
    sha256               x86_64_linux: "fe28429f7ed155c5d2242064d81e67c51b7cb0ca4eed87114b330ca136b66ea8"
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
