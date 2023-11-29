class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.0.7/webcface-webui_1.0.7.tar.gz"
  sha256 "f7f533723549f8a15c23853b608febcccd2fd9b230e68d15163c22679f4fdc75"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.0.7"
    sha256 cellar: :any_skip_relocation, ventura:      "180f32305717365007ed104b6974544cbe6176ae4d977e34ad66c3c7f336f85e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "de779dc729129142009d358e5a420dc3e0aa1fd1aebd1e0ce3aed4c18570dfcc"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
