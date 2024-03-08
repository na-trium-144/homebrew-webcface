class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v1.4.2.tar.gz"
  sha256 "2b5eeb50197b6bf7814f4f9a448a065803261921e36277df56a50778bfef5cf8"
  license "MIT"
  revision 2

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-1.4.2_2"
    sha256 cellar: :any,                 arm64_sonoma: "a7d956426825f676d04ad4c61bb4e1c21188288e23c430ec3484395d5f786464"
    sha256 cellar: :any,                 ventura:      "88e4737600fb32249d2a14724c1681f15ab5015c3d1d06d0600446a323b13a7b"
    sha256 cellar: :any,                 monterey:     "8149361047a531e5d6ba9fcfb1a40702de17cd2993d9258a68b27ae6b0081533"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "20334454a984a177d99ad3ca109edf0448e3343e640cc130aa2dda3d9eb052d2"
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
