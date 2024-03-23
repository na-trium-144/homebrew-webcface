class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v1.4.2.tar.gz"
  sha256 "2b5eeb50197b6bf7814f4f9a448a065803261921e36277df56a50778bfef5cf8"
  license "MIT"
  revision 4

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-1.4.2_4"
    sha256 cellar: :any,                 arm64_sonoma: "bb0aac16ff4d5d0ad18fd413032886cbe0ec46fe75b0c587f613b9df51805988"
    sha256 cellar: :any,                 ventura:      "e85f1b8ea5d806873137bd4ad7b6fbd8c58def57ccdf080d1cf1f9b1b72b7394"
    sha256 cellar: :any,                 monterey:     "e74814d81fb70dd02ea304f47b7c5c2be1778209605d9623a9f2afb8368500ae"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8f624583140541d0b9cac512d0ac736a789e984fd53bfe4269795214de0f3719"
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
