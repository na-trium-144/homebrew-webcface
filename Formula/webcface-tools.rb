class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "a0944858b65dc933be9b68069138984966ee4f59114c343be5c78f0833848d39"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-1.0.0"
    sha256 cellar: :any,                 ventura:      "6551d48ce8278a744fbaa5a1a1ab9616680842a8e814d3138c7f77c0cd7b6dfe"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5d863e661a892420ec2bd43f1840227b335933a0cb4ce4d932ea1f9272b6550a"
  end

  depends_on "cmake" => :build
  depends_on "webcface"

  def install
    rmdir(%w[external/tiny-process-library external/tomlplusplus])
    system "git", "clone", "https://gitlab.com/eidheim/tiny-process-library.git", "external/tiny-process-library"
    system "git", "clone", "https://github.com/marzer/tomlplusplus.git", "external/tomlplusplus"
    system "git", "clone", "https://git.code.sf.net/p/tclap/code", "external/tclap"
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_predicate bin/"webcface-launcher", :exist?
  end
end
