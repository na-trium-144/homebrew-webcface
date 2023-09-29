class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.0.1/webcface-webui_1.0.1.tar.gz"
  sha256 "c570b7a5bcecfcadf589802b5f0415ae2f1c4e44c34df218acdea4ee82d567fc"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.0.0"
    sha256 cellar: :any_skip_relocation, ventura:      "6f238cb82e5e0d458bdf59fea4886d4d7087415bfff4fb1554c013a5ba12a85b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b39d0f87548022c29149de41c1ddbfc02b73421367ec957d7f38425b397dc7d2"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
