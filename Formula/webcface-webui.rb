class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.1.0/webcface-webui_1.1.0.tar.gz"
  sha256 "3ddc2905d2a8426c65b0814ac158dec5df2478e42164a98f2678e3c92d2ebe5f"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.1.0"
    sha256 cellar: :any_skip_relocation, ventura:      "d224145e2dfdc3b0214466ec580a2eb65589d4c8110b9a93103d23f163eea5f8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c2fe95f549f6c3d49724bedd66fdf4a8fb5cf631b6391b5bb5129a9aa01cd35c"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
