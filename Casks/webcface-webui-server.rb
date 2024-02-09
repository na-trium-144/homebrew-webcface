cask "webcface-webui-server" do
  version "1.5.3"
  sha256 "d3c44dc41a39615a5e747827d589b2a7628bed8280c2bc360d5a6f84e0208b6c"

  url "https://github.com/na-trium-144/homebrew-webcface/releases/download/v#{version}/WebCFace.WebUI.Server.app.zip"
  name "WebCFace WebUI Server"
  desc "Bundle of WebCFace WebUI (Server Mode), Server and Tools"
  homepage "https://github.com/na-trium-144/homebrew-webcface"

  app "WebCFace WebUI Server.app"
end
