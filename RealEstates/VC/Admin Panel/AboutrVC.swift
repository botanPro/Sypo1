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

    
    @IBOutlet weak var WebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.title = ""
        if XLanguage.get() == .Arabic{
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "PeshangDes2", size: 16)!,.foregroundColor: #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)]
        }else if XLanguage.get() == .Kurdish{
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "PeshangDes2", size: 16)!,.foregroundColor: #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)]
        }else {
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 16)!,.foregroundColor: #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)]
        }
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.09539470822, green: 0.3233559132, blue: 0.5086024404, alpha: 1)]
        let url = URL(string: "http://maskani.shark-team.com")
        let requestObj = URLRequest(url: url! as URL)
        WebView.load(requestObj)
    }

    
    
}
