# Uncomment this line to define a global platform for your project
platform :ios, '9.0'

target 'FareComparator' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for FareComparator
  pod 'UberRides', :git => 'https://github.com/long/rides-ios-sdk.git', :branch => 'swift-3-dev'
  pod 'IBAnimatable'
  pod 'R.swift'
  pod 'SwiftMessages'
  pod 'AMap3DMap'  #3D地图SDK
  pod 'AMapSearch' #搜索服务SDK
  pod 'Then'
  pod 'DZNEmptyDataSet'
  pod 'RevealingSplashView'
  pod 'ChameleonFramework/Swift', :git => 'https://github.com/ViccAlexander/Chameleon.git', :branch => 'swift3-readme'
end

post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			config.build_settings['SWIFT_VERSION'] = '3.0'
		end
	end
end
