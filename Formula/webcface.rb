class Webcface < Formula
  desc "Web-based RPC & UI Library"
  homepage "https://github.com/na-trium-144/webcface"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v1.1.7.tar.gz"
  sha256 "6d61d62119b6bb1df7e6247ef22f5ab4957833c0dd32856536f0efc4fb70dffc"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-1.1.6"
    sha256 cellar: :any,                 ventura:      "84c643248301fe00d4ea3dcef27de1d0272ad1921d2dff5926ffc286da650728"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "12bf725a76b699db4e26f458004d17ddfa7a679732f772529b3114f5156e4334"
  end

  depends_on "cmake" => [:build, :test]
  depends_on "msgpack-cxx"
  depends_on "spdlog"

  def install
    rmdir(%w[external/eventpp external/cinatra external/asio external/crow external/curl])
    system "git", "clone", "https://github.com/wqking/eventpp.git", "external/eventpp"
    system "git", "clone", "https://github.com/qicosmos/cinatra.git", "external/cinatra"
    system "git", "clone", "https://github.com/chriskohlhoff/asio.git", "external/asio"
    system "git", "clone", "https://github.com/curl/curl.git", "external/curl"
    system "git", "clone", "--branch", "fix-destructor-io-service", "https://github.com/na-trium-144/Crow.git",
      "external/crow"
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
