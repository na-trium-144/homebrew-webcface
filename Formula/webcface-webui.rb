class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.9.0/webcface-webui_1.9.0.tar.gz"
  sha256 "15376306ef0595569b87bda5ce436857b7c2a09f7d4a9422a0ccdd6ebf83e29a"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.9.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "380212e4c146727f335296223f051969eeb912bdd0bf71351b0bada2c9b348cc"
    sha256 cellar: :any_skip_relocation, ventura:      "5de2ee526a01a4f48c72392c04ee0fe8952b1d175bc64a8244610431d6d9b853"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8d4b476d3ac785e2c37e1776dc62f22711546dda28efb39f1751eb42998c8661"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
