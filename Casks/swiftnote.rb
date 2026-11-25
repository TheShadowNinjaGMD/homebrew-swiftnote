cask "swiftnote" do
  version "1.2.1"
  sha256 "e5c77a45ec870ac0e1ae04830a78fabe789abb4508b4024193490205ec261128"

  url "https://github.com/TheShadowNinjaGMD/SwiftNote/releases/download/v#{version}/SwiftNote-#{version}.dmg"
  name "SwiftNote"
  desc "Quick-note app that lives in the macOS menu bar"
  homepage "https://github.com/TheShadowNinjaGMD/SwiftNote"

  livecheck do
    url :url
    strategy :github_latest
  end

  # SwiftNote updates itself with Sparkle.
  auto_updates true
  depends_on macos: ">= :sonoma"

  app "SwiftNote.app"

  # SwiftNote isn't notarised yet, so macOS would otherwise refuse to open it the first time.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/SwiftNote.app"],
                   sudo: false
  end

  # Your notes in ~/Library/Application Support/SwiftNote and ~/Desktop/Swiftnote are deliberately left alone.
  zap trash: [
    "~/Library/Caches/com.anaypatro.SwiftNote",
    "~/Library/Preferences/com.anaypatro.SwiftNote.plist",
    "~/Library/Saved Application State/com.anaypatro.SwiftNote.savedState",
  ]
end
