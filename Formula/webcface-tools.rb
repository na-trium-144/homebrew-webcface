class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v1.1.7.tar.gz"
  sha256 "55d1b90934ad8ff052a5f237695b90cbd29217fce8bdaebcb36a8d887397830a"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-1.1.6"
    sha256 cellar: :any,                 ventura:      "451f644e94e4707b054b3eeea901d0369d1b3940558e19411a42a90d3c66381e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "68565bc53b9e5b203d6d42b76f893a64b578b9645ee5a1f446223d16b4512015"
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
