class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.5.0/webcface-webui_1.5.0.tar.gz"
  sha256 "a0bffa509891f6c67913cd5fe807e79a59f1e50489d331c06768930cbefdd3d4"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.5.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "e2f9065fc8193765810a8f02d7004a0d246dafdf35943176e9ef95aa8505094c"
    sha256 cellar: :any_skip_relocation, ventura:      "4e88370f93a3e58724dad81ae6b4442912fa87ec3b602aac0b1b457acc892805"
    sha256 cellar: :any_skip_relocation, monterey:     "ba1a02c6a9cba39a10ce6c0401be787c0272a3c87c20f9c596b3aa303afb502c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a7ce3f901ce82762a0b251a2d61289e65deea54130581e29d2ee1739f64e6431"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
