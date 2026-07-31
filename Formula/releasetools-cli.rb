class ReleasetoolsCli < Formula
  desc "Release tools for GitHub workflows and local use"
  homepage "https://release.tools"
  url "https://github.com/releasetools/cli/releases/download/v0.0.15/releasetools.bash"
  sha256 "134b2eb3b1251cc466adfd81e51905844834bedb783b333690cdeda4b58b1af4"
  license "Apache-2.0"
  head "https://github.com/releasetools/cli.git", branch: "main"

  depends_on "python3" => :build

  def install
    # system Formula["python"].opt_bin/"pip3", "install", "--user", "--break-system-packages", "toml"
    system "python3", "-m", "pip", "install", *std_pip_args(build_isolation: true), "toml"
    bin.install "releasetools.bash" => "releasetools"
    bin.install_symlink bin/"releasetools" => "rt"
  end

  test do
    system bin/"releasetools", "version"
    system bin/"releasetools", "base::check_deps"
  end
end
