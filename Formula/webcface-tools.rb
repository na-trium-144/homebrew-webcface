class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v1.3.1.tar.gz"
  sha256 "c6a41939696781c907927ce9225518c43fa9e0b10cdd0f0ae57b8e259349e749"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-1.3.1"
    sha256 cellar: :any,                 arm64_sonoma: "55439523d919b3072477d89a856cc79f854f9e6184f3c1d7220e85a52ba5215e"
    sha256 cellar: :any,                 ventura:      "13a1af6290d9f63f536b63cafc9425bf2061d99856f0b00bff4996992f3a424d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "621562bd450f8ced05cd2a27b3eed9eb22ce6005320337396b793e0e6965a1a3"
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
