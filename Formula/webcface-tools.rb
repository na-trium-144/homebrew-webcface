class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "0585779ccace442e5a4f118c9bc12013bc33136b4a42083bccb82c4c9329e410"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-2.2.0"
    sha256 cellar: :any, arm64_sequoia: "dc3c6f00a991bae07e1ce27166a68a444d6c2fa1ba654f901fcff1d3551cdbdb"
    sha256 cellar: :any, arm64_sonoma:  "f64fc254b6c7e048ff600a8758bf2ac4d885afca1628746fdfa1cacb52b7d434"
    sha256 cellar: :any, ventura:       "da63413cdcc83912430caacf4342e39b81546b58646171056e9317c10c70c3d4"
    sha256               x86_64_linux:  "7ea5622ca1dcab57aa34aafe6fe6dd95c32c24230ac4bc434b76e1335598d36e"
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
