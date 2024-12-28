class CrowUnixSocket < Formula
  desc "Fast and Easy to use microframework for the web"
  homepage "https://crowcpp.org/"
  url "https://github.com/na-trium-144/Crow.git",
    revision: "5f5372ed80860dfcef788972bb0fd3972f715842"
  version "1.2.0-1"
  license "BSD-3-Clause"
  revision 1

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/crow-unix-socket-1.2.0-1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "015b7e4094a553ada6485c44b5b41bc5a6873dbedf7d99c8da13620377a17cd0"
    sha256 cellar: :any_skip_relocation, ventura:      "9775270a4d4f0dbb76c9b9804748cde06f182dd81ede9d41075210f4fc2c06ed"
    sha256 cellar: :any_skip_relocation, monterey:     "a2957a55590f267fc43b361a5e86221d07276873199898e269f447e75057cd85"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "79d15f4228c8bfae47ab27638c67834648a98a904534ac1762c2765cb8cd8673"
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
