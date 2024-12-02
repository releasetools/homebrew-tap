# releasetools tap

## How do I install these formulae?

`brew install releasetools/tap/rt`

Or `brew tap releasetools/tap` and then `brew install rt`.

Or, in a [`brew bundle`](https://github.com/Homebrew/homebrew-bundle) `Brewfile`:

```ruby
tap "releasetools/tap"
brew "rt"
```

## Developers

### Local development

See the following commands:

```shell

### Test installation
make install

### Run brew tests
make test

### Check formula
make check
```

### Update the formula version

- Edit [rt.rb](Formula/rt.rb)
- Update `url=https://github.com/releasetools/bash/releases/download/vX.Y.Z/releasetools.bash`
- Generate a checksum and set it into the `sha256` field

  ```shell
  VERSION="vX.Y.Z" curl -sL https://github.com/releasetools/bash/releases/download/$VERSION/releasetools.bash | shasum -a 256
  ```
