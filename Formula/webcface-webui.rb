class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.0.5/webcface-webui_1.0.5.tar.gz"
  sha256 "41c59141c349462c306a0851d097269ad7203f5610ca515f91cb57fa3ccb971d"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.0.5"
    sha256 cellar: :any_skip_relocation, ventura:      "71e3f963d2927e6c2196414aa97d159b07a61c7862e597b1d18244f94d0f5bdf"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4be7995d0715fd1e130f0eb04b6afd93456c23fc4bbda6301d91d72537b53a1d"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
