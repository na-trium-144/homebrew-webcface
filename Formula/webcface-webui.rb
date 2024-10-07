class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.9.1/webcface-webui_1.9.1.tar.gz"
  sha256 "53d9bfbf8b5af8935d16c907ae032107d16e767c49e3614561969d817896eb96"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.9.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "7ed965ebd1d4e4b1373f09f308a6d2005b20ddc87b896747d4ffd172e1960997"
    sha256 cellar: :any_skip_relocation, ventura:      "24c2b84ff3dfd0de519c073752aba25b0374757cfe66d0cbfa5da8ead6ee17e1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "77f523ec605cda5bd3dba94e9c1e6233d869d3a483258d8e78685665bf445b70"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
