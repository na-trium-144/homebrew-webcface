class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.3.0/webcface-webui_1.3.0.tar.gz"
  sha256 "711a8cc1be370129017c4714cab86e77c5be00902e84ff16198c94e9e6194de4"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.2.0"
    sha256 cellar: :any_skip_relocation, ventura:      "4f1fd49900fc4e910928b3df7ca894dec2f0afdb82609107b46b9d009e700d39"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "60f17f69a6dc9e5564d36f03384fbfb2d928370f5b974110a1a531220c065219"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
