class TinyProcessLibraryStatic < Formula
  desc "Small platform independent library to create and stop new processes in C++"
  homepage "https://gitlab.com/eidheim/tiny-process-library/"
  url "https://gitlab.com/eidheim/tiny-process-library.git",
      revision: "6166ba5dce461438cefb57e847832aca25d510d7"
  version "2.0.4-28-g6166ba5"
  license "MIT"

  depends_on "cmake" => [:build, :test]

  def install
    # tiny-process-libraryはVERSIONもSOVERSIONも指定していないので
    # (Homebrewのrequirementsには反するが) staticライブラリとしてビルドする。
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DBUILD_SHARED_LIBS=OFF"
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
