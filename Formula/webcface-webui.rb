class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.12.2/webcface-webui_1.12.2.tar.gz"
  sha256 "62449886c941a4a21a623bb71899dc20bb35b4f6362927153ebe5718c551281f"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.12.2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "978b8c558dbf6cbd194dbbfe73c9b36b0b1d584f2f241c0d6c078ad1e4731ec9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "288fb8d815dbc3944840f3ba4fc725e648abdba87f99136e0926131377bdd947"
    sha256 cellar: :any_skip_relocation, ventura:       "6240d236d2233273cc313206a6f764ffa4ac25e7e6bc802c46419da355e1b5fb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fa244e1138754ddcfc4cb68750efd37237df5d2cacdea0656f941f65cba6a0d5"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
