//
//  SceneDelegate.swift
//  RealEstates
//
//  Created by botan pro on 4/16/21.
//

import UIKit
import FirebaseDynamicLinks

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        print("anything??")
        if let incomingurl = userActivity.webpageURL{
            print("incomingurl is \(incomingurl)")
            let handled = DynamicLinks.dynamicLinks().handleUniversalLink(incomingurl) { (dynamiclink, error) in

                guard error == nil else{
                    print("found an error! \(error!.localizedDescription)")
                    return
                }

                self.handleIncomeDynamicLink(dynamiclink!)

            }
        }
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let url = connectionOptions.userActivities.first?.webpageURL{
            DynamicLinks.dynamicLinks().handleUniversalLink(url) { (dynamiclink, error) in
                if let dynamiclink = dynamiclink {
                    self.handleIncomeDynamicLink(dynamiclink)
                }
            }
            
        }
        if let url = connectionOptions.urlContexts.first?.url{
            DynamicLinks.dynamicLinks().handleUniversalLink(url) { (dynamiclink, error) in
                if let dynamiclink = dynamiclink {
                    self.handleIncomeDynamicLink(dynamiclink)
                }
            }
        }
        
        
        
        
        guard let winScene = (scene as? UIWindowScene) else { return }
        print(winScene)
        let win = UIWindow(windowScene: winScene)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DetectVC")

        win.rootViewController = newViewController
        win.makeKeyAndVisible()
        window = win

    }
    
    func handleIncomeDynamicLink(_ dynamicLink: DynamicLink){
        guard let url = dynamicLink.url else{
            print("no object")
            return
        }
        print(url)
        guard (dynamicLink.matchType == .unique || dynamicLink.matchType == .default) else{
            print("not a strong enough match type to conitunie)")
            return
        }
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems  else{
            return
        }
        if components.path == "/maskani"{
            if let productIdQueryItem = queryItems.first(where: {$0.name == "estateid"}){
                guard let productId = productIdQueryItem.value else{return}
                print(productId)
                if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GoToEstateProfileVc") as? EstateProfileVc {
                    if let window = self.window, let rootViewController = window.rootViewController {
                        var currentController = rootViewController
                        while let presentedController = currentController.presentedViewController {
                            currentController = presentedController
                        }
                        ProductAip.GetProduct(ID: productId) { estate in
                            controller.CommingEstate = estate
                            controller.modalPresentationStyle = .fullScreen
                            currentController.present(controller, animated: true, completion: nil)
                        }
                        
                    }
                }
            }
        }
        print(queryItems.first?.value! as Any)
        print(dynamicLink.url?.absoluteString as Any);
    }

    

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

