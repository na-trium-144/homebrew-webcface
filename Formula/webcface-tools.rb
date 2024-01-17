class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v1.2.1.tar.gz"
  sha256 "da057d82c6db9ea0989a879c0af9a03890b2692b0e6b888445245895ba3ac169"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-1.2.1"
    sha256 cellar: :any,                 ventura:      "bf13b1464b4938e34a88bcc7e5e093325c04929152e31a53b904aa5d099fbbb4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b8cdba261d6f12d8f47746d802e2018e06b93e8326c9dfea777e5d4216701cad"
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
