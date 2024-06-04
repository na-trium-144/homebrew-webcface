class CurlWs < Formula
  desc "Get a file from an HTTP, HTTPS or FTP server"
  homepage "https://curl.se"
  # Don't forget to update both instances of the version in the GitHub mirror URL.
  url "https://curl.se/download/curl-8.8.0.tar.bz2"
  mirror "https://github.com/curl/curl/releases/download/curl-8_8_0/curl-8.8.0.tar.bz2"
  # mirror "http://fresh-center.net/linux/www/curl-8.8.0.tar.bz2"
  # mirror "http://fresh-center.net/linux/www/legacy/curl-8.8.0.tar.bz2"
  sha256 "40d3792d38cfa244d8f692974a567e9a5f3387c547579f1124e95ea2a1020d0d"
  license "curl"

  livecheck do
    url "https://curl.se/download/"
    regex(/href=.*?curl[._-]v?(.*?)\.t/i)
  end

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/curl-ws-8.8.0"
    sha256 cellar: :any,                 arm64_sonoma: "37d87ad63dae97dce8b86e306a6cd439fb4f6db7e87d17bd0d711bd479e1da9e"
    sha256 cellar: :any,                 ventura:      "3d390627369c536f304b5bbac1d73eebff29e76b335656ceeb55697f68ff7f26"
    sha256 cellar: :any,                 monterey:     "e83a10f4853c0e1c08d058bcdcbee8d78dc9bb2f1d410e21680d71fe01c132a5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9585e22893cfbc98f65470988e5ed45566f4086a5f09a6a763e86c672a662435"
  end

  head do
    url "https://github.com/curl/curl.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  keg_only "conflict with curl"

  depends_on "pkg-config" => :build
  depends_on "brotli"
  depends_on "libidn2"
  depends_on "libnghttp2"
  depends_on "libssh2"
  depends_on "openldap"
  depends_on "openssl@3"
  depends_on "rtmpdump"
  depends_on "zstd"

  uses_from_macos "krb5"
  uses_from_macos "zlib"

  def install
    tag_name = "curl-#{version.to_s.tr(".", "_")}"
    if build.stable? && stable.mirrors.grep(/github\.com/).first.exclude?(tag_name)
      odie "Tag name #{tag_name} is not found in the GitHub mirror URL! " \
           "Please make sure the URL is correct."
    end

    system "./buildconf" if build.head?

    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --with-ssl=#{Formula["openssl@3"].opt_prefix}
      --without-ca-bundle
      --without-ca-path
      --with-ca-fallback
      --with-secure-transport
      --with-default-ssl-backend=openssl
      --with-libidn2
      --with-librtmp
      --with-libssh2
      --without-libpsl
      --with-zsh-functions-dir=#{zsh_completion}
      --with-fish-functions-dir=#{fish_completion}
      --enable-websockets
    ]

    args << if OS.mac?
      "--with-gssapi"
    else
      "--with-gssapi=#{Formula["krb5"].opt_prefix}"
    end

    system "./configure", *args
    system "make", "install"
    system "make", "install", "-C", "scripts"
    libexec.install "scripts/mk-ca-bundle.pl"
  end

  test do
    # Fetch the curl tarball and see that the checksum matches.
    # This requires a network connection, but so does Homebrew in general.
    filename = (testpath/"test.tar.gz")
    system "#{bin}/curl", "-L", stable.url, "-o", filename
    filename.verify_checksum stable.checksum

    system libexec/"mk-ca-bundle.pl", "test.pem"
    assert_predicate testpath/"test.pem", :exist?
    assert_predicate testpath/"certdata.txt", :exist?
  end
end
