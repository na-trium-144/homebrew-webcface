class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v2.3.0.tar.gz"
  sha256 "5d208d89e38cb3d0a29c898c9f788e953aa2e72b49180267bfcab70660a3a8c1"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-2.2.0_2"
    sha256 cellar: :any, arm64_sequoia: "81c6fc1104ab0f6d627739d3d546f76fb0276579e31e258f5ab2448ed790161a"
    sha256 cellar: :any, arm64_sonoma:  "84b10fb018bb3d9c0fdc8acc552af7c8c305ffe7dd91485234e57eabb99a04b9"
    sha256 cellar: :any, ventura:       "608d290723441f4b4367d68dee4b46f3ffe7ad58f39cd3ec9dc26d0a69055861"
    sha256               x86_64_linux:  "a68a9461e0894ab7a38492361221db5b9c14e71d03f73b797e42bea6f9ee49a9"
  end

  depends_on "cli11" => :build
  depends_on "cmake" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "fmt"
  depends_on "ftxui"
  depends_on "sdl2"
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
