class Ftxui < Formula
  desc ":computer: C++ Functional Terminal User Interface. :heart:"
  homepage "https://github.com/ArthurSonzogni/FTXUI"
  url "https://github.com/ArthurSonzogni/FTXUI.git",
      revision: "5bf8ee819b25197aff56a170c100cb05a64e6714"
  version "5.0.0-98-g5bf8ee8"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/ftxui-5.0.0-86-g15587da"
    sha256 cellar: :any,                 arm64_sequoia: "4804dc61555d84b12294e6f580821b439d18e5ba248a62c47b77547e9d0d6e92"
    sha256 cellar: :any,                 arm64_sonoma:  "fb4b98a5e2bdd851b8e518fa0cd57d308b8bef037b9b0c19a61092ebe132ac86"
    sha256 cellar: :any,                 ventura:       "aed8e6eb02045c3d426657acee2e18e6078f6f1ae7574168e0b86224892242a3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "47f27ea059ef2a6154971d83bc52466beba03ed07a9cae3f58debf7eee72fee8"
  end

  depends_on "cmake" => [:build, :test]

  def install
    File.open("CMakeLists.txt", "a") do |file|
      file.puts "set_target_properties(screen PROPERTIES VERSION 5.0.0.98)\n"
      file.puts "set_target_properties(screen PROPERTIES INSTALL_RPATH \"$ORIGIN/;@loader_path/\")\n"
      file.puts "set_target_properties(dom PROPERTIES VERSION 5.0.0.98)\n"
      file.puts "set_target_properties(dom PROPERTIES INSTALL_RPATH \"$ORIGIN/;@loader_path/\")\n"
      file.puts "set_target_properties(component PROPERTIES VERSION 5.0.0.98)\n"
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
