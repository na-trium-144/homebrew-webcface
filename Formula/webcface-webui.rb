class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.4.1/webcface-webui_1.4.1.tar.gz"
  sha256 "ae9278dbb72477d208ef1d658538a72917a6de469502b6b4e896e79a51af1942"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.4.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "b72ad365ce4804c5cdf4da1daacadc0fb269d92c72cc25d6565c87aa3fde0826"
    sha256 cellar: :any_skip_relocation, ventura:      "3c63b4fec7a1b9784734ca1c058c900bf723b6eae575880199cd1bcca6070e68"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2da78a0cdbab6556397873b0d4dee5099903dbbe36595387d352e1dc1d94f06f"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
