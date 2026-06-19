VERSION := $(shell grep '^version' Cargo.toml | head -1 | sed 's/.*= *"\(.*\)"/\1/')

run:
	cargo r

bundle:
	cargo bundle --release
	@echo "\n✅ Copying build artifacts to project root..."
	cp -R target/release/bundle/osx/TanTanKey.app "$(PWD)/TanTanKey.app"
	cp -R target/release/bundle/dmg/GoKey.dmg "$(PWD)/TanTanKey.dmg"
	@echo "📦 $(PWD)/TanTanKey.app"
	@echo "📦 $(PWD)/TanTanKey.dmg"

setup:
	mkdir -p .git/hooks
	cp -rf scripts/pre-commit .git/hooks
	chmod +x .git/hooks/pre-commit

# Build, sign, notarize, and produce TanTanKey-v<VERSION>.zip ready for release.
# Requires: cargo-bundle, a valid "Developer ID Application" cert, and the
# AC_PASSWORD keychain profile configured via xcrun notarytool.
release: bundle
	bash scripts/release
	cd target/release/bundle/osx && \
	  ditto -c -k --keepParent TanTanKey.app TanTanKey-v$(VERSION).zip
	@echo "Release asset: target/release/bundle/osx/TanTanKey-v$(VERSION).zip"
	@echo "SHA256: $$(shasum -a 256 target/release/bundle/osx/TanTanKey-v$(VERSION).zip | awk '{print $$1}')"

# Update Casks/tantankey.rb with the SHA256 of the just-built release zip.
# Run after `make release` before tagging.
update-cask:
	$(eval SHA256 := $(shell shasum -a 256 target/release/bundle/osx/TanTanKey-v$(VERSION).zip | awk '{print $$1}'))
	sed -i '' 's/version ".*"/version "$(VERSION)"/' Casks/tantankey.rb
	sed -i '' 's/sha256 ".*"/sha256 "$(SHA256)"/' Casks/tantankey.rb
	@echo "Casks/tantankey.rb updated → version=$(VERSION) sha256=$(SHA256)"
