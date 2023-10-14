class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.0.4/webcface-webui_1.0.4.tar.gz"
  sha256 "81589b1eff5a8d6022ae444e8a83ad0f97ab889dd73757ef7dedb8b8d3dcf372"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.0.4"
    sha256 cellar: :any_skip_relocation, ventura:      "2cccf961f7b88ac21eaaa90dfa268a5e6ee3f4532797d6aad5704b4022b23cd5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "876ee4e4267cfb718b2ef5714616f3690e621a17df6fd658df922cc6337ba94b"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
