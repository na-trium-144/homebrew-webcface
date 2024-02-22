class Webcface < Formula
  desc "Web-based RPC & UI Library"
  homepage "https://github.com/na-trium-144/webcface"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v1.6.3.tar.gz"
  sha256 "692091e069fbd392d5e8fb182fdd014bfa5282b40e4263e0aee18df5393289cf"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-1.6.3"
    sha256 cellar: :any,                 arm64_sonoma: "c35184ec047b6ace380bc9f38b72aa0862939a6d4784a525cb976ccddbed21bb"
    sha256 cellar: :any,                 ventura:      "3ba4fa67569c4cb2d21d2c3b362c0919ab974242badd6ac204085b4d13ae2b26"
    sha256 cellar: :any,                 monterey:     "0a11802b093debc9dd3f8f121e5c4ba670fca28837ddad72af20eb2a6b2e83d3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4334b420326b5acb849ec6e6f454cfd40f2fb5af0af62a440e6e07d849f6728d"
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
