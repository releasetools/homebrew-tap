class ReleasetoolsCli < Formula
  desc "Release tools for GitHub workflows and local use"
  homepage "https://release.tools"
  url "https://github.com/releasetools/cli/releases/download/v0.2.0/releasetools.bash"
  sha256 "1a876020a294cb2f0845ff8278cddc01529dc7e3d387f8ab57c02bb9aacd4ad0"
  license "Apache-2.0"
  head "https://github.com/releasetools/cli.git", branch: "main"

  # Nothing at runtime. git and coreutils are always present, and the GitHub CLI is needed
  # only by the github:: namespace, which checks for it at call time rather than having it
  # installed for everybody: Homebrew's :optional and :recommended both add an install-time
  # option and are disallowed in homebrew-core, and :run is audited as a no-op.
  #
  # :test is the exception. The block below runs base::check_deps, which reports on every
  # namespace at once and fails when any of them is missing a command, so the test needs gh
  # from releasetools/cli v0.1.0 onwards even though someone calling only git:: does not.
  depends_on "gh" => :test

  def install
    bin.install "releasetools.bash" => "releasetools"
    bin.install_symlink bin/"releasetools" => "rt"
  end

  test do
    system bin/"releasetools", "version"
    system bin/"releasetools", "base::check_deps"
  end
end
