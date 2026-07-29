#!/usr/bin/env bash
#
# bump-formula.sh - points the formula at the latest releasetools/cli release
#
# Renovate cannot do this. Its homebrew manager parses our 'url' correctly, but when it
# writes a new one it only ever tries two hardcoded shapes:
#
#   https://github.com/<owner>/<repo>/releases/download/<version>/<repo>-<semver>.tar.gz
#   https://github.com/<owner>/<repo>/archive/refs/tags/<version>.tar.gz
#
# The first does not exist for us; the second is the source archive, which does not contain
# 'releasetools.bash' at all -- 'dist/' is gitignored upstream. Taking it would give the
# formula a correct checksum for the wrong file and break 'bin.install'.
#
# So the bump is done here, against the actual release asset, and the published checksum is
# verified rather than recomputed and hoped over.
#
# Usage: bump-formula.sh [--check]
#        --check: report whether a bump is needed, change nothing
#
# Copyright (c) 2025 Mihai Bojin, https://MihaiBojin.com/
#
# Licensed under the Apache License, Version 2.0
#   http://www.apache.org/licenses/LICENSE-2.0
#

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../" && pwd -P)"
readonly DIR

FORMULA="$DIR/Formula/releasetools-cli.rb"
readonly FORMULA
UPSTREAM="releasetools/cli"
readonly UPSTREAM
ASSET="releasetools.bash"
readonly ASSET

check_only=false
while [ "$#" -gt 0 ]; do
  case "$1" in
  --check)
    check_only=true
    shift
    ;;
  *)
    echo "ERROR: unknown option '$1'" >&2
    exit 1
    ;;
  esac
done

if [ ! -f "$FORMULA" ]; then
  echo "ERROR: '$FORMULA' does not exist." >&2
  exit 1
fi

# The version currently pinned in the formula's download URL.
CURRENT="$(sed -n 's|.*/releases/download/\(v[0-9][^/]*\)/.*|\1|p' "$FORMULA" | head -1)"
readonly CURRENT

# Empty means the URL no longer has the shape this script assumes. Carrying on would
# rewrite the formula from a wrong starting point, so stop instead.
if [ -z "$CURRENT" ]; then
  echo "ERROR: could not read a version from the url in '$FORMULA'." >&2
  exit 1
fi

LATEST="$(gh release view --repo "$UPSTREAM" --json tagName -q .tagName)"
readonly LATEST

if [ -z "$LATEST" ]; then
  echo "ERROR: could not resolve the latest '$UPSTREAM' release." >&2
  exit 1
fi

echo "formula: $CURRENT" >&2
echo "latest:  $LATEST" >&2

if [ "$CURRENT" = "$LATEST" ]; then
  echo "Already up to date." >&2
  exit 0
fi

if [ "$check_only" = true ]; then
  echo "A bump to $LATEST is available." >&2
  exit 0
fi

URL="https://github.com/$UPSTREAM/releases/download/$LATEST/$ASSET"
readonly URL

WORK="$(mktemp -d)"
readonly WORK
# shellcheck disable=SC2064 # WORK is expanded now, deliberately
trap "rm -rf '$WORK'" EXIT

echo "Downloading $URL..." >&2
curl -sSLf -o "$WORK/$ASSET" "$URL"
curl -sSLf -o "$WORK/$ASSET.sha256" "$URL.sha256"

# The release publishes its own checksum. Verifying it means a corrupted or truncated
# download cannot become the formula's sha256.
if ! (cd "$WORK" && shasum -a 256 -c "$ASSET.sha256" >/dev/null); then
  echo "ERROR: checksum verification failed for $URL" >&2
  exit 1
fi

SHA="$(awk '{print $1}' "$WORK/$ASSET.sha256")"
readonly SHA

if [ -z "$SHA" ]; then
  echo "ERROR: could not read the checksum from $URL.sha256" >&2
  exit 1
fi

# Rewritten via a temp file rather than 'sed -i', which needs an argument on BSD and
# rejects one on GNU.
sed \
  -e "s|^  url \".*\"|  url \"$URL\"|" \
  -e "s|^  sha256 \".*\"|  sha256 \"$SHA\"|" \
  "$FORMULA" >"$WORK/formula.rb"
cat "$WORK/formula.rb" >"$FORMULA"

# Confirm the rewrite landed. A line-anchored sed silently does nothing if the file is
# shaped differently than expected, which would leave the old version in place while
# this script reported success.
if ! grep -qF "url \"$URL\"" "$FORMULA"; then
  echo "ERROR: the url was not updated in '$FORMULA'." >&2
  exit 1
fi

if ! grep -qF "sha256 \"$SHA\"" "$FORMULA"; then
  echo "ERROR: the sha256 was not updated in '$FORMULA'." >&2
  exit 1
fi

echo "Updated the formula to $LATEST." >&2
echo "$LATEST"
