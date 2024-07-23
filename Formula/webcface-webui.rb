class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.7.0/webcface-webui_1.7.0.tar.gz"
  sha256 "7c5fd2746805e3e61644ac75b13fb613c1e9cd7be00336a1f398f28a38372bb2"
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
