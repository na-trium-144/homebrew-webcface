class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.0.12/webcface-webui_1.0.12.tar.gz"
  sha256 "73ad4b1920e2058780ce1ae919ce9222d4d3a2c930dd56fd4e6d029c0392f5aa"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.0.12"
    sha256 cellar: :any_skip_relocation, ventura:      "a93615bc10f46933da2b4b424ec61d60f753550a5ffc52271d167fbbeaf42a39"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "78cea2e8397c1fd354b43c0816a3a287521830b06c4feb65a8ebe8de4d6fb2a4"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
