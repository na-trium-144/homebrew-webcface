class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v1.4.2.tar.gz"
  sha256 "2b5eeb50197b6bf7814f4f9a448a065803261921e36277df56a50778bfef5cf8"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-1.4.2"
    sha256 cellar: :any,                 arm64_sonoma: "7afb8e1c855d3117a360b1f2b67ec9aaeee38ef87bb2de58a607665c31969918"
    sha256 cellar: :any,                 ventura:      "48b492bf39e9aff063471c0efad62c839d060320d00d819c881124b7ae799960"
    sha256 cellar: :any,                 monterey:     "834a387529241705d64f3d1f8ae3dada4f73be1f1eb26561080b29698f8d794c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "264866d609c14f51e60e6854dbf3fab247b8759ce5e2908fd947c304929fc724"
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
