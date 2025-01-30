class VipsLite < Formula
  desc "Image processing library"
  homepage "https://github.com/libvips/libvips"
  url "https://github.com/libvips/libvips/releases/download/v8.16.0/vips-8.16.0.tar.xz"
  sha256 "6eca46c6ba5fac86224fd69007741012b0ea1f9aa1fcb9256b0cbc2faf768563"
  license "LGPL-2.1-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/vips-lite-8.16.0"
    rebuild 1
    sha256 arm64_sequoia: "adbce07097c02a8fe65ff9961458d42d7a3ce26006856d00ea1b11d5c75d55b9"
    sha256 arm64_sonoma:  "1967b707f6ee2a13ad7b51732b0c44aee9a285eb92954d21fb71a1b10800de2c"
    sha256 ventura:       "3f81b3cd2fc02133f40788a2f74f277d19ac8b4ce92df483247b504453ecc5cc"
    sha256 x86_64_linux:  "3292fe93b65b79addefc252c01241157ffd607116700ccf871019c2a9fa418c5"
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
