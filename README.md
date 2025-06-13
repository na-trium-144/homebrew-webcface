# Na-trium-144 Webcface

Homebrew tap for [WebCFace](https://github.com/na-trium-144/webcface) version 1 and 2.

## How do I install these formulae?
```sh
brew tap na-trium-144/webcface
```

### WebCFace ver2 Library and CLI Tools
```sh
brew install webcface webcface-webui webcface-tools
```

### WebCFace ver1
```sh
brew install webcface@1
```

### Other formulae

No guarantee of stability and compatibility. These can be removed or renamed in future updates without notice.

* `crow-unix-socket`: `crow` with unix domain socket support (Older revision of [CrowCpp/Crow#803](https://github.com/CrowCpp/Crow/pull/803))
* `tiny-process-library`: [eidheim/tiny-process-library](https://gitlab.com/eidheim/tiny-process-library) built as shared library
    * Note that library's ABI version is `2.0.x-(commit number)` so it breaks dependents every time this is updated.
* `vips-lite`: `vips` with minimal features (jpeg, png and webp only)
