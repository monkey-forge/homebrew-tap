cask "monkeyforge" do
  version "1.49.2"
  sha256 "ebc01174f5a8cf543700a2c33843618f89c6266904268c0b32b5089239665a4f"

  url "https://updates.monkeyforge.dev/MonkeyForge-#{version}-arm64.dmg"
  name "MonkeyForge"
  desc "Desktop workbench for driving coding agents"
  homepage "https://monkeyforge.dev/"

  livecheck do
    url "https://updates.monkeyforge.dev/latest-mac.yml"
    regex(/^version:\s*v?(\d+(?:\.\d+)+)/i)
  end

  # Apple Silicon only: the release build produces one macOS artifact
  # (scripts/release.mjs), so an Intel Mac gets a clear refusal here rather
  # than a 404 from the download.
  depends_on arch: :arm64
  depends_on macos: :monterey

  app "MonkeyForge.app"

  zap trash: [
    "~/Library/Application Support/MonkeyForge",
    "~/Library/Logs/MonkeyForge",
    "~/Library/Preferences/cz.monkeydev.forge.plist",
    "~/Library/Saved Application State/cz.monkeydev.forge.savedState",
  ]
end
