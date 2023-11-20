class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.0.6/webcface-webui_1.0.6.tar.gz"
  sha256 "1670552b05940ed784a0f03ebffa183f5d7694f7f00c5bbf248ee8345be7aa32"
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
