cask "webcface-webui-server" do
  version "1.10.0"
  sha256 "f8187ef459f73044ad94e2eb755a069b7264a44f99ef54e55ee1b3518a27a549"

  url "https://github.com/na-trium-144/homebrew-webcface/releases/download/v#{version}/WebCFace.WebUI.Server.app.zip"
  name "WebCFace WebUI Server"
  desc "Bundle of WebCFace WebUI (Server Mode), Server and Tools"
  homepage "https://github.com/na-trium-144/homebrew-webcface"

  app "WebCFace WebUI Server.app"
end
