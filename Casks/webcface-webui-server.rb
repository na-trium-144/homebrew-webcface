cask "webcface-webui-server" do
  version "1.6.3"
  sha256 "e3e4ab01cf4b229270bf0d2a35a28930ff74701741c506b4d8d588b6d9535650"

  url "https://github.com/na-trium-144/homebrew-webcface/releases/download/v#{version}/WebCFace.WebUI.Server.app.zip"
  name "WebCFace WebUI Server"
  desc "Bundle of WebCFace WebUI (Server Mode), Server and Tools"
  homepage "https://github.com/na-trium-144/homebrew-webcface"

  app "WebCFace WebUI Server.app"
end
