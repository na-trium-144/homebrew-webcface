class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.4.0/webcface-webui_1.4.0.tar.gz"
  sha256 "a28d1d224360377b0513f9ec6375707282999439f82006bbc332fda2b8ea2fc9"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.3.2"
    sha256 cellar: :any_skip_relocation, ventura:      "1cad25deb51953c3dbbccbc2f1d579601db03fea83ce3b589011d192156e6560"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d7d7db39ad8906cf4dff33c0e3487a3dda82f0d10f2694718a9d0b4505fc0f3e"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
