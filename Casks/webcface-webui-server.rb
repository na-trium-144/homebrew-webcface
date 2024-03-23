cask "webcface-webui-server" do
  version "1.9.1"
  sha256 "5cf31eecce48e2f2150ed9b1231672e3825f76986506c73a39a5fcec5e34444c"

  url "https://github.com/na-trium-144/homebrew-webcface/releases/download/v#{version}/WebCFace.WebUI.Server.app.zip"
  name "WebCFace WebUI Server"
  desc "Bundle of WebCFace WebUI (Server Mode), Server and Tools"
  homepage "https://github.com/na-trium-144/homebrew-webcface"

  app "WebCFace WebUI Server.app"
end
