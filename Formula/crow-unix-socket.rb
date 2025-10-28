class CrowUnixSocket < Formula
  desc "Fast and Easy to use microframework for the web"
  homepage "https://crowcpp.org/"
  url "https://github.com/na-trium-144/Crow.git",
    revision: "11bf7a0dfacc1df9f2fbfa5838828817ff58661b"
  version "1.2.0-2"
  license "BSD-3-Clause"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/crow-unix-socket-1.2.0-1_1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f62c024d6e177d61f24ed6c55c7a8c4438d893e060ce1a7d6d6d2d7644ab24a0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "15bab1482e2ce1faa858e9ec0706d789d1ba43bc2210f8618edf4db7ae103b51"
    sha256 cellar: :any_skip_relocation, ventura:       "44e3987d97f4f5fe416b511bb2ac0987d5bcd11c81085489d4d1b16e123df7e6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1b20a523e26e3df654e2d3c8fb6d4b84cd68bb994d846513f9bfaf5c97e6283b"
  end

  depends_on "cmake" => [:build, :test]
  depends_on "asio"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DCROW_BUILD_EXAMPLES=OFF", "-DCROW_BUILD_TESTS=OFF"
    system "cmake", "--build", "build", "-t", "install"
  end

  test do
    (testpath/"CMakeLists.txt").write <<~EOS
      cmake_minimum_required(VERSION 3.0)
      project(hoge)
      set(CMAKE_CXX_STANDARD 11)
      find_package(Crow)
      add_executable(hoge ${CMAKE_CURRENT_SOURCE_DIR}/test.cpp)
      target_link_libraries(hoge Crow::Crow)
    EOS
    (testpath/"test.cpp").write <<~EOS
      #include "crow.h"
      int main()
      {
          crow::SimpleApp app;

          CROW_ROUTE(app, "/")([](){
              return "Hello world";
          });

          app.unix_path("/tmp/test.sock").multithreaded().run();
      }
    EOS
    system "cmake", "-B", "build"
    system "cmake", "--build", "build"
  end
end
