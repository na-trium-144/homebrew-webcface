class WebcfaceAT2 < Formula
  desc "Web-based Communication Framework & Dashboard-like UI"
  homepage "https://na-trium-144.github.io/webcface/"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v2.8.0.tar.gz"
  sha256 "050ccbcb37b4f2b5aebec63d02c1893e09f163de791d7b0df6648e0ac00a60af"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface@2-2.8.0"
    sha256 cellar: :any, arm64_sequoia: "397a688ba1527859502b24f4b97a983bf8e2d73e18b37d0af4896634b9d35e0d"
    sha256 cellar: :any, arm64_sonoma:  "eb2d656000399b74c910b5489906cb1e08052b4ff45c3782ff2d1fa970be36fa"
    sha256 cellar: :any, ventura:       "2e9c5c81a519ab3f37afa5d28033d8439d5d5ba34da00e490668a13d22006975"
    sha256               x86_64_linux:  "9c5ae3f32d4526e577ad4adc1248bcb7994b727f71f707c918f7ade2b23149a6"
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
