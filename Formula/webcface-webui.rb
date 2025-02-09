class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.14.0/webcface-webui_1.14.0.tar.gz"
  sha256 "6e4f1761c7d39458b58b94f4afa7234595bd393ae1baf15d0dca0136fe812adf"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.14.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "afc688c72730b907b683b1e1af1d780a04cca49096fefb610f3b281573bb47a8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b70dbdcb1618c5ede9fe6ecb7442e27a16f2927d0146195007913c87432ca896"
    sha256 cellar: :any_skip_relocation, ventura:       "5612a77d09211151a074ab3987558679a6aa25c3e8a281c42b746483d9405429"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "551e9b4cfa5213fea482881778613d000cd9114b2335520693a36fbcb5d32c8d"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
