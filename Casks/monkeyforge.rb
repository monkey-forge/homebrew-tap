cask "monkeyforge" do
  arch arm: "arm64", intel: "x86_64"

  version "1.52.0"
  sha256 arm:          "844e9009f8ea277cc8ff0c9efb682837ca48cdcc1a85b07ca6cae7d39260f905",
         arm64_linux:  "35944818dd200faa6c206135b4fc40d4893d1131df4474555f2772fa1fd1f6c3",
         x86_64_linux: "864e71f9917c8991e2223279d7555173023284ea414e8dd87b279cd3fb057872"

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
