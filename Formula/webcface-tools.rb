class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v2.1.2.tar.gz"
  sha256 "89324efbdf9203480a812f731fe4b84a7a657232a3d406d3c2e9be479a7f46f4"
  license "MIT"
  revision 1

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-tools-2.1.2"
    sha256 cellar: :any, arm64_sonoma: "023fcebbcce74c3fb5df99ca97641afd444fd890e02ed681a7880e8c9459d46b"
    sha256 cellar: :any, ventura:      "96fab593ad38f99fa739a4f0c7f33cf084a5f8f5a61716d5b8690ed4080dabc1"
    sha256               x86_64_linux: "ef3f473c45034f643ffe18d16e6c6b7107a4c52b831e7417ff4d54492172b053"
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
