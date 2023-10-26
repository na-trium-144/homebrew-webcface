class Webcface < Formula
  desc "Web-based RPC & UI Library"
  homepage "https://github.com/na-trium-144/webcface"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v1.1.3.tar.gz"
  sha256 "8cc8ba6323f07e8d7e8e7448912dcb10631cef03de99652e857e862866e12757"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-1.1.2"
    sha256 cellar: :any,                 ventura:      "166949f119f255ef4aa7713e4220afe37756db7828bbd227d7e6882c68484090"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9eff3325c05ad549895820f50fc4f2e5c6f0cae37fd038b44677c753f0f77117"
  end

  depends_on "cmake" => [:build, :test]
  depends_on "msgpack-cxx"
  depends_on "spdlog"

  def install
    rmdir(%w[external/eventpp external/cinatra external/cli11])
    system "git", "clone", "https://github.com/wqking/eventpp.git", "external/eventpp"
    system "git", "clone", "https://github.com/qicosmos/cinatra.git", "external/cinatra"
    system "git", "clone", "https://github.com/CLIUtils/CLI11.git", "external/cli11"
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
