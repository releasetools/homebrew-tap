class ReleasetoolsCli < Formula
  desc "Release tools for GitHub workflows and local use"
  homepage "https://release.tools"
  url "https://github.com/releasetools/cli/releases/download/v0.0.16/releasetools.bash"
  sha256 "cfacbd8f19f25f808f08dd559fae35401c322d32ae7ba9b93ca4447ba1f37dc4"
  license "Apache-2.0"
  head "https://github.com/releasetools/cli.git", branch: "main"

  # No dependencies. Every module is bash over git, gh and coreutils since
  # releasetools/cli#35 removed the python:: namespace, so there is nothing to declare.
  # Depending on python3 would have pulled 9 formulae and 126MB for a single function
  # that no repository called.

  def install
    bin.install "releasetools.bash" => "releasetools"
    bin.install_symlink bin/"releasetools" => "rt"
  end

  test do
    system bin/"releasetools", "version"
    system bin/"releasetools", "base::check_deps"
  end
end
