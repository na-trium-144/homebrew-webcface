class WebcfaceAT3 < Formula
  desc "Web-based Communication Framework & Dashboard-like UI"
  homepage "https://na-trium-144.github.io/webcface/"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v3.3.1.tar.gz"
  sha256 "80231719148b2a242bf2610abd02d4c6c06f4779e4a4c65a688e112da355c4bd"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface@3-3.3.1_1"
    sha256 cellar: :any, arm64_tahoe:   "3c1abe359e4ef6559e8ca5fa5548cf13fa84b137e5918c65f8711f131873c2cb"
    sha256 cellar: :any, arm64_sequoia: "4e5675e1a0cd70df80c9223adddbb5ab667d0b061df3a18559cd919a4c960ba5"
    sha256 cellar: :any, arm64_sonoma:  "97db1e06f86b6cb929b966f60a0499d6c1d6236f14070cf95bc3ebc38bd62686"
    sha256               x86_64_linux:  "59cfc9325078d01e0ff8efcf814ac340098c444b141b1e1ebc3576bc9210669b"
  end

  depends_on "asio" => :build
  depends_on "cli11" => :build
  depends_on "cmake" => [:build, :test]
  depends_on "crow" => :build
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
