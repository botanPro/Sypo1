//
//  ProjectsCollectionViewCell.swift
//  RealEstates
//
//  Created by botan pro on 2/19/22.
//

import UIKit

class ProjectsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var ToPrice: UILabel!
    @IBOutlet weak var Location: UILabel!
    @IBOutlet weak var EstateType: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Image: UIImageView!
    
    @IBOutlet weak var State: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.MainView.layer.cornerRadius = 12
    }
    
    var Buildings = ""
    var to = ""
    var lang : Int = UserDefaults.standard.integer(forKey: "language")
    func update(_ cell: ProjectObject){
        ProjectStatesAip.GetProjectStatesId(id: cell.project_state_id ?? "") { state in
            if XLanguage.get() == .English{
                self.State.text = state.title
                self.State.font = UIFont(name: "ArialRoundedMTBold", size: 13)!
            }else if XLanguage.get() == .Arabic{
                self.State.text = state.ar_title
                self.State.font = UIFont(name: "PeshangDes2", size: 13)!
            }else{
                self.State.text = state.ku_title
                self.State.font = UIFont(name: "PeshangDes2", size: 13)!
            }
        }
        
        guard let imagrUrl = cell.images, let url = URL(string: imagrUrl[0]) else {return}
        self.Image.sd_setImage(with: url, completed: nil)
        if XLanguage.get() == .English{
            self.Name.text = cell.project_name
            self.Name.font = UIFont(name: "ArialRoundedMTBold", size: 14)!
        }else if XLanguage.get() == .Arabic{
            self.Name.text = cell.project_ar_name
            self.Name.font = UIFont(name: "PeshangDes2", size: 14)!
        }else{
            self.Name.text = cell.project_ku_name
            self.Name.font = UIFont(name: "PeshangDes2", size: 14)!
        }
        self.Location.text = cell.address
        if XLanguage.get() == .English{
            self.Buildings = "Buildings"
            self.EstateType.font = UIFont(name: "PeshangDes2", size: 14)!
            self.to = "to"
        }else if XLanguage.get() == .Arabic{
            self.Buildings = "عمارات"
            self.EstateType.font = UIFont(name: "ArialRoundedMTBold", size: 14)!
            self.to = "إلى"
        }else{
            self.Buildings = "بیناکان"
            self.EstateType.font = UIFont(name: "PeshangDes2", size: 14)!
            self.to = "بۆ"
        }
        self.EstateType.text = "\(cell.Buildings_count ?? "") \(self.Buildings)"
        self.ToPrice.text = "\(cell.to_price?.description.currencyFormatting() ?? "") - \(cell.from_price?.description.currencyFormatting() ?? "")"
        let date = NSDate(timeIntervalSince1970: cell.uploaded_date_stamp ?? 0.0)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd MM,YYYY"
        let dateTimeString = dayTimePeriodFormatter.string(from: date as Date)
        let dateTime = dateTimeString.split(separator: ".")
        self.Date.text = "\(dateTime[0])".convertedDigitsToLocale(Locale(identifier: "EN"))
    }

}
