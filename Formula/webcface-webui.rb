class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.5.0/webcface-webui_1.5.0.tar.gz"
  sha256 "a0bffa509891f6c67913cd5fe807e79a59f1e50489d331c06768930cbefdd3d4"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.4.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "451eafc03eeb4ea20a52780b71116a11dc5bbf8d87ed77680b2f014a1040fed8"
    sha256 cellar: :any_skip_relocation, ventura:      "b7d4238045babf300dc0f9e1951e8d92382248bdef10e537cc9175fd307c3492"
    sha256 cellar: :any_skip_relocation, monterey:     "2f21ca1055d907222028a2b2209406c795d590404cf41298cd9e90fd2173093a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3a9288cc642dd70813055994bdc68778321dd440633eefa56a217068675945a8"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
