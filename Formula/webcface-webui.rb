class WebcfaceWebui < Formula
  desc "UI Application for WebCFace"
  homepage "https://github.com/na-trium-144/webcface-webui"
  url "https://github.com/na-trium-144/webcface-webui/releases/download/v1.13.0/webcface-webui_1.13.0.tar.gz"
  sha256 "6ac408c7c8e5b413bc246eac4150879d3ad7dcf3347bd341df52b0c6f09d5b50"
  license "MIT"

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/webcface-webui-1.13.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "23918dfaf2350d515bfb185e9573e1f89f59322f8bab9bff809e06bcb0759a3a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6678a6bb30b5a950ad8b6f26f9e5c3a8d8c5209852b877127b14a8c5110331da"
    sha256 cellar: :any_skip_relocation, ventura:       "846358b17f55b52bca4bf1136da22239a970f6f3596f8d805de817abc7a8f7ee"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1ae17272c5515cd9575501bb7041663faecae9929dba6541603deac655680b74"
  end

  def install
    (share/"webcface"/"dist").install Dir["./*"]
  end

  test do
    assert_predicate share/"webcface"/"dist"/"index.html", :exist?
  end
end
