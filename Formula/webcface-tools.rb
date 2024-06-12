class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v1.4.4.tar.gz"
  sha256 "217d85544217e353b4bcaa4f2dfc3379602f12eac1c26af3c7a5178f36c0418d"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-1.4.4"
    sha256 cellar: :any,                 arm64_sonoma: "e2e5d2ce44a7f2e7f0f5d00971d16b7dd8887e126d2084939fdbed816966274f"
    sha256 cellar: :any,                 ventura:      "9679ad00482e9dcdb5716dc3a14761c2beb36ea72a761678d5b2141cfaa2c219"
    sha256 cellar: :any,                 monterey:     "2df76e04b75831473b481814eb7d75513b12801e24e66c8e8db92016757a7390"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "657dfa2b4bde0b114d58daf3a57116524c3b389d556670cb830d8c9dad5b6bb8"
  end

  depends_on "cmake" => :build
  depends_on "webcface"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args,
      "-DFETCHCONTENT_FULLY_DISCONNECTED=OFF", "-DHOMEBREW_ALLOW_FETCHCONTENT=ON"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_predicate bin/"webcface-launcher", :exist?
  end
end
