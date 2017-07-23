Pod::Spec.new do |s|
  s.name             = "RuntimeHelper"
  s.version          = "0.0.1"
  s.summary          = "Provide some OO methods about runtime."
  s.description      = <<-DESC
                       Provide some OO methods about runtime.
                       DESC
  s.homepage         = "https://github.com/yumumu/RuntimeHelper.git"
  # s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "yumumu" => "webmanyu@gmail.com" }
  s.source           = { :git => "https://github.com/yumumu/RuntimeHelper.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/NAME'

  s.platform     = :ios, '9.0'
  # s.ios.deployment_target = '5.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = 'RuntimeHelper/*'
  # s.resources = 'Assets'

  # s.ios.exclude_files = 'Classes/osx'
  # s.osx.exclude_files = 'Classes/ios'
  # s.public_header_files = 'Classes/**/*.h'
  s.frameworks = 'Foundation'

end