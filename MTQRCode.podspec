#
# Be sure to run `pod lib lint MTQRCode.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MTQRCode'
  s.version          = '0.1.0'
  s.summary          = 'Simple QRCode detector and generator.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Secrimart/MTQRCode'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Secrimart' => 'secrimart@aliyun.com' }
  s.source           = { :git => 'https://github.com/Secrimart/MTQRCode.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  
  s.subspec 'QRCapture' do |capture|
      capture.source_files = 'MTQRCode/Classes/QRCapture/*.*'
      capture.public_header_files = 'MTQRCode/Classes/QRCapture/*.h'
  end
  
  s.subspec 'QRGenerator' do |generator|
      generator.source_files = 'MTQRCode/Classes/QRGenerator/*.*'
      generator.public_header_files = 'MTQRCode/Classes/QRGenerator/*.h'
  end
  
end
