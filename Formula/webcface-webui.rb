class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.0.0/webcface-webui_1.0.0.tar.gz"
  sha256 "5d45d76e0245eaecd64777fd00345a377c79e59f15e4204a5aa6bab69eacf25e"
  license "MIT"

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
