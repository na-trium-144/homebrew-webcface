class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.0.11/webcface-webui_1.0.11.tar.gz"
  sha256 "180c93883f613017a1b0e82fd6913515a14fb492a76c3b3ea4ab6a2236ed291a"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.0.10"
    sha256 cellar: :any_skip_relocation, ventura:      "18b85b846ae678f02c52ce706590f2a87af5709e7a7f67dbddc8e44be941b174"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "be9caaafb921e89b0f39715bf71b1739fdbee49c40d5453f69a6188165d40f36"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
