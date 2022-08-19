//
//  AboutrVC.swift
//  RealEstates
//
//  Created by botan pro on 5/2/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import WebKit
class AboutrVC: UIViewController {

    
    @IBOutlet weak var WebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        if XLanguage.get() == .English{
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 16)!]

        }else if XLanguage.get() == .Arabic{
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "PeshangDes2", size: 17)!]

        }else if XLanguage.get() == .Kurdish{
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "PeshangDes2", size: 17)!]

        }
        let url = URL(string: "http://www.shark-team.com")
        let requestObj = URLRequest(url: url! as URL)
         WebView.loadRequest(requestObj)
    }

    
}
