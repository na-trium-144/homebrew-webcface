class TinyProcessLibraryStatic < Formula
  desc "Small platform independent library to create and stop new processes in C++"
  homepage "https://gitlab.com/eidheim/tiny-process-library/"
  url "https://gitlab.com/eidheim/tiny-process-library.git",
      revision: "6166ba5dce461438cefb57e847832aca25d510d7"
  version "2.0.4-28-g6166ba5"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/tiny-process-library-static-2.0.4-28-g6166ba5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "66f1c04b1500802ecba9e17536ff4161dd0be716a0d4223dd7fdcf189bc110bf"
    sha256 cellar: :any_skip_relocation, ventura:      "1f2ed7747e4e5f0dbf52fbeb38a9661b815f6b3adfe169176e81d31c5b9afa31"
    sha256 cellar: :any_skip_relocation, monterey:     "f27101973476bb3b964c1ee58a3740517a5ca4d190ac4dd2adb1382e4f5ce5ce"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ecf1162d6ffd52016e117984bcbf124ad0edab1d8020a1ada73a67ca74a278a6"
  end

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
