class Webcface < Formula
  desc "Web-based RPC & UI Library"
  homepage "https://github.com/na-trium-144/webcface"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v1.9.0.tar.gz"
  sha256 "c4f83f9ad75b0be07d5eb017182a342b423c444fcb33929732112bd03563b495"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-1.8.0"
    sha256 cellar: :any,                 arm64_sonoma: "695ab69fe6843dfa7dc8074fe70ca78076ad0976d17b8a9c3bf47ef5dcd192ab"
    sha256 cellar: :any,                 ventura:      "566e01519ffb34b2c7e93ea508afe4ff349dd957e80a31d666ac94c467f9c5cd"
    sha256 cellar: :any,                 monterey:     "ca3ae436f59669fac71524d2e26a71e7622a6231c5c5155c605336b2cc494fd0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e21a8004b3c054b9a2ed1951e786d41a2ee92339073d21aab00833e5a43d0a34"
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
