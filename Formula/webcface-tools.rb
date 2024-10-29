class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v2.1.1.tar.gz"
  sha256 "070e29804cd3071bd3c2622fff515516e67c2445d86f81d6fe32dbc2def1423b"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-2.1.0"
    sha256 cellar: :any, arm64_sonoma: "6f1fa61327c0de6abbf284a80dad7f3a0ad8fe3b3d0f09ceefae895224bee0d3"
    sha256 cellar: :any, ventura:      "3cdf625d6032851ff84db8b838a38fda196fbbd5c58455eda77cdceffed1ed9b"
    sha256               x86_64_linux: "4fee516cdfe4c69fab43b3c7f1c1a44108ad73f513bf5e27e767800a4a44ff55"
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
