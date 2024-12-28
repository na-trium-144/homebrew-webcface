class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v2.1.3.tar.gz"
  sha256 "65b4f7a45524004f636bd663f2c84360c469f845c457529d3b1e45eb6877af95"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-2.1.3"
    sha256 cellar: :any, arm64_sonoma: "5755ac9190344fd9df961dce844848bd01b2241ee4ae6231cdf6a1a03bd10551"
    sha256 cellar: :any, ventura:      "57355db7d2c2d9fd06ae0b40b2ad8df034a964b2f60939373333b758c9441cb5"
    sha256               x86_64_linux: "7200b462b50b82fc2d9d01dac2772aba4b0bfd839398502e9ac6f1536cc1a9a0"
  end

  depends_on "cli11" => :build
  depends_on "cmake" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "tiny-process-library" => :build
  depends_on "ftxui"
  depends_on "spdlog"
  depends_on "tiny-process-library"
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
