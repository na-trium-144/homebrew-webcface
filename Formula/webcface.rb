class Webcface < Formula
  desc "Web-based RPC & UI Library"
  homepage "https://github.com/na-trium-144/webcface"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v1.11.1.tar.gz"
  sha256 "4d9b7c1af0a2e764857e43654416f23bbf462455166c8ce9c2c5868abba0f512"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-1.11.0"
    sha256 cellar: :any,                 arm64_sonoma: "6ffc2f51cc017de861879cedb3c2b19cd09cd045b992c8d58393b52dc3b75776"
    sha256 cellar: :any,                 ventura:      "f2c9b598f836d5c1b502f472e198da3aacd66e08aa489eae348e71d1652aba3a"
    sha256 cellar: :any,                 monterey:     "dc1714d754f9d4a83e0232f543540dffe10641734f695862ff29f361d0f9dc68"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "79be1e7cfbbb1f3cb5397f1c81aad19bedb02d840b84008bd0440ba7cfe5cbaf"
  end

  depends_on "cmake" => [:build, :test]
  depends_on "msgpack-cxx"
  depends_on "opencv"
  depends_on "spdlog"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DWEBCFACE_DOWNLOAD_WEBUI=off",
      "-DFETCHCONTENT_FULLY_DISCONNECTED=OFF"
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
