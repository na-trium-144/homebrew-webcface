class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v1.1.4.tar.gz"
  sha256 "f9ff88aa15c335b6fdba0a9a0a653d947e64348cd5d6bc76fd6fa47ceec86326"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-1.1.4"
    sha256 cellar: :any,                 ventura:      "6969bef0f618746721d6bf934f77ba38197219c6c24bd67b06160261d8b9491f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "625ef109cd23129fa190f25bebfac137d2f228bf48c6aaef3836ac28e672b093"
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
