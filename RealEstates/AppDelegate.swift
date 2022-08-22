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
import Messages
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if XLanguage.get() == .none{
            XLanguage.set(Language: .Kurdish)
        }
        
        UserDefaults.standard.set(nil, forKey: "dynamiclink")
        if UserDefaults.standard.string(forKey: "IsFirst") == nil{
            UserDefaults.standard.set("true", forKey: "IsFirst")
        }
        
        FirebaseApp.configure()
 
        sleep(1)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DetectVC")
        self.window!.rootViewController = newViewController
        self.window!.makeKeyAndVisible()
        
        return true
    }

    
//// dynamic link not working in AppDelegate
//
//    // DynamicLinks
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
//        DynamicLinks.dynamicLinks().handleUniversalLink(url) { (dynamiclink, error) in
//            if let dynamiclink = dynamiclink {
//                self.handleIncomeDynamicLink(dynamiclink)
//            }
//        }
//        return false
//    }
//
//
//
//
//
//    // DynamicLinks
//    private func application(_ application: UIApplication, continue userActivity: NSUserActivity,restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
//        print("anything??")
//        if let incomingurl = userActivity.webpageURL{
//            print("incomingurl is \(incomingurl)")
//            let handled = DynamicLinks.dynamicLinks().handleUniversalLink(incomingurl) { (dynamiclink, error) in
//
//                guard error == nil else{
//                    print("found an error! \(error!.localizedDescription)")
//                    return
//                }
//
//                self.handleIncomeDynamicLink(dynamiclink!)
//
//            }
//            return handled
//        }
//
//        return false
//    }
//
//
//
//    func handleIncomeDynamicLink(_ dynamicLink: DynamicLink){
//        guard let url = dynamicLink.url else{
//            print("no object")
//            return
//        }
//        guard (dynamicLink.matchType == .unique || dynamicLink.matchType == .default) else{
//            print("not a strong enough match type to conitunie)")
//            return
//        }
//        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
//              let queryItems = components.queryItems  else{
//            return
//        }
//        if components.path == "/maskani"{
//            if let productIdQueryItem = queryItems.first(where: {$0.name == "estateid"}){
////                guard let productId = productIdQueryItem.value else{return}
////                if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GoToProductVC") as? EstateProfileVc {
////                    if let window = self.window, let rootViewController = window.rootViewController {
////                        var currentController = rootViewController
////                        while let presentedController = currentController.presentedViewController {
////                            currentController = presentedController
////                        }
////                        //ontroller.ThisId = "\(productId)"
////                        controller.modalPresentationStyle = .fullScreen
////                        currentController.present(controller, animated: true, completion: nil)
////                    }
////                }
//            }
//        }
//        print(queryItems.first?.value! as Any)
//        print(dynamicLink.url?.absoluteString as Any);
//    }
//
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

