class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v1.1.7.tar.gz"
  sha256 "55d1b90934ad8ff052a5f237695b90cbd29217fce8bdaebcb36a8d887397830a"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-1.1.7"
    sha256 cellar: :any,                 ventura:      "5b91d5f410dbf66222b079f200f437620322a4a411c598ad8a8c8c12aeafae2c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8eb84c89fd597cc06cfef714c319b284506eb51e8064b256bb4fc383bc4225c9"
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
