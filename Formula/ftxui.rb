class Ftxui < Formula
  desc ":computer: C++ Functional Terminal User Interface. :heart:"
  homepage "https://github.com/ArthurSonzogni/FTXUI"
  url "https://github.com/ArthurSonzogni/FTXUI.git",
      revision: "6fafa2dfed9e1d5d4e56660206fec7fb8e1af7dd"
  version "5.0.0-66-gc5357ac"
  license "MIT"

  depends_on "cmake" => [:build, :test]

  def install
    File.open('CMakeLists.txt', 'a') do |file|
      file.puts "set_target_properties(screen PROPERTIES VERSION v5.0.0.82)\n"
      file.puts "set_target_properties(dom PROPERTIES VERSION v5.0.0.82)\n"
      file.puts "set_target_properties(component PROPERTIES VERSION v5.0.0.82)\n"
    end
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DBUILD_SHARED_LIBS=ON"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"CMakeLists.txt").write <<~EOS
      cmake_minimum_required (VERSION 3.11)
      project(ftxui-starter LANGUAGES CXX VERSION v5.0.0.82)
      find_package(ftxui 5 REQUIRED)
      add_executable(ftxui-starter src/main.cpp)
      target_link_libraries(ftxui-starter
        PRIVATE ftxui::screen
        PRIVATE ftxui::dom
        PRIVATE ftxui::component # Not needed for this example.
      )
    EOS
    (testpath/"src"/"main.cpp").write <<~EOS
      #include <ftxui/dom/elements.hpp>
      #include <ftxui/screen/screen.hpp>
      #include <iostream>

      int main(void) {
        using namespace ftxui;

        // Define the document
        Element document =
          hbox({
            text("left")   | border,
            text("middle") | border | flex,
            text("right")  | border,
          });

        auto screen = Screen::Create(
          Dimension::Full(),       // Width
          Dimension::Fit(document) // Height
        );
        Render(screen, document);
        screen.Print();

        return EXIT_SUCCESS;
      }
    EOS
    system "cmake", "-B", "build"
    system "cmake", "--build", "build"
    system "build/ftxui-starter"
  end
end
