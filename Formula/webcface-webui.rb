class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.10.4/webcface-webui_1.10.4.tar.gz"
  sha256 "a2757242a278be740771b4c6f0afa33f11f5f2352e5e753461c444438bd814b8"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.10.4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "2b432767b2800d2bb03a94c3588ddf34abca5d2903093794a721dbc7da72befd"
    sha256 cellar: :any_skip_relocation, ventura:      "5df3f725acd2698b1bb97240e0a0682693bb1eb149dd65ab425853a91feff58a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "43af17a2f45bfba8c9db9d4cf0733d3ffa75f35246df1f0e8d403aa2518a8b28"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
