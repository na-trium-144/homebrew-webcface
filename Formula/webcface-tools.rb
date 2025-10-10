class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v3.0.0.tar.gz"
  sha256 "55e7fe7d32144b17066b5060d1505c2e4a4ddd31cc607fb262f68c63b6621ff1"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-2.3.0"
    sha256 cellar: :any, arm64_sequoia: "31576c5c96f5cc213974e8e13cde41b6cfded14f947dc4b76a230fc4ab7b1afb"
    sha256 cellar: :any, arm64_sonoma:  "4fc2a73658d62241fdeff80ce426183233faa5f40fb717693088ff653cc68582"
    sha256 cellar: :any, ventura:       "9dd590968e698d339b751553914f7d063798669f3cf00470cf5525bd0f7e3d5d"
    sha256               x86_64_linux:  "9312cf645fab8ac7e8493b4110e0f33ee86a1e1a9a2434149cc30f15ec01c10e"
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
