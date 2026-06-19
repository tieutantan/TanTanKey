cask "tantankey" do
  version "0.3.0"
  sha256 "e747009b9c78d2ea3d72ed5419c24090553cbc1c7095dc63145de89467c7649e"

  url "https://github.com/huytd/goxkey/releases/download/v#{version}/GoKey-v#{version}.zip"
  name "TanTanKey"
  desc "Vietnamese input method editor for macOS"
  homepage "https://github.com/huytd/goxkey"

  depends_on macos: ">= :monterey"

  app "TanTanKey.app"

  caveats <<~EOS
    TanTanKey requires Accessibility permission to intercept keyboard events.

    After launching the app, go to:
      System Settings → Privacy & Security → Accessibility
      → enable TanTanKey

    Default toggle shortcut: Ctrl+Space
  EOS
end
