cask "webcface-webui-server" do
  version "1.8.0"
  sha256 "03b932257cdf7778bcd2c2b02c152852e80ac0bb5cb41d49d0d504d98c52d1fa"

  url "https://github.com/na-trium-144/homebrew-webcface/releases/download/v#{version}/WebCFace.WebUI.Server.app.zip"
  name "WebCFace WebUI Server"
  desc "Bundle of WebCFace WebUI (Server Mode), Server and Tools"
  homepage "https://github.com/na-trium-144/homebrew-webcface"

  app "WebCFace WebUI Server.app"
end
