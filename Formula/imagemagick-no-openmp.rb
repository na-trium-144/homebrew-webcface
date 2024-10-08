class ImagemagickNoOpenmp < Formula
  desc "Tools and libraries to manipulate images in many formats"
  homepage "https://imagemagick.org/index.php"
  url "https://imagemagick.org/archive/releases/ImageMagick-7.1.1-37.tar.xz"
  sha256 "685072c6e425faa62b4d0814f9d44b5d62e8b9b5d866efc160180e55a42f7fdb"
  license "ImageMagick"
  head "https://github.com/ImageMagick/ImageMagick.git", branch: "main"

  livecheck do
    url "https://imagemagick.org/archive/"
    regex(/href=.*?ImageMagick[._-]v?(\d+(?:\.\d+)+-\d+)\.t/i)
  end

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/imagemagick-no-openmp-7.1.1-37"
    sha256 arm64_sonoma: "1a46a4d75b469065a7d75ece656e0c0dc1132b5af9c64f559e82a4a56463ca1c"
    sha256 ventura:      "bfca80644a0ba9d86a35e7ff442ed9193fd47e8ba93fbab32d2507d74f23fb50"
    sha256 monterey:     "a55121a912901300e536274b8ca4bc5d7df05417f1fe14bafa22d4450da7a2cc"
    sha256 x86_64_linux: "30cbb7f6aad14e58bcd19b5aa8ba46e47dd7737f1ff1aa93dbadc68ce8337e08"
  end

  keg_only "homebrew-core provides imagemagick"

  depends_on "pkg-config" => :build
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "ghostscript"
  depends_on "jpeg-turbo"
  depends_on "jpeg-xl"
  depends_on "libheif"
  depends_on "liblqr"
  depends_on "libpng"
  depends_on "libraw"
  depends_on "libtiff"
  depends_on "libtool"
  depends_on "little-cms2"
  depends_on "openexr"
  depends_on "openjpeg"
  depends_on "webp"
  depends_on "xz"

  uses_from_macos "bzip2"
  uses_from_macos "libxml2"
  uses_from_macos "zlib"

  on_macos do
    depends_on "gettext"
    depends_on "glib"
    depends_on "imath"
  end

  on_linux do
    depends_on "jbigkit"
    depends_on "libx11"
    depends_on "libxext"
  end

  skip_clean :la

  def install
    # Avoid references to shim
    inreplace Dir["**/*-config.in"], "@PKG_CONFIG@", Formula["pkg-config"].opt_bin/"pkg-config"
    # versioned stuff in main tree is pointless for us
    inreplace "configure", "${PACKAGE_NAME}-${PACKAGE_BASE_VERSION}", "${PACKAGE_NAME}"

    args = [
      "--enable-osx-universal-binary=no",
      "--disable-silent-rules",
      "--disable-opencl",
      "--enable-shared",
      "--enable-static",
      "--with-freetype=yes",
      "--with-gvc=no",
      "--with-modules",
      "--with-openjp2",
      "--with-openexr",
      "--with-webp=yes",
      "--with-heic=yes",
      "--with-raw=yes",
      "--with-gslib",
      "--with-gs-font-dir=#{HOMEBREW_PREFIX}/share/ghostscript/fonts",
      "--with-lqr",
      "--without-djvu",
      "--without-fftw",
      "--without-pango",
      "--without-wmf",
      "--disable-openmp",
    ]
    if OS.mac?
      args += [
        "--without-x",
        # Work around "checking for clang option to support OpenMP... unsupported"
        # "ac_cv_prog_c_openmp=-Xpreprocessor -fopenmp",
        # "ac_cv_prog_cxx_openmp=-Xpreprocessor -fopenmp",
        # "LDFLAGS=-lomp -lz",
        "LDFLAGS=-lz",
      ]
    end

    system "./configure", *std_configure_args, *args
    system "make", "install"
  end

  test do
    assert_match "PNG", shell_output("#{bin}/identify #{test_fixtures("test.png")}")

    # Check support for recommended features and delegates.
    features = shell_output("#{bin}/magick -version")
    %w[Modules freetype heic jpeg png raw tiff].each do |feature|
      assert_match feature, features
    end

    # Check support for a few specific image formats, mostly to ensure LibRaw linked correctly.
    formats = shell_output("#{bin}/magick -list format")
    ["AVIF  HEIC      rw+", "ARW  DNG       r--", "DNG  DNG       r--"].each do |format|
      assert_match format, formats
    end
    assert_match "Helvetica", shell_output("#{bin}/magick -list font")
  end
end
