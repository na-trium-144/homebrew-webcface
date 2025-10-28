class CrowUnixSocket < Formula
  desc "Fast and Easy to use microframework for the web"
  homepage "https://crowcpp.org/"
  url "https://github.com/na-trium-144/Crow.git",
    revision: "11bf7a0dfacc1df9f2fbfa5838828817ff58661b"
  version "1.2.0-2"
  license "BSD-3-Clause"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/crow-unix-socket-1.2.0-2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "ec5cf7cc682d64593c42a7db4d197fa724492857fec21718660a015b70e9e3e8"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fb5cba2fdca58dcec079c447fb3766d4a5526d7f9880d69851bc470263045468"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "df10932758497259ae5c5654765172d65473279a93bcfacf92aea1103c5f0368"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8667be7e3048a726fa9c1dd563c917b5b2b28a602859bd40b85e6dd1147c7125"
  end

  depends_on "cmake" => [:build, :test]
  depends_on "asio"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args,
      "-DCROW_BUILD_EXAMPLES=OFF", "-DCROW_BUILD_TESTS=OFF", "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
    system "cmake", "--build", "build", "-t", "install"
  end

  test do
    (testpath/"CMakeLists.txt").write <<~EOS
      cmake_minimum_required(VERSION 3.0)
      project(hoge)
      set(CMAKE_CXX_STANDARD 17)
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

          app.local_socket_path("/tmp/test.sock").multithreaded().run();
      }
    EOS
    system "cmake", "-B", "build", "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
    system "cmake", "--build", "build"
  end
end
