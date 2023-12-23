class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.0.12/webcface-webui_1.0.12.tar.gz"
  sha256 "73ad4b1920e2058780ce1ae919ce9222d4d3a2c930dd56fd4e6d029c0392f5aa"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.0.11"
    sha256 cellar: :any_skip_relocation, ventura:      "fb1aff8d3efe356319b82021281f7c3b32f80abd8c69b3b96d2fbd2124abf59b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7b2e7d03012fb951d6623b7efcab029b249d1c98800f54d7ebc2873f9ea3af6f"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
