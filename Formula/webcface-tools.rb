class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "2f3faf974a5c2c3121ca9e8b0266781df5b6f43108df2b926b4b226534948dd4"
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
