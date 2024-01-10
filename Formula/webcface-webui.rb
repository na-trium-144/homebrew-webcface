class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.2.0/webcface-webui_1.2.0.tar.gz"
  sha256 "dbdb3ade4d90dcb7a2eaa50e795a338247c4dd1f4ece17a8c8f47d35ad4e205d"
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
