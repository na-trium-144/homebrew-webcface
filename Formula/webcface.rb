class Webcface < Formula
  desc "Web-based RPC & UI Library"
  homepage "https://github.com/na-trium-144/webcface"
  url "https://github.com/na-trium-144/webcface/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "71791c3710ab14c9efefd2af77f87a4ec64a57b1aaf6b38d452a4c8fbac78e1e"
  license "MIT"

  depends_on "msgpack-cxx"
  depends_on "spdlog"
  depends_on "cmake" => :build
  depends_on "googletest" => :build
  depends_on "git" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    system "rmdir", "external/eventpp", "external/cinatra", "external/tclap"
    system "git", "clone", "https://github.com/wqking/eventpp.git", "external/eventpp"
    system "git", "clone", "https://github.com/qicosmos/cinatra.git", "external/cinatra"
    system "git", "clone", "https://git.code.sf.net/p/tclap/code", "external/tclap"
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DWEBCFACE_EXAMPLE=on", "-DWEBCFACE_TEST=on"
    system "cmake", "--build", "build"
    system "sh", "-c", "cd build && ctest"
    system "cmake", "--install", "build"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test webcface`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "#{bin}/program", "-h"
  end
end
