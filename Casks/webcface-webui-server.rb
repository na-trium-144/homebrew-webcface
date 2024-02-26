cask "webcface-webui-server" do
  version "1.7.0"
  sha256 "4461e88fcdf3d7c9fb6b6a60dc58fa309b884eeb15149dd74e3fc48924246e6d"

  url "https://github.com/na-trium-144/homebrew-webcface/releases/download/v#{version}/WebCFace.WebUI.Server.app.zip"
  name "WebCFace WebUI Server"
  desc "Bundle of WebCFace WebUI (Server Mode), Server and Tools"
  homepage "https://github.com/na-trium-144/homebrew-webcface"

  app "WebCFace WebUI Server.app"
end
