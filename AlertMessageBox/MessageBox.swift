//
//  MessageBox.swift
//  BarDast
//
//  Created by Botan Amedi on 4/27/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit


class MessageBoxVC : UIViewController{
    

    @IBOutlet weak var Message : UILabel!
    

    @IBOutlet weak var viewlayout: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if XLanguage.get() == .English{
            self.Message.textAlignment = .left
        }else{
            self.Message.textAlignment = .right
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.2, delay: -1.0, options: .curveEaseInOut) {
            self.viewlayout.constant = 30
            self.view.layoutIfNeeded()
        } completion: { state in
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseInOut) {
                self.viewlayout.constant = 22
                self.view.layoutIfNeeded()
            } completion: { state in
                UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseInOut) {
                    self.viewlayout.constant = 25
                    self.view.layoutIfNeeded()
                } completion: { state in
                    UIView.animate(withDuration: 0.2, delay: 1.0, options: .curveEaseInOut) {
                    self.viewlayout.constant = -100
                    self.view.layoutIfNeeded()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }

        }
        
        
    }
}

class MessageBox {
       
    static func ShowMessage(){
        let StoryBoard = UIStoryboard(name: "MessageBox", bundle: nil)
        let vc = StoryBoard.instantiateViewController(withIdentifier:"MessageBox") as! MessageBoxVC
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        UIApplication.GetPresentviewController()?.present(vc, animated: true, completion: nil)
    }

}

extension UIApplication{
    
    static func GetPresentviewController() -> UIViewController? {
        var presentViewController = UIApplication.shared.windows.first?.rootViewController
        while let pVc = presentViewController?.presentedViewController {
            
              presentViewController = pVc
        }
        return presentViewController
    }

}
