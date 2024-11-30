class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.10.3/webcface-webui_1.10.3.tar.gz"
  sha256 "e193b2409be99b207c045f1cc2453a6ecd5affa2d5ecfe29a39924e4dc0857d6"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.10.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "6cd575adc7863d583449fe8c606722df78181411260538746858816620181c47"
    sha256 cellar: :any_skip_relocation, ventura:      "b221142d8918959099dc00887dc4d460b5f0a472160e25b4e8fe1475120c9cee"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4a1ac39dcb5a22ea1946e8e878c4f87062ec994f2e46ce09ef46db6857b2039d"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
