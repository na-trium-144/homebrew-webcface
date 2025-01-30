class Ftxui < Formula
  desc ":computer: C++ Functional Terminal User Interface. :heart:"
  homepage "https://github.com/ArthurSonzogni/FTXUI"
  url "https://github.com/ArthurSonzogni/FTXUI.git",
      revision: "15587dad01a9ef0e5e79d97a16adf414f60669a5"
  version "5.0.0-86-g15587da"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/ftxui-5.0.0-84-gc89569f"
    sha256 cellar: :any,                 arm64_sequoia: "761b03e0c929a29f908c2ef4d02c8d8c1e14c7895aff49d31a5a30a7669e7fb2"
    sha256 cellar: :any,                 arm64_sonoma:  "2ace5edffa6e99919ec6e3e8aeff29d93cf84945393869929c8280e36637352d"
    sha256 cellar: :any,                 ventura:       "433988dc1bc97527adea9a54de8ffc91460fd3c1d3c28a7320c115defc0d72ae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d1b15e5995642de84de01b7889f7ca34ea4db6ca36fc83689e5bbaa9d906bc12"
  end

  depends_on "cmake" => [:build, :test]

  def install
    File.open("CMakeLists.txt", "a") do |file|
      file.puts "set_target_properties(screen PROPERTIES VERSION 5.0.0.86)\n"
      file.puts "set_target_properties(screen PROPERTIES INSTALL_RPATH \"$ORIGIN/;@loader_path/\")\n"
      file.puts "set_target_properties(dom PROPERTIES VERSION 5.0.0.86)\n"
      file.puts "set_target_properties(dom PROPERTIES INSTALL_RPATH \"$ORIGIN/;@loader_path/\")\n"
      file.puts "set_target_properties(component PROPERTIES VERSION 5.0.0.86)\n"
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
