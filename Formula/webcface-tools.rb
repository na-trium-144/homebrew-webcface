class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v1.4.5.tar.gz"
  sha256 "a2647fb28c862cef7954fac58bc2954990f1f4b3ecd77dd2b64aa3548e49c9d2"
  license "MIT"
  revision 2

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-1.4.5_1"
    sha256 cellar: :any,                 arm64_sonoma: "62a3f0ea9fa1a49e86ffe2fce681286acf2439bf3f9e67c3171bee0401aef0b9"
    sha256 cellar: :any,                 ventura:      "d528f7a930dfbe20c051e0c37dd838877eedba44eb1a3fc067a9b8155b4462b3"
    sha256 cellar: :any,                 monterey:     "dd123dff6d5ffd9c801c91994905f4f364f3dead2a0cdba8aa25436008c1776e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "29a16c3dc78a601c080b65f5fa45ac75668ac20569b65ab2ecfcbbd6dcbd4f46"
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
