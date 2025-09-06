class ReleasetoolsCli < Formula
  desc "Release tools for GitHub workflows and local use"
  homepage "https://release.tools"
  url "https://github.com/releasetools/bash/releases/download/v0.0.12/releasetools.bash"
  sha256 "331773a21828008b350cb6414605322f89873ead7aec35df5f5229e25e67605a"
  license "Apache-2.0"
  head "https://github.com/releasetools/bash.git", branch: "main"

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
