Pod::Spec.new do |s|
  s.name             = 'HSPopupMenu'
  s.version          = '0.1.1'
  s.swift_version    = '4.0'
  s.summary          = 'A Popup Menu.'
  s.homepage         = 'https://github.com/zyphs21/HSPopupMenu'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zyphs21' => 'hansenhs21@live.com' }
  s.source           = { :git => 'https://github.com/zyphs21/HSPopupMenu.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'HSPopupMenu/Classes/**/*'
  
  # s.resource_bundles = {
  #   'HSPopupMenu' => ['HSPopupMenu/Assets/*.png']
  # }

  s.dependency 'SnapKit', '~> 4.0.0'
end
