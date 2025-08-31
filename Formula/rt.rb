class Rt < Formula
  desc "Release tools for shell and GitHub workflows"
  homepage "https://release.tools"
  url "https://github.com/releasetools/bash/releases/download/v0.0.11/releasetools.bash"
  sha256 "7bf2bdbfa8bf81d76bd3e1f7f2d39ad0f604ef564e5c9dadca36e92fa93fe97d"
  license "Apache-2.0"
  head "https://github.com/releasetools/bash.git", branch: "main"

  depends_on "python3" => :build

  def install
    # system Formula["python"].opt_bin/"pip3", "install", "--user", "--break-system-packages", "toml"
    system "python3", "-m", "pip", "install", *std_pip_args(build_isolation: true), "toml"
    bin.install "releasetools.bash" => "rt"
  end

  test do
    system bin/"rt", "version"
    system bin/"rt", "base::check_deps"
  end
end
