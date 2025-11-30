class WebcfaceAT3 < Formula
  desc "Web-based Communication Framework & Dashboard-like UI"
  homepage "https://na-trium-144.github.io/webcface/"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v3.2.0.tar.gz"
  sha256 "8be84ca611fe765e604c1dcf87fc25268ed49cdc9162bcababfe1f368ef50c0c"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface@3-3.2.0"
    sha256 cellar: :any, arm64_sequoia: "ad881b07ec0743d966ffaa3aaa6148212facd44b6ad89b32b2c1c3b159566319"
    sha256 cellar: :any, arm64_sonoma:  "1d5e0658f0a3f9847c0b19cc8309ef7e34c3c7c5e48e1ca8b9a73389f361ab2a"
    sha256               x86_64_linux:  "37fa392253ac18700aa958984a32813edb2695d5ac928cdddfbdddc0bf9f8c8b"
  end

  depends_on "asio" => :build
  depends_on "cli11" => :build
  depends_on "cmake" => [:build, :test]
  depends_on "crow-unix-socket" => :build
  depends_on "meson" => :build
  depends_on "msgpack-cxx" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "utf8cpp" => :build
  depends_on "curl"
  depends_on "fmt"
  depends_on "glib"
  depends_on "spdlog"
  depends_on "vips-lite"

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
    system "cmake", "-B", "build", "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
    system "cmake", "--build", "build"
  end
end
