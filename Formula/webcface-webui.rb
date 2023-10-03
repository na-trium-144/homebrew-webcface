class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.0.2/webcface-webui_1.0.2.tar.gz"
  sha256 "edd67d18a73bda522c05de183ba7e2ca70d96a21d92406d9bf63d79b0acccd24"
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
