Pod::Spec.new do |s|
s.name             = "WUHExpand"
s.version          = "0.0.1"
s.summary          = "Expand  used on iOS."
s.description      = <<-DESC
                    It is a marquee view used on iOS, which implement by Objective-C.
                     DESC
s.homepage         = "https://github.com/kiwh/WUHExpand"
# s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
s.license          = 'MIT'
s.author           = { "吴浩" => "kiwh77@126.com" }
s.source           = { :git => "https://github.com/kiwh/WUHExpand.git", :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/NAME'
s.platform     = :ios, '4.3'
# s.ios.deployment_target = '5.0'
# s.osx.deployment_target = '10.7'
s.requires_arc = true
s.source_files = 'WUH*.h'
s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'

end
