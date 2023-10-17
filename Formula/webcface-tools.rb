class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "a0944858b65dc933be9b68069138984966ee4f59114c343be5c78f0833848d39"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-1.1.0"
    sha256 cellar: :any,                 ventura:      "84c653b5a3e2b7c49637289283d86ba673b35ab02ecf2255fb78ec0cee37f578"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f3194d800dc9c431f83e0eddd0a18a872d87c6b69d7f2378a36e16f8ae11ee53"
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
