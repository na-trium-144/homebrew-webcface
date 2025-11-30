class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v3.0.1.tar.gz"
  sha256 "d8ed95c69b3a914933492547dce7d9b55ebd7d094b959d47b42e0ab2878d02aa"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-3.0.1"
    sha256 cellar: :any, arm64_sequoia: "82a48f2ae3e9bac5016ffc28d418773f93a1575d53eebceaaa85d2f1a7c8e889"
    sha256 cellar: :any, arm64_sonoma:  "43d91129e7f09e0742dfdabb7f3d77a3751d6552491020c607010a8daa34ecaf"
    sha256               x86_64_linux:  "abe3a12149b6fd1d47b1d213f165cfda39d50e45f65600f7e41f316a7e336497"
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
  depends_on "webcface@3"

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
