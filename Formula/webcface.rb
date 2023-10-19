class Webcface < Formula
  desc "Web-based RPC & UI Library"
  homepage "https://github.com/na-trium-144/webcface"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v1.1.2.tar.gz"
  sha256 "f9874dd9c09f8244f845de5c5fce26464c98db393c0ffaecce3121d19c78ddaf"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-1.1.1"
    sha256 cellar: :any,                 ventura:      "11a607ad7af7a76809415a95ad301575706c6186be280d71a2624d7efa896c4d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ca438db6d8674c26c67ecf0cdfc674ef3e2ec4a989319f218cc8d5f24903f1ed"
  end

  depends_on "cmake" => [:build, :test]
  depends_on "msgpack-cxx"
  depends_on "spdlog"

  def install
    rmdir(%w[external/eventpp external/cinatra external/tclap])
    system "git", "clone", "https://github.com/wqking/eventpp.git", "external/eventpp"
    system "git", "clone", "https://github.com/qicosmos/cinatra.git", "external/cinatra"
    system "git", "clone", "https://git.code.sf.net/p/tclap/code", "external/tclap"
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
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
