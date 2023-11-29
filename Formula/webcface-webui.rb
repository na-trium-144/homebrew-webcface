class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.0.7/webcface-webui_1.0.7.tar.gz"
  sha256 "f7f533723549f8a15c23853b608febcccd2fd9b230e68d15163c22679f4fdc75"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.0.6"
    sha256 cellar: :any_skip_relocation, ventura:      "acaf83c43512babd1cea324dc77b6398db9ad272465630115fbe803a2134f399"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "121842d23d099ee6a2b0946a27fd7b864b0fd51ca27d646874fc9348d04bc3a9"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
