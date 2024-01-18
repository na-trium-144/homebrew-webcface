class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "f5918c7d018a4b7c70d4ea6481d15c65ba9954eaf998845d720494e48a76181c"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-1.2.1_1"
    sha256 cellar: :any,                 ventura:      "0d8fa1c7b90dde44d5481a1ad437a51c8d763780c61b8c9d14ed4670ef8075a8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "52c3f5d19e93970970160559e9487fff125814652eac40c41b1a8bbda5de353a"
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
