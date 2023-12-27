class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v1.1.7.tar.gz"
  sha256 "55d1b90934ad8ff052a5f237695b90cbd29217fce8bdaebcb36a8d887397830a"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-1.1.7_1"
    sha256 cellar: :any,                 ventura:      "9c8f7d905b2de454a14a409b34caafb9016447a0c0bc0ed33305b29a6ed011bf"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6a72cce7d33af5589b2d3823543beebf7e95529a93f05dc3ec4fc33e02c05cf5"
  end

  depends_on "cmake" => :build
  depends_on "webcface"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_predicate bin/"webcface-launcher", :exist?
  end
end
