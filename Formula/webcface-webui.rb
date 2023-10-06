class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.0.3/webcface-webui_1.0.3.tar.gz"
  sha256 "716ee866ffdb870fb1c2c1240a51837f05f593c6acd4138778d5e841e769b946"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.0.2"
    sha256 cellar: :any_skip_relocation, ventura:      "a908110affacee40de9f651e4917229bd63c1c38d244c3f62498d83f9d84228c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4fcb95bb4103aaa34c9e76fc43d7ff619f9a5edc35e80c30e35f7341431a7eca"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
