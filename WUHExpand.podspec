Pod::Spec.new do |s|
    s.name         = 'WUHExpand'
    s.version      = '0.0.1'
    s.summary      = 'The Expand used on iOS'
    s.homepage     = 'https://github.com/kiwh/WUHExpand'
    s.license      = 'MIT'
    s.authors      = {'Kiwh' => '308801737@qq.com'}
    s.platform     = :ios, '7.0'
    s.source       = {:git => 'https://github.com/kiwh/WUHExpand.git', :tag => s.version}
    s.source_files = 'WUHExpandHeader.h'
    s.requires_arc = true
	s.frameworks = 'Foundation', 'UIKit', 'CoreGraphics'
end
