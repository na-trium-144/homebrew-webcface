class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.9.0/webcface-webui_1.9.0.tar.gz"
  sha256 "15376306ef0595569b87bda5ce436857b7c2a09f7d4a9422a0ccdd6ebf83e29a"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.8.3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "74c2340795ca422c0db75824bbac0897068222d52bc7caea683df3985407b523"
    sha256 cellar: :any_skip_relocation, ventura:      "c88c8fdf166c5c8ebf4c848e066f91092e358567efbce0ca3063acf6fe033478"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1c783585f7b01f3172774bd471b93b4fe3df5a0435d0fd53b1df238714331815"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
