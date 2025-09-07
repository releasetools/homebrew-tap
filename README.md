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

- Edit [releasetools-cli.rb](Formula/releasetools-cli.rb)
- Update `url=https://github.com/releasetools/bash/releases/download/vX.Y.Z/releasetools.bash`
- Update the checksum in the `sha256` field

  ```shell
  curl -sL "https://github.com/releasetools/bash/releases/download/vX.Y.Z/releasetools.bash.sha256"
  ```
