class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v1.4.2.tar.gz"
  sha256 "2b5eeb50197b6bf7814f4f9a448a065803261921e36277df56a50778bfef5cf8"
  license "MIT"
  revision 4

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-1.4.2_3"
    sha256 cellar: :any,                 arm64_sonoma: "60c031a11978e02342db0f99e06d82720d2dd3ab64b7d2fc989e935a98386c26"
    sha256 cellar: :any,                 ventura:      "c6a5812dcb771412ee29ad86fe18eab237740abf2601269eff3fa357c306c404"
    sha256 cellar: :any,                 monterey:     "3257f0bb63dbd0bb238a05e5aa739d6290f5c8f2e51c0d8509fb8398341ed756"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "12c2758087a3f84078ddd6378b4307b453b06913db0e0d84f6c1175c8289fd54"
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
