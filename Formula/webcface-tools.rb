class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "f5918c7d018a4b7c70d4ea6481d15c65ba9954eaf998845d720494e48a76181c"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-1.3.0"
    sha256 cellar: :any,                 ventura:      "47386c1f0312b832f7de18ee1a320e990ad2f38a22dbc5fd1a61217832490543"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9da36fc3e52e0ff2afdef2ac834f097694f0d52ef65e4cf36dd8cbdf884f296c"
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
