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

See the following commands:

```shell

### Test installation
make install

### Run brew tests
make test

### Check formula
make check
```
