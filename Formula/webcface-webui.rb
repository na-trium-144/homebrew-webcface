class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.1.0/webcface-webui_1.1.0.tar.gz"
  sha256 "3ddc2905d2a8426c65b0814ac158dec5df2478e42164a98f2678e3c92d2ebe5f"
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
