# Na-trium-144 Webcface

* WebCFaceをhomebrewでいんすとーるするformulaとcaskを管理するリポジトリです。
* WebUI(Server Mode)をMac用にAppとしてビルドしてリリースするリポジトリでもあります。

## How do I install these formulae?
```sh
brew tap na-trium-144/webcface
```

### WebCFace Library and CLI Tools
`brew install webcface webcface-webui webcface-tools`

### WebCFace WebUI-Server App Bundle (for MacOS)
`brew install --cask webcface-webui-server`
Or download directory from [Releases](https://github.com/na-trium-144/homebrew-webcface/releases) of this repository.

## update formula
[Trigger formula update](https://github.com/na-trium-144/homebrew-webcface/actions/workflows/trigger.yml)のActionの引数にformula名とversionを入れてWorkflowを実行するとprができる

テストが通ったらpr-pullラベルをつける

## build app bundle
[Build WebUI-Server](https://github.com/na-trium-144/homebrew-webcface/actions/workflows/build-app.yml)のActionの引数にバージョンを入れて実行するとreleaseとprができる
