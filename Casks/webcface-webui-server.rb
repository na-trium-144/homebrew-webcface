cask "webcface-webui-server" do
  version "1.6.1"
  sha256 "f10163a77636a69614aad26a26297ada142af16a51399c8773560785139e850b"

  url "https://github.com/na-trium-144/homebrew-webcface/releases/download/v#{version}/WebCFace.WebUI.Server.app.zip"
  name "WebCFace WebUI Server"
  desc "Bundle of WebCFace WebUI (Server Mode), Server and Tools"
  homepage "https://github.com/na-trium-144/homebrew-webcface"

  app "WebCFace WebUI Server.app"
end
