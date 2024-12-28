class TinyProcessLibrary < Formula
  desc "Small platform independent library to create and stop new processes in C++"
  homepage "https://gitlab.com/eidheim/tiny-process-library/"
  url "https://gitlab.com/eidheim/tiny-process-library.git",
      revision: "6166ba5dce461438cefb57e847832aca25d510d7"
  version "2.0.4-28-g6166ba5"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/tiny-process-library-2.0.4-28-g6166ba5"
    sha256 cellar: :any,                 arm64_sequoia: "2209bb951b58fe798f39f84ddfcb708dec7af143e9edd56d028c68b037b19d31"
    sha256 cellar: :any,                 arm64_sonoma:  "03aca76f7f43ca6624852a604a0fcf9d117873d26536f5cc205bdf6f4648767c"
    sha256 cellar: :any,                 ventura:       "69d86da151fa6fd0e0d0abd90bbb057539cc84e7252b7a0eee6bed9206734142"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e781b154ca0d3107d215304c0b53fda3efe1a830c955964bafedc541803ae084"
  end

  depends_on "cmake" => [:build, :test]

  def install
    File.open("CMakeLists.txt", "a") do |file|
      file.puts "set_target_properties(tiny-process-library PROPERTIES VERSION 2.0.4.28)\n"
    end
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DBUILD_SHARED_LIBS=ON"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    resource "examples.cpp" do
      url "https://gitlab.com/eidheim/tiny-process-library/-/raw/6166ba5dce461438cefb57e847832aca25d510d7/examples.cpp"
      sha256 "a72c6709a3e9562e0bdb0864827f2ab9cc9c830aa7802c93e4ecab02d3234c80"
    end

    resource("examples.cpp").stage do
      File.write "CMakeLists.txt", <<~EOS
        cmake_minimum_required (VERSION 3.5)
        project(example LANGUAGES CXX)
        set(CMAKE_CXX_STANDARD 11)
        find_package(tiny-process-library REQUIRED)
        find_package(Threads REQUIRED)
        add_executable(example examples.cpp)
        target_link_libraries(example tiny-process-library::tiny-process-library)
      EOS
      system "cmake", "-B", "build"
      system "cmake", "--build", "build"
    end
  end
end
