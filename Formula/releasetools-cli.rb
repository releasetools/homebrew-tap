class ReleasetoolsCli < Formula
  desc "Release tools for GitHub workflows and local use"
  homepage "https://release.tools"
  url "https://github.com/releasetools/cli/releases/download/v0.0.14/releasetools.bash"
  sha256 "edee9180fe0bd4f38d173b860912c2f44c657db5c178155b370f81531c317afe"
  license "Apache-2.0"
  head "https://github.com/releasetools/cli.git", branch: "main"

  # Runtime, not :build. The python:: module shells out to python3 every time it runs, so
  # a build-time dependency left `releasetools base::check_deps` failing with "python is
  # not installed" on any machine without one. Nothing else in the library needs python.
  depends_on "python3"

  def install
    # No pip install: the library reads pyproject.toml with tomllib, which is in the
    # standard library from python 3.11. It used to install the third-party "toml" here,
    # into a prefix the interpreter resolved at runtime never saw.
    bin.install "releasetools.bash" => "releasetools"
    bin.install_symlink bin/"releasetools" => "rt"
  end

  test do
    system bin/"releasetools", "version"
    system bin/"releasetools", "base::check_deps"
  end
end
