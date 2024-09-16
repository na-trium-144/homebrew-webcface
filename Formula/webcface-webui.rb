class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.8.2/webcface-webui_1.8.2.tar.gz"
  sha256 "99825acb40c45b77bac8e09e70e7fdf233444f7786188ad0a4ebc3351b7c16f0"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.8.2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "c55123e52c72680332667f7f16ffc5bce6b1b377d6fb6c0698ad3af4ab85bf8f"
    sha256 cellar: :any_skip_relocation, ventura:      "3786d0bf5720805e3adc61f73b2a25c20d0087a17fb409f34bdf05d55c85e801"
    sha256 cellar: :any_skip_relocation, monterey:     "f194b6387ec42b40ee326a004ab8ed028b2c7623af842c0f49cdd6d7c01b19ed"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c30d4887a65ee459677782e89c36ea392acab6492639b7d7261fe35e35f6a38c"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
