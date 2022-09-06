//
//  DetectVC.swift
//  RealEstates
//
//  Created by botan pro on 4/16/21.
//

import UIKit
import CoreLocation
class DetectVC: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        print(UserDefaults.standard.string(forKey: "IsFirst"))
        if UserDefaults.standard.string(forKey: "IsFirst") == "true"{print("[][][][]-------=============[][][][]]][]")
            self.performSegue(withIdentifier: "FirstVC", sender: nil)
        }else{print("[][][][]-------=============[][][][]]][]444444")
            self.performSegue(withIdentifier: "GoToApp", sender: nil)
        }
    }
    
}
