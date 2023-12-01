class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.0.9/webcface-webui_1.0.9.tar.gz"
  sha256 "68d758923df2b8c4b113a782e7963b0d5b988afdc3795b26c13a3d476231abfd"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.0.8"
    sha256 cellar: :any_skip_relocation, ventura:      "84d1e71f0b17463072bbf4892ae3dc2b2d3b44ee01041c17a59bd5e4f87a1c6a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1248550785aebfbe95a9c72fd1862e89231dbf175cd9f3f6808d4d1b20c7c2e6"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
