class WebcfaceAT1 < Formula
  desc "Web-based RPC & UI Library"
  homepage "https://github.com/na-trium-144/webcface"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v1.11.4.tar.gz"
  sha256 "3db99e275d0fdb9ca7652e87086e63c031c2fd726a02f9250c1663fc72c3d196"
  license "MIT"
  revision 3

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface@1-1.11.4_2"
    sha256 cellar: :any,                 arm64_sonoma: "4347ef563622faee5ddff187a0dd34821cdfdcc839ca24b172bd5f865fdbfb8c"
    sha256 cellar: :any,                 ventura:      "a3fbd7f4bbe5c30bb9627834b7cd3ded112c7915ebf571aa5b138dc397b9b6f1"
    sha256 cellar: :any,                 monterey:     "5f9960e09e8d98f73a3dde76a3590d18e910a0ff082e64dd0249dcffcdb9069e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "732612c2208e1928fb60a15b7ed0605bbebedfdd9b4e1fe55ef47b5d86717f6b"
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
