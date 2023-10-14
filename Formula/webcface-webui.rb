class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.0.4/webcface-webui_1.0.4.tar.gz"
  sha256 "81589b1eff5a8d6022ae444e8a83ad0f97ab889dd73757ef7dedb8b8d3dcf372"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.0.3"
    sha256 cellar: :any_skip_relocation, ventura:      "833f57cf242abde97f7a55c8ef7c63cef3bb115137924840826823b3873456cc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d4a63e8991430e973902f4d7a507f4e1bab1571912c694eb1da34d070bfd08a5"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
