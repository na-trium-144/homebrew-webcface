class CurlWs < Formula
  desc "Get a file from an HTTP, HTTPS or FTP server"
  homepage "https://curl.se"
  # Don't forget to update both instances of the version in the GitHub mirror URL.
  url "https://curl.se/download/curl-8.9.1.tar.bz2"
  mirror "https://github.com/curl/curl/releases/download/curl-8_9_1/curl-8.9.1.tar.bz2"
  mirror "http://fresh-center.net/linux/www/curl-8.9.1.tar.bz2"
  mirror "http://fresh-center.net/linux/www/legacy/curl-8.9.1.tar.bz2"
  sha256 "b57285d9e18bf12a5f2309fc45244f6cf9cb14734e7454121099dd0a83d669a3"
  license "curl"
  revision 1
  version_scheme 1

  livecheck do
    url "https://curl.se/download/"
    regex(/href=.*?curl[._-]v?(.*?)\.t/i)
  end

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/curl-ws-8.9.1_1"
    sha256 cellar: :any,                 arm64_sequoia: "9c48a94e65dbc6bcf605985b3513f728b18f7e573688d97e826433d29747fa0c"
    sha256 cellar: :any,                 arm64_sonoma:  "345b284316a9f932e4836d0b518421feea9c983070fe3a7d0de80207ea3d2f7c"
    sha256 cellar: :any,                 ventura:       "3898522606e84f5d466634b04c361311151e0068d987221a4f508bf5dce4ee7e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1969f88960448e5d5e08c5ea04e14a028a0d96717974f9e05d6f7e785a5bfd3f"
  end

  head do
    url "https://github.com/curl/curl.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  keg_only "this conflict with curl"

  depends_on "pkg-config" => :build
  depends_on "brotli"
  depends_on "libidn2"
  depends_on "libnghttp2"
  depends_on "libssh2"
  depends_on "openssl@3"
  depends_on "rtmpdump"
  depends_on "zstd"

  uses_from_macos "krb5"
  uses_from_macos "openldap"
  uses_from_macos "zlib"

  def install
    tag_name = "curl-#{version.to_s.tr(".", "_")}"
    if build.stable? && stable.mirrors.grep(/github\.com/).first.exclude?(tag_name)
      odie "Tag name #{tag_name} is not found in the GitHub mirror URL! " \
           "Please make sure the URL is correct."
    end

    system "./buildconf" if build.head?

    args = %W[
      --disable-silent-rules
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

    system "./configure", *args, *std_configure_args
    system "make", "install"
    system "make", "install", "-C", "scripts"
    libexec.install "scripts/mk-ca-bundle.pl"
  end

  test do
    # Fetch the curl tarball and see that the checksum matches.
    # This requires a network connection, but so does Homebrew in general.
    filename = (testpath/"test.tar.gz")
    system bin/"curl", "-L", stable.url, "-o", filename
    filename.verify_checksum stable.checksum

    system libexec/"mk-ca-bundle.pl", "test.pem"
    assert_predicate testpath/"test.pem", :exist?
    assert_predicate testpath/"certdata.txt", :exist?
  end
end
