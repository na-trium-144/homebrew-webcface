class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "0585779ccace442e5a4f118c9bc12013bc33136b4a42083bccb82c4c9329e410"
  license "MIT"
  revision 2

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-2.2.0_1"
    sha256 cellar: :any, arm64_sequoia: "a756a0c6fd73cca44ea3fb77e65e5da98f38362ca6b8f242c0986adc9d3e7d85"
    sha256 cellar: :any, arm64_sonoma:  "58c44937a1fc9e98a0fdb553d327c3f648198cfc10d9111e2a19dafaaa060608"
    sha256 cellar: :any, ventura:       "8a01c267af0a1f461fbd706b0f7d8d55c1067220f195822e0f34d12cb1d45eed"
    sha256               x86_64_linux:  "aec78581195564452eda027d93210aa425208a08e10a57edf6ac55607f13f2a5"
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
