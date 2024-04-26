class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v1.4.4.tar.gz"
  sha256 "217d85544217e353b4bcaa4f2dfc3379602f12eac1c26af3c7a5178f36c0418d"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-1.4.3"
    sha256 cellar: :any,                 arm64_sonoma: "8b7987338fd49740019f02d2433a2aa1a56f113477e1b089aed5f46be413bffb"
    sha256 cellar: :any,                 ventura:      "aa41f647852cf50060c71b4bf7d93cd55bd9782e93e546ec2979d6d34939360e"
    sha256 cellar: :any,                 monterey:     "95903ffe688d378df2cc1279704f9ddca1691acfbc1c4e0bdc88b574feafbb22"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5e75ed4f91956d85abaf3024a195514d091828dc2e77705dbd96e4f591759304"
  end

  depends_on "cmake" => :build
  depends_on "webcface"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DFETCHCONTENT_FULLY_DISCONNECTED=OFF"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_predicate bin/"webcface-launcher", :exist?
  end
end
