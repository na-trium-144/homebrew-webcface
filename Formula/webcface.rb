class Webcface < Formula
  desc "Web-based RPC & UI Library"
  homepage "https://github.com/na-trium-144/webcface"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v1.10.0.tar.gz"
  sha256 "1dbe7937e35e4586973833ba27bfa48c088e9192266ce947e0409fca3f1302cc"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-1.9.1"
    sha256 cellar: :any,                 arm64_sonoma: "c1482125e866fe5a322be061fd4d4acf8cbf0d1112f602d57baf04c3eba0229b"
    sha256 cellar: :any,                 ventura:      "9504e1f9bb8f972012ba863a90c2565bbabdcd31acb552bb7d289329cfaebbb2"
    sha256 cellar: :any,                 monterey:     "4b1aad8eb8e890ae98178d7a029d008e698f926818bbadb3d19109c3532fffef"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "668aa2a769e5f100cc54ff14b95b69f9fdaa113b811e1e2ac5f9e089b185bb83"
  end

  depends_on "cmake" => [:build, :test]
  depends_on "msgpack-cxx"
  depends_on "opencv"
  depends_on "spdlog"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DWEBCFACE_DOWNLOAD_WEBUI=off"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "#{bin}/webcface-server", "-h"

    (testpath/"CMakeLists.txt").write <<EOS
      cmake_minimum_required(VERSION 3.0)
      project(hoge)
      find_package(webcface)
      add_executable(hoge ${CMAKE_CURRENT_SOURCE_DIR}/main.cc)
      target_link_libraries(hoge webcface::webcface)
EOS
    (testpath/"main.cc").write <<EOS
      #include <webcface/webcface.h>
      #include <iostream>
      #include <thread>
      #include <chrono>
      int main(){
        WebCFace::Client cli("sandbox");
        std::this_thread::sleep_for(std::chrono::milliseconds(100));
        cli.logger()->info(WEBCFACE_VERSION);
        cli.value("aaa") = 123;
        cli.sync();
      }
EOS
    system "cmake", "-B", "build"
    system "cmake", "--build", "build"
  end
end
