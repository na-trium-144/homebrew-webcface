class WebcfaceAT2 < Formula
  desc "Web-based IPC & Dashboard-like UI"
  homepage "https://na-trium-144.github.io/webcface/"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v2.5.1.tar.gz"
  sha256 "7b6ae5dab24fa1e86015d8eebca27e3a60c403478b24ab48e2d744761df30dc3"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface@2-2.5.0"
    sha256 cellar: :any, arm64_sonoma: "cb3dbd96468e7df073df9fea441010dd4ede8b2069a31a81c8ffbd776f0affff"
    sha256 cellar: :any, ventura:      "a79538db7600db8ee43b65e919e4800524720255fc075c543e52ebecfdcd074c"
    sha256               x86_64_linux: "ca67c6cc6058630324a84b3b7679c3d311e00febef0cac625398ef2a95e5552b"
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
