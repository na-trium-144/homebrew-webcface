class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v1.2.1.tar.gz"
  sha256 "da057d82c6db9ea0989a879c0af9a03890b2692b0e6b888445245895ba3ac169"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-1.2.0"
    sha256 cellar: :any,                 ventura:      "44ba50386c17c32af586d4d42f18a170052346b141300fa49add54213eece6ff"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d213f8313d10d1b70148d9811ffd9fada6ae3b93cee2456b9be82041d9fce8a7"
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
