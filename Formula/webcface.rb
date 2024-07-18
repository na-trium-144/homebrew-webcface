class Webcface < Formula
  desc "Web-based RPC & UI Library"
  homepage "https://github.com/na-trium-144/webcface"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v1.11.4.tar.gz"
  sha256 "3db99e275d0fdb9ca7652e87086e63c031c2fd726a02f9250c1663fc72c3d196"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-1.11.4"
    sha256 cellar: :any,                 arm64_sonoma: "e1936e6166985b9fd9b3e5cc2a2cdf65fdcd07c9e9dfd6da0bbd432d4ab11c58"
    sha256 cellar: :any,                 ventura:      "9e978716ba71cd98fdc5826b8f1076555be9d01855c53eed2e4fabe9fb31082a"
    sha256 cellar: :any,                 monterey:     "11a2bf22963e2f98db3eafd4e1243f058ccc7669a22bac0a8704cfe489fcf98c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "533555f8cc7ead6c23344b23b79dd3fb59f79e5e6f93c8de774c3b44deef1945"
  end

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
