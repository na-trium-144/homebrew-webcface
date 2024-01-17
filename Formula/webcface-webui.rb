class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.3.1/webcface-webui_1.3.1.tar.gz"
  sha256 "1a983cb9698e6cdaff218194eb30b7cfe269371600cccd50033f1be7cb17268f"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.3.1"
    sha256 cellar: :any_skip_relocation, ventura:      "3e53813a512383a2d5e45ba9ff49801fa6e7d30c1677fc17d8179289a4fed580"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b20b287b4965259fff6e06860de266997120bed48eb128aab7468c7261e88b3b"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
