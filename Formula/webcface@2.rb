class WebcfaceAT2 < Formula
  desc "Web-based IPC & Dashboard-like UI"
  homepage "https://na-trium-144.github.io/webcface/"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v2.2.1.tar.gz"
  sha256 "129f0206f3f26958bdbd0546b511b44045b398de4e0801be3dc74b0f7541f47a"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface@2-2.2.0"
    sha256 cellar: :any, arm64_sonoma: "2a3f6300ead85cb94ef61135742a5e4eb1750f8df874870149a083c142576631"
    sha256 cellar: :any, ventura:      "32c692a3d9701a5ed9363fb4d0dd7fd1f201ca796102ad8f96b3e275b84ec6df"
    sha256 cellar: :any, monterey:     "0fced7b3a246b9163d25c0b39edbacc146c04aeea5d324c77a57835d5b3f591c"
    sha256               x86_64_linux: "af4eb57b887289d42eaa414c4e95301d1fc1abe35e5982428d7d19a2044d0bca"
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
