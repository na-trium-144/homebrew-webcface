class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v2.0.1.tar.gz"
  sha256 "a43a82747ca60ea12a181845b620b63e8f13a330d157efb2cbb6be1a70f1a8fa"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-2.0.1"
    sha256 cellar: :any, arm64_sonoma: "bceb3281b214e6080b3dd9515b41823e35a28c2ecead0b74eabc16988aa6a5fc"
    sha256 cellar: :any, ventura:      "02851c5a72869a6eecd1eafa11dac625be11d1892f13d98a6150fd5c1596f021"
    sha256 cellar: :any, monterey:     "4bb542fc608c97a9e947e654631a3bbebdd896db00dbbaa2184afb2578e0abdd"
    sha256               x86_64_linux: "c51a90686471bfd6001a9fddfba15b40d4fd9c6864a5bb21beb9a36b75bba541"
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
