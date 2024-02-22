class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v1.4.0.tar.gz"
  sha256 "f9a6bb934d849cf556ca1615cdb12737f016e03346eba3f23b19a19116cb66d7"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-1.4.0"
    sha256 cellar: :any,                 arm64_sonoma: "33c1b467e815b2ac557ba03f0b7c98678cda83717003b142552d1a9463cf2266"
    sha256 cellar: :any,                 ventura:      "99ea57b80db32fee1479e1df3195ce5976e62e0efe4a59b09d52dd0249317881"
    sha256 cellar: :any,                 monterey:     "05748926d358daab61cdf200691496437c2e8adb5113f019ca07f98d066934ad"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ee21c20283a97999e087c5ef83baec48b2e5c7b0ab13742955fa608aaa183068"
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
