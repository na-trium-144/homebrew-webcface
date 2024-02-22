class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v1.4.0.tar.gz"
  sha256 "f9a6bb934d849cf556ca1615cdb12737f016e03346eba3f23b19a19116cb66d7"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-1.3.1_1"
    sha256 cellar: :any,                 arm64_sonoma: "20b1420beb99234d78acf6b7e0a232b1cf0d4a11cf81611da9f51586dba49af0"
    sha256 cellar: :any,                 ventura:      "49e3d728c080f8ce07d2f6d5f3382e6fd6127f1afa33129a2f0115b87f2e7007"
    sha256 cellar: :any,                 monterey:     "1608a45ce4086e5d00bd7ddc4e09b6b985fe86158c8450678c1e1bb033c5dffd"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4be766494d5ef90e8300a580f6d974f886cac7e150dbb5b469a4b24050337a92"
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
