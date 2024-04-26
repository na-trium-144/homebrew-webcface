class Webcface < Formula
  desc "Web-based RPC & UI Library"
  homepage "https://github.com/na-trium-144/webcface"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v1.11.0.tar.gz"
  sha256 "de2812e94806cc33e049b1934c3fd7e5033168f0b016c0cd24c48c4b2de7aa15"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-1.10.0"
    sha256 cellar: :any,                 arm64_sonoma: "bf92ccdbb9a811517ff1773b906eeeca8fe73d72b5171665c735d4b9194bc9e2"
    sha256 cellar: :any,                 ventura:      "e66658f5c64ebe64281b9f3a12df00910646e81d95344d009944bd49e0b67bae"
    sha256 cellar: :any,                 monterey:     "c999d7f18c6349e0c7163e3967370356bbabbaebe302f0f452605193bf73eaf2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ef9e3d7af6d7d113ea7b4dfbf9deb9e5e1dc6623d1dfbdde854348fc0cba7333"
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
