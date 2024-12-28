class WebcfaceAT2 < Formula
  desc "Web-based Communication Framework & Dashboard-like UI"
  homepage "https://na-trium-144.github.io/webcface/"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v2.5.2.tar.gz"
  sha256 "4d757f2fc9e3a5407a3f3e4d01e731115715304a9674283a9d8f10930312c5c3"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface@2-2.5.2_1"
    sha256 cellar: :any, arm64_sequoia: "778e8756ad3e180be5c0ca59bdc7c2fd8053c95f58313c22c24d1f619f1f26fc"
    sha256 cellar: :any, arm64_sonoma:  "4d58420b353669f8b48e889a2c88d56859a6971f6056be997959cf083001416e"
    sha256 cellar: :any, ventura:       "698f4efa352c3f390eeb19d3efdfcccfe225e78baa6c3e4b850e9a72eee555ea"
    sha256               x86_64_linux:  "80618adec6b0eee5d24adf8db92ddaed8cdb6ff6046fb993d47f5f532dee6af0"
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
  depends_on "imagemagick-no-openmp"
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
