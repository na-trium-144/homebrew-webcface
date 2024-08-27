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

  livecheck do
    url "https://curl.se/download/"
    regex(/href=.*?curl[._-]v?(.*?)\.t/i)
  end

  bottle do
    root_url "https://github.com/na-trium-144/homebrew-webcface/releases/download/curl-ws-8.9.1"
    sha256 cellar: :any,                 arm64_sonoma: "0b57c1de03b1c89b9c6c96c6043d81201ddf9a0af40d883110bd1a48a0baab45"
    sha256 cellar: :any,                 ventura:      "e18a35be3eafeaefb86cb20f432204ff4789d4cca4ea39926a4151bfa3d9f8a0"
    sha256 cellar: :any,                 monterey:     "fecc4ea8c657ccf8223749caa4f88b5aecb223ac945fb763e317fe5ed327f6b0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3f6fb747d98ace078a11c9efc9040ccf37f76fb034a1e531f1eea81456ecf706"
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
