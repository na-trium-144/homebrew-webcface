class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v1.4.5.tar.gz"
  sha256 "a2647fb28c862cef7954fac58bc2954990f1f4b3ecd77dd2b64aa3548e49c9d2"
  license "MIT"
  revision 2

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-1.4.5_2"
    sha256 cellar: :any,                 arm64_sonoma: "696c020df955f104398145ee8591c451a4933c7961dbd117a4d15dc5fb430469"
    sha256 cellar: :any,                 ventura:      "0812ec67d55bd093f531240be334c5bef44870b233779105eea6f346eb1bcf04"
    sha256 cellar: :any,                 monterey:     "03f1fcf62bbb4de6b9580dbaa184536315716cbc2567593a73b86b50a87afbc9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dcbe2f6cbdd4e45cbd54857c35e323d3976715e8c56f568b30ea80d91453306e"
  end

  depends_on "cmake" => :build
  depends_on "webcface@1"

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
