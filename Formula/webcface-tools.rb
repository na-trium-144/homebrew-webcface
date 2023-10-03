class WebcfaceTools < Formula
  desc "WebCFace Client Applications"
  homepage "https://github.com/na-trium-144/webcface-tools"
  url "https://github.com/na-trium-144/webcface-tools/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "84360c16df1a793a0425c48e0158dd6eac86892db4bb95447e9b749771e57ff6"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "webcface"

  def install
    rmdir(%w[external/tiny-process-library external/tomlplusplus])
    system "git", "clone", "https://gitlab.com/eidheim/tiny-process-library.git", "external/tiny-process-library"
    system "git", "clone", "https://github.com/marzer/tomlplusplus.git", "external/tomlplusplus"
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_predicate bin/"webcface-launcher", :exist?
  end
end
