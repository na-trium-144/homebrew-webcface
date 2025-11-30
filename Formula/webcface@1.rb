class WebcfaceAT1 < Formula
  desc "Web-based RPC & UI Library"
  homepage "https://github.com/na-trium-144/webcface"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v1.11.4.tar.gz"
  sha256 "3db99e275d0fdb9ca7652e87086e63c031c2fd726a02f9250c1663fc72c3d196"
  license "MIT"
  revision 7

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface@1-1.11.4_6"
    sha256 cellar: :any,                 arm64_tahoe:   "09597912f8efac1769574ffc85de34f33bd37028d3f6ac7e09dedb7d26c98145"
    sha256 cellar: :any,                 arm64_sequoia: "a8f632edae30fafb6955824eb550c0e31c7b9ad808c83d98fd68bf6affcef435"
    sha256 cellar: :any,                 arm64_sonoma:  "f4e5cc167b6c480e45ca7f9ed52eea77d58d96e0fa7bd5951495a90db3925c00"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a0226c9edef98751248eb5698f10df560bffde908508da5b0304837ef6969f31"
  end

  keg_only :versioned_formula
  depends_on "cmake" => [:build, :test]
  depends_on "msgpack-cxx"
  depends_on "opencv"
  depends_on "spdlog"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DWEBCFACE_DOWNLOAD_WEBUI=off",
      "-DFETCHCONTENT_FULLY_DISCONNECTED=OFF", "-DHOMEBREW_ALLOW_FETCHCONTENT=ON",
      "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "#{bin}/webcface-server", "-h"

    (testpath/"CMakeLists.txt").write <<EOS
      cmake_minimum_required(VERSION 3.0)
      project(hoge)
      find_package(webcface 1)
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
    system "cmake", "-B", "build", "-DCMAKE_PREFIX_PATH=#{prefix}",
      "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
    system "cmake", "--build", "build"
  end
end
