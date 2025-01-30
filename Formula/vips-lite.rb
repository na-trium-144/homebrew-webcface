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
    rebuild 2
    sha256 arm64_sequoia: "d21c54f55b3a51f7a4fce360f996f8363d523b5a52ff37f93788d292e4fda75f"
    sha256 arm64_sonoma:  "6160ce321b213ed0b4c323d6086742273e2814949943f7fa684b534513965bec"
    sha256 arm64_ventura: "3f89494aca6ca8dcd2e1067c0ed1e775de4bcf633be4c1499ad1b7ebd0533da4"
    sha256 sonoma:        "8969af30ed345a9a80215938dd02dae3158d61022cf2cefe8e017e5eb0e3e028"
    sha256 ventura:       "b4d12ec545298204beeef2722f5dd914268176b5cdb6ece318b50aa578430381"
    sha256 x86_64_linux:  "7d1acd4661c389afe2b37616d813a542e0b9d0cc58929c4868a5841d42e41815"
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
