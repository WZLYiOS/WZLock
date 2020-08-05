Pod::Spec.new do |s|
  
  s.name             = 'WZLock'
  s.version          = '2.0.0'
  s.summary          = 'lock安全锁'
  
  s.description      = <<-DESC
  我主良缘锁
  DESC
  
  s.homepage         = 'https://github.com/WZLYiOS/WZLock'
  s.license          = 'MIT'
  s.author           = { 'LiuSky' => '327847390@qq.com' }
  s.source           = { :git => 'https://github.com/WZLYiOS/WZLock.git', :tag => s.version.to_s }
  
  s.requires_arc = true
  s.static_framework = true
  s.swift_version         = '5.0'
  s.ios.deployment_target = '9.0'
  s.default_subspec = 'Source'
  
  s.subspec 'Source' do |ss|
    ss.source_files = 'WZLock/Classes/*.swift'
  end


  #s.subspec 'Binary' do |ss|
  #  ss.vendored_frameworks = "Carthage/Build/iOS/Static/WZLock.framework"
  #end
end

