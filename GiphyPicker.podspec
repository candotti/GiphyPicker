#
# Be sure to run `pod lib lint GiphyPicker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GiphyPicker'
  s.version          = '0.1.0'
  s.summary          = 'Picker for selecting Gifs from giphy.com'
  s.description      = <<-DESC
With GiphyPicker you can search and use a Giphy image in your project.
The only thing you need is a token generated from giphy.com website.
                       DESC
  s.homepage         = 'https://github.com/candotti/GiphyPicker'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daniele Candotti' => 'daniele@candotti.info' }
  s.source           = { :git => 'https://github.com/candotti/GiphyPicker.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/danielecandotti'
  s.ios.deployment_target = '10.0'
  s.source_files = 'GiphyPicker/Classes/**/*'
  s.resource = 'GiphyPicker/Assets/*.xib'
  s.dependency 'GiphyCoreSDK', '~> 1.4.2'
  s.dependency 'SDWebImage', '~> 5.0.4'
  s.test_spec 'UnitTests' do |test_spec|
    test_spec.source_files = 'GiphyPicker/Tests/**/*.{h,m,swift}'
  end
end
