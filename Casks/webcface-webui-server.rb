cask "webcface-webui-server" do
  version "1.5.2"
  sha256 "2d1596d175e60bef87d003a8bb76e366dde32158409de5bde2f16050ddd6786b"

  url "https://github.com/na-trium-144/homebrew-webcface/releases/download/v#{version}/WebCFace.WebUI.Server.app.zip"
  name "WebCFace WebUI Server"
  desc "Bundle of WebCFace WebUI (Server Mode), Server and Tools"
  homepage "https://github.com/na-trium-144/homebrew-webcface"

  app "WebCFace WebUI Server.app"
end
