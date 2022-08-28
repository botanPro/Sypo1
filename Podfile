# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'


target 'OneSignalNotificationServiceExtension' do
    # Comment the next line if you don't want to use dynamic frameworks
    use_frameworks!
    pod 'OneSignalXCFramework', '>= 3.0.0', '< 4.0'
  end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end


target 'RealEstates' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  source 'https://cdn.cocoapods.org/'
  # Pods for RealEstates
  pod 'OneSignalXCFramework', '>= 3.0.0', '< 4.0'
  
  pod 'Alamofire'
  pod 'SwiftyJSON'
  pod 'CRRefresh'
  pod 'FSPagerView'
  pod 'SDWebImage'
  pod 'PureLayout'
  pod 'MBRadioCheckboxButton'
  pod "CollieGallery"
  pod 'Cosmos'
  
  
  pod 'Firebase'
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  pod 'Firebase/Analytics'
  pod 'Firebase/Core'
  pod 'Firebase/Database'
  pod 'Firebase/Storage'
  pod 'Firebase/DynamicLinks'
  pod 'Firebase/RemoteConfig'
  
  pod 'NSFWDetector'
  
  pod 'ValidationTextField'
  
  pod 'HMSegmentedControl'
  pod 'MXSegmentedPager'
  pod 'AZDialogView'
  pod 'UIView-Shimmer', '~> 1.0'
  pod "Slider2"
  pod "BSImagePicker", "~> 2.8"
  pod 'ScrollingPageControl'
  pod 'DropDown'
  pod 'OTPTextField'
  pod 'MHLoadingButton'
  pod 'PhoneNumberKit', '~> 3.3'
  
  pod 'Toast-Swift', '~> 5.0.1'
  
  pod 'EmptyDataSet-Swift', '~> 5.0.0'
  
  pod "AAShimmerView"
  
  pod 'SKPhotoBrowser'
  
  pod 'YoutubePlayer-in-WKWebView', '~> 0.2.0'
  
  pod 'FCAlertView'

  pod 'ShimmerLabel', '~> 1.0'
  
  pod 'FlipLabel'
  
  pod 'Drops', :git => 'https://github.com/omaralbeik/Drops.git', :tag => '1.5.0'
  
  pod 'NVActivityIndicatorView'
  
  pod 'EmptyDataSet-Swift', '~> 5.0.0'
  
  pod 'GIFImageView'
  
  pod 'FirebaseCheckVersion'
  
  pod "PullToDismissTransition"
  
  
  
  
  
  pod 'NSFWDetector'
  
  
  target 'RealEstatesTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'RealEstatesUITests' do
    # Pods for testing
  end

end
