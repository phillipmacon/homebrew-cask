cask "openbci" do
  version "5.1.0,2022-05-27_17-35-19"
  sha256 "f620cf6ed7c01223e63058cbd383180b7584642f625a05132816f23884b34e59"

  url "https://github.com/OpenBCI/OpenBCI_GUI/releases/download/v#{version.csv.first}/openbcigui_v#{version.csv.first}_#{version.csv.second}_macosx.dmg",
      verified: "github.com/OpenBCI/OpenBCI_GUI/"
  name "OpenBCI"
  desc "Connect to OpenBCI hardware, visualize and stream physiological data"
  homepage "https://openbci.com/"

  livecheck do
    url "https://github.com/OpenBCI/OpenBCI_GUI/releases/latest"
    regex(/openbcigui[._-]v?(\d+(?:\.\d+)+)[._-](.+)[._-]macosx\.dmg/i)
    strategy :header_match do |headers, regex|
      next if headers["location"].blank?

      # Identify the latest tag from the response's `location` header
      latest_tag = File.basename(headers["location"])
      next if latest_tag.blank?

      # Fetch the assets list HTML for the latest tag and match within it
      assets_page = Homebrew::Livecheck::Strategy.page_content(
        @url.sub(%r{/releases/?.+}, "/releases/expanded_assets/#{latest_tag}"),
      )
      assets_page[:content]&.scan(regex)&.map { |match| "#{match[0]},#{match[1]}" }
    end
  end

  auto_updates true

  app "OpenBCI_GUI.app"

  zap trash: "~/Documents/OpenBCI_GUI"
end
