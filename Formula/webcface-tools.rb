class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v2.1.0.tar.gz"
  sha256 "bda5dc34beaa1101485c99635d0093557cd992585999095e85eefecd52777c00"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-2.0.1_1"
    sha256 cellar: :any, arm64_sonoma: "249e0c5d45035fd7fac51a33f082a27f57ce66a1f2b67db97b95145788eb81f3"
    sha256 cellar: :any, ventura:      "bcb451eed03905c315042ed2ab4d57a75645c73535397f7a79d4b8aab0eb4425"
    sha256 cellar: :any, monterey:     "43514ee49b91b3e81953fbba55a82ca77ad8374273dac4d4d400a3f420804290"
    sha256               x86_64_linux: "c66fcd8da376d52845ef38943de1256b5786a8a4eb286ea41dffccb90aa95dc5"
  end

  depends_on "cli11" => :build
  depends_on "cmake" => :build
  depends_on "ftxui-static" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "tiny-process-library-static" => :build
  depends_on "spdlog"
  depends_on "tomlplusplus"
  depends_on "webcface@2"

  def install
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    system "#{bin}/webcface-launcher", "-h"
    system "#{bin}/webcface-send", "-h"
    system "#{bin}/webcface-tui", "-h"
    system "#{bin}/webcface-ls", "-h"
  end
end
