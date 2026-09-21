<p align="center">
  <img src="assets/monkeyforge.png" width="128" alt="MonkeyForge">
</p>

<h1 align="center">MonkeyForge Homebrew tap</h1>

<p align="center">Desktop workbench for driving coding agents.</p>

## Install

```bash
brew tap monkey-forge/tap
brew install --cask monkeyforge
```

Apple Silicon only for now — the release build produces a single macOS
artifact, so the cask refuses an Intel Mac instead of handing it a download
that is not there.

## Upgrading

```bash
brew upgrade --cask monkeyforge
```

The app also updates itself (electron-updater, feed at
`updates.monkeyforge.dev`), so a self-updated install may already be newer
than the cask says.

## Linux

Not yet. The Linux packages exist — `.deb` and AppImage, both architectures —
but nothing publishes them to a URL a cask could point at. The `app_image`
stanza is ready to go in once they are served.

When they land, note that Homebrew installs without root, so it cannot write
the AppArmor profile that lets the agent sandbox create a user namespace on
Ubuntu 23.10+. The app installs its own:

```bash
monkeyforge sandbox status           # what the sandbox can do on this machine
monkeyforge sandbox install-profile  # one pkexec prompt
```

## What this repository is

A [Homebrew tap](https://docs.brew.sh/Taps): one cask definition, nothing
else. `brew tap monkey-forge/tap` clones it straight from GitHub, which is why
the repository is named `homebrew-tap` and lives here rather than beside the
source.
