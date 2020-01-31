# upgrades how to:
# 1. update s.version
# 2. run `pod spec lint nlohmann_json.podspec`
# 3. register a session with cocoapods
# 4. run `pod trunk push ./`

# see cocoapods documentation http://docs.cocoapods.org/specification.html for
# more details.
Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.name         = "nlohmann_json_cocoa"
  s.version      = "3.7.3"
  s.summary      = "JSON for Modern C++"


  # CocoaPods strips indentation for description
  s.description  = <<-DESC
    JSON library for modern c++, it can read & write JSON. If you know how to
    use std::vector or std::map, you are already set.
                   DESC

  s.homepage     = "https://github.com/nlohmann/json"
  s.screenshots  = "https://raw.githubusercontent.com/nlohmann/json/master/doc/json.gif"

  license_text = File.read("LICENSE.MIT")
  s.license      = { :type => "MIT", :text => license_text }
  s.authors      = {
    "Niels Lohmann" => "mail@nlohmann.me"
  }

  s.platform     = :ios, "9.0"
  s.ios.deployment_target = "9.0"
  s.osx.deployment_target = "10.12"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/nlohmann/json.git", :tag => "v#{s.version}" }

  s.source_files = "single_include/**/*.hpp"
  s.public_header_files = "single_include/nlohmann/json.hpp"
end
