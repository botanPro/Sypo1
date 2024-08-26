# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'


#target 'OneSignalNotificationServiceExtension' do
    # Comment the next line if you don't want to use dynamic frameworks
    #use_frameworks!
    #pod 'OneSignalXCFramework', '>= 3.0.0', '< 4.0'
  #end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      xcconfig_path = config.base_configuration_reference.real_path
      xcconfig = File.read(xcconfig_path)
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
      File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
    end
  end
end


target 'RealEstates' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  source 'https://cdn.cocoapods.org/'
  # Pods for RealEstates
  #pod 'OneSignalXCFramework', '>= 3.0.0', '< 4.0'
  
  pod 'Alamofire'
  pod 'SwiftyJSON'
  pod 'CRRefresh'
  pod 'FSPagerView'
  pod 'SDWebImage'
  pod 'PureLayout'
  pod 'MBRadioCheckboxButton'
  pod "CollieGallery"
  pod 'Cosmos'
  pod 'XP_PDFReader'
  pod "EPSignature"
  pod 'PDFReader'
  
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
  
  
  pod 'Stripe'
  
  
  
  target 'RealEstatesTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'RealEstatesUITests' do
    # Pods for testing
  end
  
  
#  gatetoriches@gmail.com
#  2202Shark@
end


#
#
#import Foundation
#
#func sendNotification(senderToken: String, recipientToken: String, message: String) {
#    let serverKey = "YOUR_SERVER_KEY" // Your Firebase Cloud Messaging server key
#    
#    let url = URL(string: "https://fcm.googleapis.com/fcm/send")!
#    var request = URLRequest(url: url)
#    request.httpMethod = "POST"
#    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
#    request.setValue("key=\(serverKey)", forHTTPHeaderField: "Authorization")
#    
#    let notification = ["title": "New Message",
#                        "body": message,
#                        "sender": senderToken] // Add sender information
#    
#    let data: [String: Any] = ["to": recipientToken,
#                               "notification": notification]
#    
#    let jsonData = try! JSONSerialization.data(withJSONObject: data)
#    
#    let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
#        if let error = error {
#            print("Error sending notification: \(error.localizedDescription)")
#            return
#        }
#        
#        // Check response if necessary
#        if let httpResponse = response as? HTTPURLResponse {
#            print("Response status code: \(httpResponse.statusCode)")
#        }
#        
#        // Handle response data if necessary
#        if let data = data {
#            let responseData = String(data: data, encoding: .utf8)
#            print("Response data: \(responseData ?? "")")
#        }
#    }
#    
#    task.resume()
#}
#
#// Example usage:
#let senderToken = "SENDER_FCM_TOKEN"
#let recipientToken = "RECIPIENT_FCM_TOKEN"
#let message = "Hello, how are you?"
#
#sendNotification(senderToken: senderToken, recipientToken: recipientToken, message: message)
