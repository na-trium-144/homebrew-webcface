class Eventpp < Formula
  desc "Event Dispatcher and callback list for C++"
  homepage "https://github.com/wqking/eventpp"
  url "https://github.com/wqking/eventpp/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "d87aba67223fd9aced2ba55eb82bd534007e43e1b919106a53fcd3070fa125ea"
  license "Apache-2.0"

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
