class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v2.1.1.tar.gz"
  sha256 "070e29804cd3071bd3c2622fff515516e67c2445d86f81d6fe32dbc2def1423b"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-2.1.1"
    sha256 cellar: :any, arm64_sonoma: "6fdae72e875dd5b89650f8f4efd783f4a7bfcdc51ddb085869dd6ea69fefbf09"
    sha256 cellar: :any, ventura:      "307ff1e4f5a9cbabe657fc139b1325c31b595fa823a3d4f6ae6b604460de168f"
    sha256               x86_64_linux: "f2d73416632ea08b06e2542aa07a8805e9118a5f8ebd0053bb64739263f0550e"
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
