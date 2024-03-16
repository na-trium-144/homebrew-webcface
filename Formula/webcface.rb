class Webcface < Formula
  desc "Web-based RPC & UI Library"
  homepage "https://github.com/na-trium-144/webcface"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v1.9.0.tar.gz"
  sha256 "c4f83f9ad75b0be07d5eb017182a342b423c444fcb33929732112bd03563b495"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-1.9.0"
    sha256 cellar: :any,                 arm64_sonoma: "fdbe4d8f77939e52e3ccb38d42b82a9a72f8b8316be705fffbc1156d6a56aaab"
    sha256 cellar: :any,                 ventura:      "80daf2cf1014e124ec5b43941922acd264589697b8cb1b63ac62d421fb5dc4db"
    sha256 cellar: :any,                 monterey:     "ed1160549b20075116e30857b001911d50e193e2e761055d0215b7065db014ae"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "67833d5cfa23eacf95e7e3d2bf0e531353a812dd0a7a64dbd74b671eca441818"
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
