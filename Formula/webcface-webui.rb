class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.7.0/webcface-webui_1.7.0.tar.gz"
  sha256 "7c5fd2746805e3e61644ac75b13fb613c1e9cd7be00336a1f398f28a38372bb2"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.6.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "48c875266ea88352bea63df5332b3778fd4e444a511522b31869b114d5faa7cb"
    sha256 cellar: :any_skip_relocation, ventura:      "dba93911ace0ba497144ae050c9d32007c7ddf38dd5a010e976ec31d3309f932"
    sha256 cellar: :any_skip_relocation, monterey:     "928d1d3bb36fa2d2e7bf5b83452a01b216fee60af54c89d288e4b0ccd8858d4e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "26abc5671a89b4d361d3d25b241fc16a3d391f2a84d7971aed3e7326100b65b3"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
