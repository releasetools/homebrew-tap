class Rt < Formula
  desc "Release tools for shell and GitHub workflows"
  homepage "https://release.tools"
  url "https://github.com/releasetools/bash/releases/download/v0.0.8/releasetools.bash"
  sha256 "dbbead4d3426a29330c25b669da73adeebcd5ff2b4c863e3ceb298a98f23ad68"
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
