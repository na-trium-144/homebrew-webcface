class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.8.1/webcface-webui_1.8.1.tar.gz"
  sha256 "28bbf0b21228af1157d5ec8c38a72ac21cf85439a9db9e2fd38c26a911c11c12"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.7.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "5c912836505ef163b26180634b13b91cec5035d1fabac1de51a0147a15ae95da"
    sha256 cellar: :any_skip_relocation, ventura:      "027520f321216a0f7f3003d2074ae50524ddd74d4a111c08597ebc43f02ebdf5"
    sha256 cellar: :any_skip_relocation, monterey:     "d5b07b661e7fb46a81d90c10fd634bd8211a764fda990c2018ed4f09a8d2d98d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "73932614a79d39ea1e5e07aa652306edb66c1dc1c4bef4f0fc5a6d5178b816be"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
