class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.3.0/webcface-webui_1.3.0.tar.gz"
  sha256 "711a8cc1be370129017c4714cab86e77c5be00902e84ff16198c94e9e6194de4"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.3.0"
    sha256 cellar: :any_skip_relocation, ventura:      "0477f017b05302f38bfb025b8bf23c8b6981606e4c77b2a75faa035a44d5d289"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0b64b55fc2dba8867d52f2078cf75a098f22beda8e918f6b7ea0028689bb2d8e"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
