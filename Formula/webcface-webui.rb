class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.8.2/webcface-webui_1.8.2.tar.gz"
  sha256 "99825acb40c45b77bac8e09e70e7fdf233444f7786188ad0a4ebc3351b7c16f0"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.8.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "42293a9c5e1a85acf5b1ce9ff1fbadd7380ecc2ce86479291bdd11eb0b4cb1a2"
    sha256 cellar: :any_skip_relocation, ventura:      "4b08166b5dff6429e9a58082f5d0fdcad65445848f0716960b43b893a01d4528"
    sha256 cellar: :any_skip_relocation, monterey:     "8227c1193d910bbcaec03ffd5de4af79dc53d3006d79a47b7c0f85ea21886f06"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fe3d74461324eb531eb1b370b0f994dc12981992878d42fac047bab36a03a5b5"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
