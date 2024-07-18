class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v1.4.5.tar.gz"
  sha256 "a2647fb28c862cef7954fac58bc2954990f1f4b3ecd77dd2b64aa3548e49c9d2"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-1.4.5"
    sha256 cellar: :any,                 arm64_sonoma: "76956a6861d9bff564b03bb79ea35674cad8bc16a7c62f54ce3fddcd4d0ffcaa"
    sha256 cellar: :any,                 ventura:      "1591628c05ecbbb6a8422d9ef8a51440d81f9e79d06c1b084eb2cc433d183885"
    sha256 cellar: :any,                 monterey:     "9fa7e0bd7644dbf659c9fd1bfce52207ad6349234125ae07cc62fd0bca92df24"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8e1e26995419c43ec8a5409ba43c8f38fcbde7bbc9499e8c7950593694af8302"
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
