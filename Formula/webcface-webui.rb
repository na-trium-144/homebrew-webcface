class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.15.0/webcface-webui_1.15.0.tar.gz"
  sha256 "1e5a2402aa32dbf7bd9591134fce2798698ccdaf76c3331cd09e9cb62db69aee"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.15.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "7e3300c0f87edeceeded492231b03396fbe245e76f5f612adf808b26358f72ab"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "de2b70617df4e400e39885533bde37957cb53286eb061a656a899ea73f63c21d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2499c908493416025f5acaddc80a2be7eaf42dc4c10cb45231d69c273c733adb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6c98ddf4db6990b142aa65974d4d75c3484dd719390248eff10d1c0d9bc1c880"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_path_exists share/"webcface"/"dist"/"index.html"
  end
end
