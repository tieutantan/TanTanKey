#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT_DIR"

echo "🔨 Building TanTanKey..."
echo ""

# Step 1: Convert icon.png → icon.icns if PNG is newer
if [[ icons/icon.png -nt icons/icon.icns ]]; then
    echo "📸 Updating icon.icns from icon.png..."
    sips -s format icns icons/icon.png --out icons/icon.icns &>/dev/null
fi

# Step 2: Build release + bundle
echo "⚙️  cargo bundle --release..."
cargo bundle --release

# Step 3: Copy artifacts to project root
echo ""
echo "📂 Copying build artifacts to project root..."
cp -R target/release/bundle/osx/TanTanKey.app "$ROOT_DIR/TanTanKey.app"
cp target/release/bundle/dmg/TanTanKey.dmg "$ROOT_DIR/TanTanKey.dmg" 2>/dev/null || true

echo ""
echo "✅ Build complete!"
echo "   📦 $ROOT_DIR/TanTanKey.app"
echo "   📦 $ROOT_DIR/TanTanKey.dmg"
