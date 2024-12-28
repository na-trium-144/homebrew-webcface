class Ftxui < Formula
  desc ":computer: C++ Functional Terminal User Interface. :heart:"
  homepage "https://github.com/ArthurSonzogni/FTXUI"
  url "https://github.com/ArthurSonzogni/FTXUI.git",
      revision: "6fafa2dfed9e1d5d4e56660206fec7fb8e1af7dd"
  version "5.0.0-82-g6fafa2d"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/ftxui-5.0.0-82-g6fafa2d"
    sha256 cellar: :any,                 arm64_sequoia: "064387d98e5f1e3d8af1f8cc452cfa7b2a10b18738d027edc839a12192c4e987"
    sha256 cellar: :any,                 arm64_sonoma:  "c9ba162858b3125317748f5371afd7fc63e673957b235c42337413f50f7bbc92"
    sha256 cellar: :any,                 ventura:       "9510c1ba0092bb29ea40f30d4ae29857071788c701cce3e1d8568a6ef1301cca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1a156fe807ddece1ee54f6098b1572a2ccd63a574ecf71ff1c35d50b1db8aeea"
  end

  depends_on "cmake" => [:build, :test]

  def install
    File.open("CMakeLists.txt", "a") do |file|
      file.puts "set_target_properties(screen PROPERTIES VERSION 5.0.0.82)\n"
      file.puts "set_target_properties(screen PROPERTIES INSTALL_RPATH \"$ORIGIN/;@loader_path/\")\n"
      file.puts "set_target_properties(dom PROPERTIES VERSION 5.0.0.82)\n"
      file.puts "set_target_properties(dom PROPERTIES INSTALL_RPATH \"$ORIGIN/;@loader_path/\")\n"
      file.puts "set_target_properties(component PROPERTIES VERSION 5.0.0.82)\n"
      file.puts "set_target_properties(component PROPERTIES INSTALL_RPATH \"$ORIGIN/;@loader_path/\")\n"
    end
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DBUILD_SHARED_LIBS=ON"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"CMakeLists.txt").write <<~EOS
      cmake_minimum_required (VERSION 3.11)
      project(ftxui-starter LANGUAGES CXX VERSION 1.0.0)
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
