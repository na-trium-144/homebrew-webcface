class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.0.1/webcface-webui_1.0.1.tar.gz"
  sha256 "c570b7a5bcecfcadf589802b5f0415ae2f1c4e44c34df218acdea4ee82d567fc"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.0.1"
    sha256 cellar: :any_skip_relocation, ventura:      "bfbab78323cd8d1b231d8d61d17e1a8257acb2a38cac5aa467322bd23af30f0d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a011de85d4cbda8662c9f0744d5f5104eb6d2b833071500ce8bbe28e50871dcc"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
