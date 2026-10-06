cask "monkeyforge" do
  arch arm: "arm64", intel: "x86_64"

  version "1.51.0"
  sha256 arm:          "8bc197453fbe7d8c2edde1705fe0025425ac20f7932c15a4b751f625d3113ceb",
         arm64_linux:  "0b39d44199bdb04eeed00087ed33be87d4a95e99c837e602ff6e20649f8b10df",
         x86_64_linux: "a74b9aad64e6aa7d9941daf2ecb0114c3707a169e988a37bfcee0ae4b2c832d7"

  on_macos do
    url "https://updates.monkeyforge.dev/MonkeyForge-#{version}-arm64.dmg"

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
  on_linux do
    url "https://packages.monkeyforge.dev/appimage/MonkeyForge-#{version}-#{arch}.AppImage"

    # The target carries no version on purpose: electron-updater rewrites the
    # AppImage in place when it self-updates, and a versioned name would leave
    # Homebrew's record pointing at a file that no longer exists.
    app_image "MonkeyForge-#{version}-#{arch}.AppImage", target: "MonkeyForge.AppImage"

    zap trash: "~/.config/MonkeyForge"
  end

  name "MonkeyForge"
  desc "Desktop workbench for driving coding agents"
  homepage "https://monkeyforge.dev/"

  livecheck do
    url "https://updates.monkeyforge.dev/latest-mac.yml"
    regex(/^version:\s*v?(\d+(?:\.\d+)+)/i)
  end
end
