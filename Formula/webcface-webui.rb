class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.10.3/webcface-webui_1.10.3.tar.gz"
  sha256 "e193b2409be99b207c045f1cc2453a6ecd5affa2d5ecfe29a39924e4dc0857d6"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.10.3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "25c71ebbc66d788619c72b5e06ff7f2271051ba29066ff6ad69eff069891f72f"
    sha256 cellar: :any_skip_relocation, ventura:      "8d021c4548795610ca67bedb5599286457133f467428a1a484217ed14127b372"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "382547758c51dc56805096256133535709fad4028f19f973fe0f850ca657c233"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
