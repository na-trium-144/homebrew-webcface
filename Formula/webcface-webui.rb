class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.12.2/webcface-webui_1.12.2.tar.gz"
  sha256 "62449886c941a4a21a623bb71899dc20bb35b4f6362927153ebe5718c551281f"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.11.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "4a13a1f44187ef5131a3327ceb9be07f46f3ffbd8357d2ed3746ced1857b7f44"
    sha256 cellar: :any_skip_relocation, ventura:      "a77a77fe94ad38aca9033cd5b1dca959d3dee9d10d71b1ad0b6b4460040571cb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fa3d753bfaabec97aae96324012b73f2e55e15836ac20dc1946c4b87e1178114"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
