class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.15.0/webcface-webui_1.15.0.tar.gz"
  sha256 "1e5a2402aa32dbf7bd9591134fce2798698ccdaf76c3331cd09e9cb62db69aee"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.14.0"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "92d3959879f048a2193a40342ef8d9f48121f88d7495fa956e18dd29658ca3c2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "eaf37aa216da8f480bd9691cd90361272589e4f8f2bdc716016e1f98984d81ae"
    sha256 cellar: :any_skip_relocation, ventura:       "99acf3a644be182a549eb39b7d55ed80d5c28e42c774f48e1db797cbbbe3442d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bbc439ecc9c9ad8ec865b8e7bf6e211fa0193a70055446b1d42ce04372dfae8b"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_path_exists share/"webcface"/"dist"/"index.html"
  end
end
