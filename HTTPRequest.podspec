#
# Be sure to run `pod lib lint HTTPRequest.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name                  = 'HTTPRequest'
  s.version               = '1.0.0'
  s.summary               = 'Model driven interface to HTTP networking.'
  s.description           = 'High level wrapper of Alamofire.'
  s.homepage              = 'https://github.com/3sidedcube/HTTPRequest'
  s.documentation_url     = s.homepage
  s.license               = { :type => 'Apache License 2.0', :file => 'LICENSE' }
  s.author                = { '3 Sided Cube' => 'holla@3sidedcube.com' }
  s.source                = { :git => 'https://github.com/3sidedcube/HTTPRequest.git', :tag => s.version.to_s }
  s.ios.deployment_target = '12.0'
  s.swift_versions        = ['5.5']
  s.source_files          = 'Sources/**/*.{swift,h,m}'
  s.dependency 'Alamofire', '~> 5.5.0'
end
