#
# Be sure to run `pod lib lint ZH_Scan.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZH_Scan'
  s.version          = '1.1'
  s.summary          = '使用系统原生库实现的扫描组件'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  使用系统原生库实现扫描功能；扫描功能和UI视图分离；使用面向接口思想，扫描动画可扩展；底层替换扫描库业务无感知；
                       DESC

  s.homepage         = 'https://github.com/miaozhihui/ZH_Scan'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'miaozhihui' => 'miaozhihui@xdf.cn' }
  s.source           = { :git => 'https://github.com/miaozhihui/ZH_Scan.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ZH_Scan/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ZH_Scan' => ['ZH_Scan/Assets/*.png']
  # }
  
  s.resources = "ZH_Scan/Assets/ZH_Scan.bundle"
  
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
