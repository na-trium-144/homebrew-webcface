cask "webcface-webui-server" do
  version "1.9.0"
  sha256 "000b52bf5fac9886ab7f006c39f3d3f004bd5c9505421790f1b760e2f12fa596"

  url "https://github.com/na-trium-144/homebrew-webcface/releases/download/v#{version}/WebCFace.WebUI.Server.app.zip"
  name "WebCFace WebUI Server"
  desc "Bundle of WebCFace WebUI (Server Mode), Server and Tools"
  homepage "https://github.com/na-trium-144/homebrew-webcface"

  app "WebCFace WebUI Server.app"
end
