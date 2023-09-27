class Webcface < Formula
  desc "Web-based RPC & UI Library"
  homepage "https://github.com/na-trium-144/webcface"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "71791c3710ab14c9efefd2af77f87a4ec64a57b1aaf6b38d452a4c8fbac78e1e"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "git" => :build
  depends_on "googletest" => :build
  depends_on "msgpack-cxx"
  depends_on "spdlog"

  def install
    rmdir(%w[external/eventpp external/cinatra external/tclap])
    system "git", "clone", "https://github.com/wqking/eventpp.git", "external/eventpp"
    system "git", "clone", "https://github.com/qicosmos/cinatra.git", "external/cinatra"
    system "git", "clone", "https://git.code.sf.net/p/tclap/code", "external/tclap"
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DWEBCFACE_EXAMPLE=on", "-DWEBCFACE_TEST=on"
    system "cmake", "--build", "build"
    system "sh", "-c", "cd build && ctest"
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
