//
//  RentAndSellVC.swift
//  RealEstates
//
//  Created by botan pro on 4/16/21.
//

import UIKit
import CRRefresh
import HMSegmentedControl
import MXSegmentedPager

class RentAndSellVC: MXSegmentedPagerController {
    

    @IBOutlet weak var NavTitle: LanguageBarItem!
    
    let sectionInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
    var numberOfItemsPerRow: CGFloat = 2
    let spacingBetweenCells: CGFloat = 10
    //var RentAndSellArray : [ProfilesHomeObject] = []
    
    var KArray :[String] = ["فرۆشتن", "کرێ"]
    var EArray :[String] = ["Sell", "Rent"]
    var AArray :[String] = ["البيع", "الايجار"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        //navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(color: .darkGray)
        
        segmentedPager.backgroundColor = #colorLiteral(red: 0.95029217, green: 0.95029217, blue: 0.9502920508, alpha: 1)
        segmentedPager.segmentedControl.indicator.lineHeight = 3
        if XLanguage.get() == .English{
            segmentedPager.segmentedControl.font = UIFont(name: "ArialRoundedMTBold", size: 14)!
        }else if XLanguage.get() == .Arabic{
            segmentedPager.segmentedControl.font = UIFont(name: "PeshangDes2", size: 15)!
        }else if XLanguage.get() == .Kurdish{
            segmentedPager.segmentedControl.font = UIFont(name: "PeshangDes2", size: 15)!
        }
        
        segmentedPager.segmentedControl.indicator.linePosition = .bottom
        segmentedPager.segmentedControl.textColor = #colorLiteral(red: 0.09539470822, green: 0.3233559132, blue: 0.5086024404, alpha: 1)
        segmentedPager.segmentedControl.selectedTextColor = #colorLiteral(red: 1, green: 0.4737319946, blue: 0.1554479897, alpha: 1)
        segmentedPager.segmentedControl.indicator.lineView.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        NotificationCenter.default.addObserver(self, selector: #selector(self.LanguageChanged), name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)
        
    }
    
    
    @objc func LanguageChanged(){
        if XLanguage.get() == .English{
            segmentedPager.segmentedControl.font = UIFont(name: "ArialRoundedMTBold", size: 14)!
        }else if XLanguage.get() == .Arabic{
            segmentedPager.segmentedControl.font = UIFont(name: "PeshangDes2", size: 15)!
        }else if XLanguage.get() == .Kurdish{
            segmentedPager.segmentedControl.font = UIFont(name: "PeshangDes2", size: 15)!
        }
        segmentedPager.segmentedControl.removeAll()
        segmentedPager.reloadData()
    }
    
    var IsInternetChecked = false
   


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, titleForSectionAt index: Int) -> String {
        if XLanguage.get() == .Kurdish{
            return self.KArray[index]
        }else if XLanguage.get() == .English{
            return self.EArray[index]
        }else{
            return self.AArray[index]
        }
       
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, didScrollWith parallaxHeader: MXParallaxHeader) {
        print("progress \(parallaxHeader.progress)")
    }
    
    
    
}
