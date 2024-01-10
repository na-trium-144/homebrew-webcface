class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.1.0/webcface-webui_1.1.0.tar.gz"
  sha256 "3ddc2905d2a8426c65b0814ac158dec5df2478e42164a98f2678e3c92d2ebe5f"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.1.0"
    sha256 cellar: :any_skip_relocation, ventura:      "c1625154c443cd050a3409bd20f3a1d882ee546213f2b331d0359fb71b51e197"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "34d913853faf41b2ded4250f9b4a3815fc61514fc6fe4bddf1d9f9f19669678b"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
