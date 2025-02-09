class WebcfaceAT2 < Formula
  desc "Web-based Communication Framework & Dashboard-like UI"
  homepage "https://na-trium-144.github.io/webcface/"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v2.9.0.tar.gz"
  sha256 "ab0779eee607da7bfac08576a50537fd19c48cf4ebe3308f27f213ece05aacc4"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface@2-2.8.0_1"
    sha256 cellar: :any, arm64_sequoia: "bcdb552cb2ae84bc9427267a6d3f5017976cd2888790796ab4773f12c7c37cb6"
    sha256 cellar: :any, arm64_sonoma:  "f81f6aa76450ae5945139a38fd2956ceba928dddea5d2039d20898c0415d64ee"
    sha256 cellar: :any, ventura:       "6b8b523ac311598e008058d4f120550dc5c9db8a1df7eb37649223cf2939acc5"
    sha256               x86_64_linux:  "9f1030fab4adad811b6670fb970f33a113375a38ada53f0635b86dfc1476ad2f"
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
