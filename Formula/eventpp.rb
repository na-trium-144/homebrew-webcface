class Eventpp < Formula
  desc "Event Dispatcher and callback list for C++"
  homepage "https://github.com/wqking/eventpp"
  url "https://github.com/wqking/eventpp/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "d87aba67223fd9aced2ba55eb82bd534007e43e1b919106a53fcd3070fa125ea"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/eventpp-0.1.3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "74f924f30d123a2844a57b187093bc4824f230df3c65346a66563dbadf08c7b6"
    sha256 cellar: :any_skip_relocation, ventura:      "b92376ba0616aa7ef41c769c4348f1e6d2f9c6d2d8d816876229c253c2763b71"
    sha256 cellar: :any_skip_relocation, monterey:     "a1b76c409f0628542e1d6eb67cc8362a5115348d380a1ac3049c3c727a80884b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0ffd61ab90c33f886c8f9f01c1226c5e58277e93b47fe8e1d7ec696616ed41d7"
  end

  depends_on "cmake" => [:build, :test]

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build", "-t", "install"
  end

  test do
    (testpath/"CMakeLists.txt").write <<~EOS
      cmake_minimum_required(VERSION 3.0)
      project(hoge)
      set(CMAKE_CXX_STANDARD 11)
      find_package(eventpp)
      add_executable(hoge ${CMAKE_CURRENT_SOURCE_DIR}/test.cpp)
      target_link_libraries(hoge eventpp::eventpp)
    EOS
    (testpath/"test.cpp").write <<~EOS
      #include "eventpp/callbacklist.h"
      #include <iostream>
      int main(){
        eventpp::CallbackList<void (const std::string &, const bool)> callbackList;
        callbackList.append([](const std::string & s, const bool b) {
            std::cout << std::boolalpha << "Got callback 1, s is " << s << " b is " << b << std::endl;
        });
        callbackList.append([](std::string s, int b) {
            std::cout << std::boolalpha << "Got callback 2, s is " << s << " b is " << b << std::endl;
        });
        callbackList("Hello world", true);
      }
    EOS
    system "cmake", "-B", "build"
    system "cmake", "--build", "build"
    system "./build/hoge"
  end
end
