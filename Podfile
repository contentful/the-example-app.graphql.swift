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

  target 'the-example-app.swiftTests' do
    inherit! :search_paths
    pod 'Nimble'
    pod 'KIF'
  end
end

