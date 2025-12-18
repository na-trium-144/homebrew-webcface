class VipsLite < Formula
  desc "Image processing library"
  homepage "https://github.com/libvips/libvips"
  url "https://github.com/libvips/libvips/releases/download/v8.17.3/vips-8.17.3.tar.xz"
  sha256 "41e9a1439cd57dcc6d4435a085e2cfe181d9da1962fa84a484f09e8b536e4b77"
  license "LGPL-2.1-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/vips-lite-8.17.3"
    sha256 arm64_tahoe:   "4e00cdf685ffccb8e61345b3b395406bb30f21a01873f9689ac16ad5e57656a6"
    sha256 arm64_sequoia: "186e0a40dc7c5ee7db3cd327f3c64094c452e35160b245a0469c6084f7af6569"
    sha256 arm64_sonoma:  "14346570a32188277361333cb358d48c277b41a7958ac7135e0327784e3c79bb"
    sha256 x86_64_linux:  "d91e4f3fa793fa05d3d4acbb4515d4e44ea3b5dbcccaa43f120bc67ea3a6b522"
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
