class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v1.4.2.tar.gz"
  sha256 "2b5eeb50197b6bf7814f4f9a448a065803261921e36277df56a50778bfef5cf8"
  license "MIT"
  revision 2

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-1.4.2_1"
    sha256 cellar: :any,                 arm64_sonoma: "4a423acc037bd57ee11721a9702e05056f8cf976be348a506dc01b8f96947a0a"
    sha256 cellar: :any,                 ventura:      "5948a73e7c148f0c904857988be185adb1e0125b9276ca9e13bb56c599177463"
    sha256 cellar: :any,                 monterey:     "17fd2509c1e627f1d13c10b6a674bff0e54ef2d325da3f94825f2360c29af7fd"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6ec6e86c6eb3880b4a037ec8b5dfc296d2fb90589f09460423795fd7da7b6563"
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
