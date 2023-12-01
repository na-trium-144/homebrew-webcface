class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.0.9/webcface-webui_1.0.9.tar.gz"
  sha256 "68d758923df2b8c4b113a782e7963b0d5b988afdc3795b26c13a3d476231abfd"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.0.9"
    sha256 cellar: :any_skip_relocation, ventura:      "5b1ad4e452eaad09002bc486614a12a4b33f59a1f7f768c7d892f2479581a28e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "75a9a942671ec98ceb7be3db8e0272e7937101bbea2b634697cbf280703d04eb"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
