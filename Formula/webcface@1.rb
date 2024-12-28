class WebcfaceAT1 < Formula
  desc "Web-based RPC & UI Library"
  homepage "https://github.com/na-trium-144/webcface"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v1.11.4.tar.gz"
  sha256 "3db99e275d0fdb9ca7652e87086e63c031c2fd726a02f9250c1663fc72c3d196"
  license "MIT"
  revision 5

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface@1-1.11.4_4"
    sha256 cellar: :any,                 arm64_sonoma: "c3dcc718ad28ddb6c380f56b4de4268dbde602d9ddadd012220df243a925cf78"
    sha256 cellar: :any,                 ventura:      "b7366ecdbc81d659f2032cf39e60a85ff4a1a1f6cb6b1f710409fdb2ee6b901a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bae69c4e7af8fcc34151d76c3cee52e36ced6b93a49cec25fa2d00530cee6aa2"
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
