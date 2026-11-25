cask "swiftnote" do
  version "1.2.2"
  sha256 "e37bf2718824c64e1bf24e27dd9133547944ba047fe126532bf165c35b472fbe"

  url "https://github.com/TheShadowNinjaGMD/SwiftNote/releases/download/v#{version}/SwiftNote-#{version}.zip"
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
