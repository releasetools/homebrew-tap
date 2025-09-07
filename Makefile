# define a variable to hold the name of the formula
FORMULA_NAME=releasetools-cli

.PHONY: install
install:
	@brew tap releasetools/tap $(PWD) 2>/dev/null || true
	@brew install releasetools/tap/$(FORMULA_NAME) 2>/dev/null || true

.PHONY: check
check: install
	@brew audit --strict --online releasetools/tap/$(FORMULA_NAME)

.PHONY: uninstall
uninstall:
	@brew uninstall releasetools/tap/$(FORMULA_NAME) 2>/dev/null || true
	@brew untap releasetools/tap 2>/dev/null || true
