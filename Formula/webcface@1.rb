class WebcfaceAT1 < Formula
  desc "Web-based RPC & UI Library"
  homepage "https://github.com/na-trium-144/webcface"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v1.11.4.tar.gz"
  sha256 "3db99e275d0fdb9ca7652e87086e63c031c2fd726a02f9250c1663fc72c3d196"
  license "MIT"
  revision 6

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface@1-1.11.4_5"
    sha256 cellar: :any,                 arm64_sonoma: "3e77f1edf589a47fe0e83ccbcad25e02b9fbf9e6f64a8cfadf3df9e6df72f27a"
    sha256 cellar: :any,                 ventura:      "c7f4a826b15fe47717cfab749746e7a082526124b98597664496923ecc94ad02"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "385a5650333f7f236d89e42dcb0e6e7960f22406d61eff73a388fcd2de824524"
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
