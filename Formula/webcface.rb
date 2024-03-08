class Webcface < Formula
  desc "Web-based RPC & UI Library"
  homepage "https://github.com/na-trium-144/webcface"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v1.8.0.tar.gz"
  sha256 "f070a9711c37242d5db6687b0b9eb24de01525e3a6a95ae9c92673fcf9f7c68a"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-1.7.0"
    sha256 cellar: :any,                 arm64_sonoma: "41f83d5e42d5127353d5384e669f25ccf8313c075df582cd1bfa3c6585b02548"
    sha256 cellar: :any,                 ventura:      "6ba34d158c143ac2981b6b7c2994888a9ceade4f8673d52d9cdf93009ce5586e"
    sha256 cellar: :any,                 monterey:     "b2e72b0e04b963a5196bc0b88c44ba279235896413bd8e83f7c15bb1b4926df8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0bad6525b5b405a50426e19b87f961870a9d6c56ff07bab981c0963eb9f90baf"
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
