class Webcface < Formula
  desc "Web-based RPC & UI Library"
  homepage "https://github.com/na-trium-144/webcface"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "742979212c58b750a8973ab44dac7a39b40e621fe7653424ff6ec41f75acd551"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-1.0.2"
    sha256 cellar: :any,                 ventura:      "a1153a13d61e4703f1865d977a0474b7dda87f59c5cf902dfface544ffec35dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5f242d8e5113d9b45ca4747394ea9d685981e522a4819afe12e9962354d6df73"
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
