.PHONY: install
install:
	@if brew list rt > /dev/null 2>&1; then \
        brew reinstall --build-from-source ./Formula/rt.rb; \
    else \
        brew install --build-from-source ./Formula/rt.rb; \
    fi

.PHONY: test
test:
	@brew test --verbose ./Formula/rt.rb

.PHONY: check
check:
	@brew audit --strict --online rt

.PHONY: uninstall
uninstall:
	@brew uninstall ./Formula/rt.rb
