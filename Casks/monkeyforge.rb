cask "monkeyforge" do
  arch arm: "arm64", intel: "x86_64"

  version "1.50.0"
  sha256 arm:          "a2105914980f2a6cb18e58dae4937fd6de4ec55076792f3dcf6cae812f461d29",
         arm64_linux:  "14e36e8642959c2c34aa9a20d50a2a4b972697e9a1a7935c08ca048f4df85027",
         x86_64_linux: "cc491f9d02899e467dd8b6fa7d3184345d29692d549dc523f774dae0ce28f758"

  on_macos do
    url "https://updates.monkeyforge.dev/MonkeyForge-#{version}-arm64.dmg"

    # Apple Silicon only: the release build produces one macOS artifact
    # (scripts/release.mjs), so an Intel Mac gets a clear refusal here rather
    # than a 404 from the download.
    depends_on arch: :arm64
    depends_on macos: :monterey

    # 1.50.0's bundle is lowercase (fixed in the next release); the target keeps
    # the installed name. Back to plain `app "MonkeyForge.app"` after 1.50.x.
    app "monkeyforge.app", target: "MonkeyForge.app"

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
