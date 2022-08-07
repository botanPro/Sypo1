//
//  DetectVC.swift
//  RealEstates
//
//  Created by botan pro on 4/16/21.
//

import UIKit

class DetectVC: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("[][][][]-------=============[][][][]]][]")
        if UserDefaults.standard.string(forKey: "IsFirst") == "true"{
            self.performSegue(withIdentifier: "FirstVC", sender: nil)
        }else{
            self.performSegue(withIdentifier: "GoToApp", sender: nil)
        }
    }
    
}
