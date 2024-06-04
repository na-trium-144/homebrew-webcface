class CrowUnixSocket < Formula
  desc "A Fast and Easy to use microframework for the web."
  homepage "https://crowcpp.org/"
  url "https://github.com/na-trium-144/Crow.git",
    revision: "5f5372ed80860dfcef788972bb0fd3972f715842"
  version "1.2.0-1"
  license "BSD-3-Clause"

  depends_on "asio"
  depends_on "cmake" => [:build, :test]

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
