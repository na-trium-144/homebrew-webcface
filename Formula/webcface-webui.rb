class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.0.8/webcface-webui_1.0.8.tar.gz"
  sha256 "ed4e0eade88acd2e600131e16e280b2ef1c50c5ebe319353f64f668fe683e6e6"
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
