class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "0585779ccace442e5a4f118c9bc12013bc33136b4a42083bccb82c4c9329e410"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-2.1.3_1"
    sha256 cellar: :any, arm64_sequoia: "47220dc072aaad1037d8c11aaef25ff2d0b2399bc71a4e18d7dbe3cce9ba36f6"
    sha256 cellar: :any, arm64_sonoma:  "a7ee776479a262e8bea9d4cf43e48f2bcce3f3b61f6398980a0db5e63ba4f9ef"
    sha256 cellar: :any, ventura:       "c1cac689923e0a89bc96076e06a82e1a9c6207df34719c2cb1ed1758ef2cae22"
    sha256               x86_64_linux:  "b0564f7a2e3debdb02d964890bb4d4d652178026485b9804b881923d95639cf4"
  end

  depends_on "cli11" => :build
  depends_on "cmake" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "fmt"
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
