class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v1.4.5.tar.gz"
  sha256 "a2647fb28c862cef7954fac58bc2954990f1f4b3ecd77dd2b64aa3548e49c9d2"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-1.4.4_1"
    sha256 cellar: :any,                 arm64_sonoma: "c3d0f09848b7f2c998732cba6c40ade2cf5022ae8042cf8a7fb05f1ee0975206"
    sha256 cellar: :any,                 ventura:      "4b7af16b82e8363a5165ea549db1e0eced740f86ce61280ff2b6649318ec8bd6"
    sha256 cellar: :any,                 monterey:     "254997b0efe98c5895024f53eca01d59f5fb79d312fb1aca84a00a7347947cab"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "622eba12dcbb9a03c4cb87e7ddd4decebf23ae4c42804fcc9b4c97280cd3281b"
  end

  depends_on "cmake" => :build
  depends_on "webcface"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args,
      "-DFETCHCONTENT_FULLY_DISCONNECTED=OFF", "-DHOMEBREW_ALLOW_FETCHCONTENT=ON"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_predicate bin/"webcface-launcher", :exist?
  end
end
