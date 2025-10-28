class VipsLite < Formula
  desc "Image processing library"
  homepage "https://github.com/libvips/libvips"
  url "https://github.com/libvips/libvips/releases/download/v8.17.2/vips-8.17.2.tar.xz"
  sha256 "57ea0ec4f30ea04748c9e8eec5415e7c9ac7cafe6822e4788fc110376a1d224a"
  license "LGPL-2.1-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/vips-lite-8.17.2"
    sha256 arm64_tahoe:   "e4c34c48a946dd7d7543f746162a41e821eebe920549681975e4ed2e03b367f3"
    sha256 arm64_sequoia: "35d3103fb353a523aa61bbdc1637cbc944281ac04e5bbb55e418943ab5df3573"
    sha256 arm64_sonoma:  "8f7ac87c49d4cef81853b135a5c22de27ed837b92a60f18f8c0f8db7e1e02578"
    sha256 x86_64_linux:  "59e1479075c8ca7dc459066ff5a50d67eac57721c9d1af804fc4494c9aa4a25b"
  end

  keg_only "homebrew-core provides vips"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => [:build, :test]
  depends_on "glib"
  depends_on "libspng"
  depends_on "mozjpeg"
  depends_on "webp"

  uses_from_macos "python" => :build
  uses_from_macos "expat"
  uses_from_macos "zlib"

  def install
    # mozjpeg needs to appear before libjpeg, otherwise it's not used
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["mozjpeg"].opt_lib/"pkgconfig"

    system "meson", "setup", "build", *std_meson_args,
      "-Djpeg=enabled",
      "-Dspng=enabled",
      "-Dwebp=enabled",
      "-Dzlib=enabled",
      "-Ddeprecated=false",
      "-Dexamples=false",
      "-Dmodules=disabled",
      "-Dintrospection=disabled",
      "-Dvapi=false",
      "-Dcfitsio=disabled",
      "-Dcgif=disabled",
      "-Dexif=disabled",
      "-Dfftw=disabled",
      "-Dfontconfig=disabled",
      "-Darchive=disabled",
      "-Dheif=disabled",
      "-Dheif-module=disabled",
      "-Dimagequant=disabled",
      "-Djpeg-xl=disabled",
      "-Djpeg-xl-module=disabled",
      "-Dlcms=disabled",
      "-Dmagick=disabled",
      "-Dmagick-package=",
      "-Dmagick-module=disabled",
      "-Dmatio=disabled",
      "-Dnifti=disabled",
      "-Dopenexr=disabled",
      "-Dopenjpeg=disabled",
      "-Dopenslide=disabled",
      "-Dopenslide-module=disabled",
      "-Dhighway=disabled",
      "-Dorc=disabled",
      "-Dpangocairo=disabled",
      "-Dpdfium=disabled",
      "-Dpng=disabled",
      "-Dpoppler=disabled",
      "-Dpoppler-module=disabled",
      "-Dquantizr=disabled",
      "-Drsvg=disabled",
      "-Dtiff=disabled",
      "-Dnsgif=false",
      "-Dppm=false",
      "-Danalyze=false",
      "-Dradiance=false"

    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    system bin/"vips", "-l"
    cmd = "#{bin}/vipsheader -f width #{test_fixtures("test.png")}"
    assert_equal "8", shell_output(cmd).chomp

    # --trellis-quant requires mozjpeg, vips warns if it's not present
    cmd = "#{bin}/vips jpegsave #{test_fixtures("test.png")} #{testpath}/test.jpg --trellis-quant 2>&1"
    assert_empty shell_output(cmd)

    # Make sure `pkg-config` can parse `vips.pc` and `vips-cpp.pc` after the `inreplace`.
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["vips-lite"].opt_lib/"pkgconfig"
    system "pkgconf", "--print-errors", "vips"
    system "pkgconf", "--print-errors", "vips-cpp"
  end
end
