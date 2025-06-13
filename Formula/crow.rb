class Crow < Formula
  desc "Fast and Easy to use microframework for the web"
  homepage "https://crowcpp.org"
  url "https://github.com/na-trium-144/Crow.git",
    revision: "11bf7a0dfacc1df9f2fbfa5838828817ff58661b"
  version "1.2.1.2-1"
  license "BSD-3-Clause"

  depends_on "cmake" => :build
  depends_on "asio"

  def install
    system "cmake", "-S", ".", "-B", "build",
           "-DCROW_BUILD_EXAMPLES=OFF", "-DCROW_BUILD_TESTS=OFF", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <crow.h>
      int main() {
        crow::SimpleApp app;
        CROW_ROUTE(app, "/")([](const crow::request&, crow::response&) {});
      }
    CPP

    system ENV.cxx, "test.cpp", "-std=c++17", "-o", "test"
    system "./test"
  end
end
