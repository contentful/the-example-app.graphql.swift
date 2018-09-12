#!/usr/bin/ruby

use_frameworks!
platform :ios, "11.0"
inhibit_all_warnings!

target 'the-example-app.swift' do
  pod 'Firebase/Core'
  pod 'SnowplowTracker'
  pod 'markymark'
  pod 'AlamofireImage', '~> 3.3'
  pod 'DeepLinkKit'
  pod 'Fabric'
  pod 'Crashlytics'
  pod 'Apollo', '~> 0.9.0'
  pod 'Contentful/ImageOptions', :git => 'https://github.com/contentful/contentful.swift.git', :branch => 'master'

  target 'the-example-app.swiftTests' do
    inherit! :search_paths
    pod 'Nimble'
    pod 'KIF'
  end

  post_install do |installer|	
    installer.pods_project.targets.each do |target|	
      target.build_configurations.each do |config|	
        config.build_settings['SWIFT_VERSION'] = '4.1'	
      end	
    end	
  end
end

