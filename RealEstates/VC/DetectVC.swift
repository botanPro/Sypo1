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
        if UserDefaults.standard.string(forKey: "IsFirst") == "true"{
            self.performSegue(withIdentifier: "FirstVC", sender: nil)
        }else{
            self.performSegue(withIdentifier: "GoToApp", sender: nil)
        }
    }
    
}
