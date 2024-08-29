class WebcfaceAT1 < Formula
  desc "Web-based RPC & UI Library"
  homepage "https://github.com/na-trium-144/webcface"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v1.11.4.tar.gz"
  sha256 "3db99e275d0fdb9ca7652e87086e63c031c2fd726a02f9250c1663fc72c3d196"
  license "MIT"
  revision 3

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface@1-1.11.4_3"
    sha256 cellar: :any,                 arm64_sonoma: "c2b1c730c21abf5b14eaccffffd8614a6fc727c516e38524234b2141aee0a7ce"
    sha256 cellar: :any,                 ventura:      "513ec3aefeab02305a3e76340391c0ec7c501f533acaa0cf5501ea2da60cac5a"
    sha256 cellar: :any,                 monterey:     "ab794545c23794a77501d8e83b8dd221495e88c55b2eb0eed5ca9d190ae85da5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6fe884359754a5dc60922e392b137384535a3a360319c8ebf15f25c515b3e4fa"
  end

  keg_only :versioned_formula
  depends_on "cmake" => [:build, :test]
  depends_on "msgpack-cxx"
  depends_on "opencv"
  depends_on "spdlog"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DWEBCFACE_DOWNLOAD_WEBUI=off",
      "-DFETCHCONTENT_FULLY_DISCONNECTED=OFF", "-DHOMEBREW_ALLOW_FETCHCONTENT=ON"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "#{bin}/webcface-server", "-h"

    (testpath/"CMakeLists.txt").write <<EOS
      cmake_minimum_required(VERSION 3.0)
      project(hoge)
      find_package(webcface 1)
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
    system "cmake", "-B", "build", "-DCMAKE_PREFIX_PATH=#{prefix}"
    system "cmake", "--build", "build"
  end
end
