cask "openzfs" do
  on_el_capitan :or_older do
    version "2.1.0,353"
    sha256 "66d74b3650ca3e099bcbec71733ad53664ba7f797a45920e73e0decb89de1a0d"
    pkg "OpenZFSonOsX-#{version.csv.first}-El.Capitan-10.11.pkg"
  end
  on_sierra do
    version "2.1.0,354"
    sha256 "1c47d2cc4ad12923c314b566b2c86ed8345dfa1af9f5b5fb28c0822eba7c3c03"
    pkg "OpenZFSonOsX-#{version.csv.first}-Sierra-10.12.pkg"
  end
  on_high_sierra do
    version "2.1.0,346"
    sha256 "3f5a09914c0d7243982d308b11f952edfc93de1b01bff7adeecc4f3214d58165"
    pkg "OpenZFSonOsX-#{version.csv.first}-High.Sierra-10.13.pkg"
  end
  on_mojave do
    version "2.1.0,345"
    sha256 "29ccb0e43cd351ac1b09b3ee435522d0e4694b6fb72a3241d042c31fbd71797f"
    pkg "OpenZFSonOsX-#{version.csv.first}-Mojave-10.14.pkg"
  end
  on_catalina do
    version "2.1.0,344"
    sha256 "0ee774a0f08cf6734238d1cbc71f9afb81ab0316e0a3e99efd1714c87df070f5"
    pkg "OpenZFSonOsX-#{version.csv.first}-Catalina-10.15.pkg"
  end
  on_big_sur :or_newer do
    on_intel do
      version "2.1.0,343"
      sha256 "2cc0c2da33be3ce331e922ba2ca7c585179e79f1addc72246f10df95b7d7b8d7"
      pkg "OpenZFSonOsX-#{version.csv.first}-Big.Sur-11.pkg"
    end
    on_arm do
      version "2.1.0,342"
      sha256 "af2fab94102434cbc8a2f289d177d4a4d94a9471a11f2129fb5416081ab47ae7"
      pkg "OpenZFSonOsX-#{version.csv.first}-Big.Sur-11-arm64.pkg"
    end
  end

  url "https://openzfsonosx.org/forum/download/file.php?id=#{version.csv.second}"
  name "OpenZFS on OS X"
  desc "ZFS driver and utilities"
  homepage "https://openzfsonosx.org/"

  livecheck do
    # url "https://openzfsonosx.org/wiki/Downloads"
    # regex(/href=["']?#v?(\d+(?:\.\d+)+(?:[._-]r\d+)?)["' >]/i)
    skip "Version comparison will always fail for now"
  end

  conflicts_with cask: "openzfs-dev"

  postflight do
    set_ownership "/usr/local/zfs"
  end

  uninstall_preflight do
    system "sudo", "/usr/local/zfs/bin/zpool", "export", "-af"
  end

  uninstall pkgutil:   "org.openzfsonosx.zfs",
            launchctl: [
              "org.openzfsonosx.InvariantDisks",
              "org.openzfsonosx.zconfigd",
              "org.openzfsonosx.zed",
              "org.openzfsonosx.zpool-import",
              "org.openzfsonosx.zpool-import-all",
            ]

  caveats do
    kext
  end
end
