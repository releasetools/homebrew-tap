# releasetools tap

## How do I install these formulae?

### One shot

- Execute `brew install releasetools/tap/releasetools-cli`

### Tap and install

- Run `brew tap releasetools/tap`
- And then `brew install releasetools-cli`.

### Brew bundle

Add the following lines to a [`brew bundle`](https://github.com/Homebrew/homebrew-bundle) `Brewfile`:

```ruby
tap "releasetools/tap"
brew "releasetools-cli"
```

## Developers

### Local development

See the following commands:

```shell

### Check the formula
make check
```

### Update the formula version

A release of [releasetools/cli](https://github.com/releasetools/cli) asks
`bump-formula.yml` to update the formula, which also runs daily. It points the
formula at the new `releasetools.bash` and its published checksum, commits that
as a signed commit, opens a pull request and queues it to merge. `main` requires
`brew test-bot` to pass on macOS and both Ubuntu runners, so the update merges
once the formula installs everywhere and stays open when it does not.

To bump to a particular release by hand:

```shell
gh workflow run bump-formula.yml -f version=vX.Y.Z
```
