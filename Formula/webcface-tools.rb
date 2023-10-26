class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v1.1.2.tar.gz"
  sha256 "5e5232dd027152a97332e8881c71c31b2ecff93b96eec876804f9b0b7115c93b"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-1.1.1"
    sha256 cellar: :any,                 ventura:      "bf1e9790ae729ba5452870e39cd4de9f98a49c389af70649c119c2089a9538d7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ab19d924b0e1bfab8f923b835a40ed2e270be021aafd7cec0830a3c209b8ed23"
  end

  depends_on "cmake" => :build
  depends_on "webcface"

  def install
    rmdir(%w[external/tiny-process-library external/tomlplusplus external/cli11])
    system "git", "clone", "https://gitlab.com/eidheim/tiny-process-library.git", "external/tiny-process-library"
    system "git", "clone", "https://github.com/marzer/tomlplusplus.git", "external/tomlplusplus"
    system "git", "clone", "https://github.com/CLIUtils/CLI11.git", "external/cli11"
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_predicate bin/"webcface-launcher", :exist?
  end
end
