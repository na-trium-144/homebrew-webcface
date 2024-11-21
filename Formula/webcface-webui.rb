class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.10.1/webcface-webui_1.10.1.tar.gz"
  sha256 "e132db03ce23a5b13a266026eafc059ee821b0f0b8b8cc93fc7dcd74267ad047"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.10.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "27e28ee57709ebf5ef1a803d804123219cb8f567558fcedae45396aa66151c55"
    sha256 cellar: :any_skip_relocation, ventura:      "05aa6984ebf8a095fd320fef9004e4c8c7647a989ede6d4c1c2b0df751f21397"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fae3d97cc01d67d01ce77656ba7468984a34ee0fb82bde835ba2fccf5e2d63a7"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
