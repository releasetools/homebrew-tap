# define a variable to hold the name of the formula
FORMULA_NAME=releasetools-cli

.PHONY: install
install:
	@if brew list $(FORMULA_NAME) > /dev/null 2>&1; then \
        brew reinstall --build-from-source ./Formula/$(FORMULA_NAME).rb; \
    else \
        brew install --HEAD --build-from-source ./Formula/$(FORMULA_NAME).rb; \
    fi

.PHONY: test
test:
	@brew test --verbose ./Formula/$(FORMULA_NAME).rb

.PHONY: check
check:
	@brew audit --strict --online releasetools/tap/$(FORMULA_NAME)

.PHONY: uninstall
uninstall:
	@brew uninstall ./Formula/$(FORMULA_NAME).rb
