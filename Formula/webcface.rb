class Webcface < Formula
  desc "Web-based RPC & UI Library"
  homepage "https://github.com/na-trium-144/webcface"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v1.11.1.tar.gz"
  sha256 "4d9b7c1af0a2e764857e43654416f23bbf462455166c8ce9c2c5868abba0f512"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-1.11.1"
    sha256 cellar: :any,                 arm64_sonoma: "a0a84e62e29341f1fa90ae6c29ca68e644f459b0eee282123f5f8a27e879f0ff"
    sha256 cellar: :any,                 ventura:      "ef1587283686f076fa449c44f243ef4707ba0d97758e4ddd08c2873a22879253"
    sha256 cellar: :any,                 monterey:     "61c4a87429af44887f382fa5f58972b31fb21c86abe6833ae6ad05e94cef56a3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2507db8fd81937fb4e69d79f1932b0ec4da1ee5933204c336c52d3b32f1b5ab9"
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
