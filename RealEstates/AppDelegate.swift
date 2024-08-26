//
//  AppDelegate.swift
//  RealEstates
//
//  Created by botan pro on 4/16/21.
//

import UIKit
import CoreData
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseDynamicLinks
import FirebaseAnalytics
import CoreLocation
import UserNotifications
import EPSignature
@main


class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if XLanguage.get() == .none{
            XLanguage.set(Language: .English)
        }
        
        UserDefaults.standard.set(nil, forKey: "dynamiclink")
        if UserDefaults.standard.string(forKey: "IsFirst") == nil{
            UserDefaults.standard.set("true", forKey: "IsFirst")
        }
        
        if  UserDefaults.standard.string(forKey: "CityId") == nil{
            UserDefaults.standard.setValue("vfaXYk6xOTGec2BTNoB5", forKey: "CityId")
        }
        
        
//
//        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
//        OneSignal.initWithLaunchOptions(launchOptions)
//        OneSignal.setAppId("bbbfdf2e-0518-4da0-9200-7135829e0156")
//        OneSignal.promptForPushNotifications(userResponse: { accepted in
//            print("User accepted notifications: \(accepted)")
//            UserDefaults.standard.set(OneSignal.getDeviceState().userId ?? "", forKey: "OneSignalId")
//          })
//
        
        FirebaseApp.configure()
 
        

        
        //sleep(1)
        
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DetectVC")
//        self.window!.rootViewController = newViewController
//        self.window!.makeKeyAndVisible()
        
        return true
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if let rootViewController = self.topViewControllerWithRootViewController(rootViewController: window?.rootViewController) {
          if (rootViewController.responds(to: Selector(("canRotate")))) {
            // Unlock landscape view orientations for this view controller
            return .allButUpsideDown;
          }
        }
        
        // Only allow portrait (standard behaviour)
        return .portrait;
      }
      
      private func topViewControllerWithRootViewController(rootViewController: UIViewController!) -> UIViewController? {
        if (rootViewController == nil) { return nil }
        if (rootViewController.isKind(of: UITabBarController.self)) {
          return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UITabBarController).selectedViewController)
        } else if (rootViewController.isKind(of: UINavigationController.self)) {
          return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UINavigationController).visibleViewController)
        } else if (rootViewController.presentedViewController != nil) {
          return topViewControllerWithRootViewController(rootViewController: rootViewController.presentedViewController)
        }
        return rootViewController
      }

    
    
     func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let firebaseAuth = Auth.auth()
         firebaseAuth.setAPNSToken(deviceToken, type: AuthAPNSTokenType.unknown)
    }

     func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let firebaseAuth = Auth.auth()
        if (firebaseAuth.canHandleNotification(userInfo)){
            print(userInfo)
            return
        }
    }

//
//    func onOSSubscriptionChanged(_ stateChanges: OSSubscriptionStateChanges) {
//       if !stateChanges.from.isSubscribed && stateChanges.to.isSubscribed {
//           print("Subscribed for OneSignal push notifications!")
//       }
//       print("SubscriptionStateChange: \n\(String(describing: stateChanges))")
//       
//       if let playerId = stateChanges.to.userId {
//           print("Current playerId \(playerId)")
//           UserDefaults.standard.set(playerId, forKey: "OneSignalId")
//       }
//   }
//   
    
    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

