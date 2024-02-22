class Webcface < Formula
  desc "Web-based RPC & UI Library"
  homepage "https://github.com/na-trium-144/webcface"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v1.6.3.tar.gz"
  sha256 "692091e069fbd392d5e8fb182fdd014bfa5282b40e4263e0aee18df5393289cf"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-1.6.2"
    sha256 cellar: :any,                 arm64_sonoma: "a4355f1f565844ba5ad107c3bad597a86788aa7351deae5d9423412fd3912103"
    sha256 cellar: :any,                 ventura:      "b0403fccf15e009be0b76943562ea230393dba315eccb5e0b5bc5441d6507709"
    sha256 cellar: :any,                 monterey:     "c4a6c9c31c87188b5fb9e3dbac80881ccb9215a8216efb5a08ea3953a17ad3ac"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3b40e86f8b0e2be79a081affd68ef0e89e56c34782f546b938940828347510c4"
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
