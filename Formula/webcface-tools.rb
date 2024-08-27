class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v2.0.1.tar.gz"
  sha256 "a43a82747ca60ea12a181845b620b63e8f13a330d157efb2cbb6be1a70f1a8fa"
  license "MIT"

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
