class WebcfaceAT2 < Formula
  desc "Web-based Communication Framework & Dashboard-like UI"
  homepage "https://na-trium-144.github.io/webcface/"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v2.7.0.tar.gz"
  sha256 "29818d2ecf182d641efc99da1c3e2ba6074f0e867db1d1cceb990ea6046e9144"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface@2-2.7.0"
    sha256 cellar: :any, arm64_sequoia: "a81df49ef34085a91e08d91747e156d99b78c5c3c02c06be16ad7660f1fef0bc"
    sha256 cellar: :any, arm64_sonoma:  "13b7346f1272ab993b76bf726ca257debe7cc333a8ba5cd3c57107a289c2c7bd"
    sha256 cellar: :any, ventura:       "64efface604d224e1e2a6abce18ef80cbab93896f2f97739f6d15b26c6fef0b5"
    sha256               x86_64_linux:  "5fd26d2cadeec9a6cd2af366900ca0cebb5c4741a8f5172616b592e3b9881056"
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
  depends_on "curl-ws"
  depends_on "fmt"
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
    system "cmake", "-B", "build"
    system "cmake", "--build", "build"
  end
end
