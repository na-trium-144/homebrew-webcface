class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "8608296b14976db3cc7a089cc6d520c795b045a4a1d217c152997af50546c1d7"
  license "MIT"

  depends_on "cli11" => :build
  depends_on "cmake" => :build
  depends_on "ftxui-static" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "tomlplusplus" => :build
  depends_on "spdlog"
  depends_on "tiny-process-library"
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
