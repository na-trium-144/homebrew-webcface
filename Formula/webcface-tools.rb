class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v2.1.3.tar.gz"
  sha256 "65b4f7a45524004f636bd663f2c84360c469f845c457529d3b1e45eb6877af95"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-2.1.2_1"
    sha256 cellar: :any, arm64_sonoma: "2f0b9792913b1be62a4eefff60b13f88a842b0b3a3defa3b10596a4591b1182e"
    sha256 cellar: :any, ventura:      "8a688f8ee4379d0734fe2cc4aefeae5347a33f31cff5a28fb2b6ced703e6e2a0"
    sha256               x86_64_linux: "e3ea80d59fada63adad6575c4d0314ace27996cb862ebd98a4e9b66a258810d6"
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
