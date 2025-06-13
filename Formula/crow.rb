class Crow < Formula
  desc "Fast and Easy to use microframework for the web"
  homepage "https://crowcpp.org"
  url "https://github.com/na-trium-144/Crow.git",
    revision: "11bf7a0dfacc1df9f2fbfa5838828817ff58661b"
  version "1.2.1.2-1"
  license "BSD-3-Clause"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/crow-1.2.1.2-1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9ba98e37bd4fa05dcfb57250e1bef7f1b85339fd3036c8cfea4a4cf23325d040"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9e9ad8113fbc66be839432105ba7600ad5aafab9c7c11df9faeefb01654c089a"
    sha256 cellar: :any_skip_relocation, ventura:       "c41eac58afb797d1fce61cb70c3710d07732df4870cb887463bc2925313e4818"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "059cca0d096b9bf83867294ee33f748cd379f5b7cfef4c45387e4dbb181bab37"
  end

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
