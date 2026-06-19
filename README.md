<p align="center">
	<img src="./icons/icon.png" width="90px">
</p>


# TanTanKey

**TanTanKey** (formerly **Gõkey**) — A Vietnamese input method editor for macOS.

### Option Install 1: Download the DMG Installer

Pre-built DMG files are available in the repository root as `TanTanKey.dmg`. Simply download and open it, then drag `TanTanKey.app` to your `/Applications` folder.

### Option Install 2: Build from source

The source code can be compiled easily:

1. Get the latest stable version of the Rust compiler ([see here](https://rustup.rs/))
2. Install the [cargo-bundle](https://github.com/burtonageo/cargo-bundle) extension, this is necessary for bundling macOS apps
   ```
   cargo install cargo-bundle
   ```
3. Checkout the source code:
   ```
   git clone https://github.com/tantn/tantankey && cd tantankey
   ```
4. Run the build script:

   ```
   ./build.sh
   ```

   The script will:
   - Convert `icon.png` → `icon.icns` if the PNG is newer.
   - Build the release bundle with `cargo bundle --release`.
   - Copy `TanTanKey.app` and `TanTanKey.dmg` to the project root.

   Or manually:

   ```
   cargo bundle --release
   ```

   After that, you'll find the `TanTanKey.app` file in the `target/release/bundle/osx/` folder. Copy it to your `/Applications` folder.

5. **(Important!):** Before you run the app, make sure you already allowed Accessibility access for the app. Without this step, the app will crash and can't be used.

## Development

```sh
# Run with UI-only mode (skip Accessibility permission check)
cargo r -- --skip-permission

# Force a specific UI language (vi or en), ignoring OS language
cargo r -- --lang vi
cargo r -- --lang en
```

## Build

The project ships with a `build.sh` script that automates the entire build process:

```sh
./build.sh
```

This will:
1. Update `icon.icns` from `icon.png` if the PNG has been modified.
2. Run `cargo bundle --release` to compile and bundle the app.
3. Copy the resulting `TanTanKey.app` and `TanTanKey.dmg` to the project root.

You can also use the `Makefile`:

```sh
make bundle    # Build release + copy artifacts
make run       # cargo r (debug build)
make setup     # Install git hooks
make release   # Build, sign, notarize, and produce release zip
```
