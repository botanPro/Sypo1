//
//  HorizantlyProjectsCollectionViewCell.swift
//  RealEstates
//
//  Created by Botan Amedi on 02/09/2022.
//

import UIKit

class HorizantlyProjectsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var ToPrice: UILabel!
    @IBOutlet weak var EstateType: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Image: UIImageView!
    
    @IBOutlet weak var State: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.MainView.layer.cornerRadius = 12
        self.Image.layer.cornerRadius = 10
    }
    
    
    func detectLanguage<T: StringProtocol>(for text: T) -> String? {
        let tagger = NSLinguisticTagger.init(tagSchemes: [.language], options: 0)
        tagger.string = String(text)

        guard let languageCode = tagger.tag(at: 0, scheme: .language, tokenRange: nil, sentenceRange: nil) else { return nil }
        print(languageCode.rawValue)
        return Locale.current.localizedString(forIdentifier: languageCode.rawValue)
    }
    
    var Buildings = ""
    var to = ""
    var lang : Int = UserDefaults.standard.integer(forKey: "language")
    func update(_ cell: ProjectObject){
        ProjectStatesAip.GetProjectStatesId(id: cell.project_state_id ?? "") { state in
                self.State.text = state.title
                self.State.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            
        }
        
        guard let imagrUrl = cell.images, let url = URL(string: imagrUrl[0]) else {return}
        self.Image.sd_setImage(with: url, placeholderImage: UIImage(named: "logoPlace"))
            self.Name.text = cell.project_name
            self.Name.font = UIFont(name: "ArialRoundedMTBold", size: 14)!
       
        
        if detectLanguage(for:self.Name.text!) == "Arabic"{
            self.Name.font = UIFont(name: "PeshangDes2", size: 14)!
        }else{
            self.Name.font = UIFont(name: "ArialRoundedMTBold", size: 14)!
        }
        
       if XLanguage.get() == .Arabic{
            self.Buildings = "عمارات"
            self.EstateType.font = UIFont(name: "PeshangDes2", size: 14)!
            self.to = "إلى"
       }else  if XLanguage.get() == .Kurdish{
            self.Buildings = "بیناکان"
            self.EstateType.font = UIFont(name: "PeshangDes2", size: 14)!
            self.to = "بۆ"
        }else if XLanguage.get() == .English {
            self.EstateType.font = UIFont(name: "ArialRoundedMTBold", size: 14)!
            self.Buildings = "Buildings"
            self.to = "to"
        } else if XLanguage.get() == .French {
            self.Buildings = "Bâtiments"
            self.EstateType.font = UIFont(name: "ArialRoundedMTBold", size: 14)!
            self.to = "à"
        } else if XLanguage.get() == .Spanish {
            self.Buildings = "Edificios"
            self.EstateType.font = UIFont(name: "ArialRoundedMTBold", size: 14)!
            self.to = "a"
        } else if XLanguage.get() == .German {
            self.Buildings = "Gebäude"
            self.EstateType.font = UIFont(name: "ArialRoundedMTBold", size: 14)!
            self.to = "zu"
        } else if XLanguage.get() == .Dutch {
            self.Buildings = "Gebouwen"
            self.EstateType.font = UIFont(name: "ArialRoundedMTBold", size: 14)!
            self.to = "naar"
        } else if XLanguage.get() == .Portuguese {
            self.Buildings = "Edifícios"
            self.EstateType.font = UIFont(name: "ArialRoundedMTBold", size: 14)!
            self.to = "para"
        } else if XLanguage.get() == .Russian {
            self.Buildings = "Здания"
            self.EstateType.font = UIFont(name: "ArialRoundedMTBold", size: 14)!
            self.to = "к"
        } else if XLanguage.get() == .Chinese {
            self.Buildings = "建筑物"
            self.EstateType.font = UIFont(name: "ArialRoundedMTBold", size: 14)!
            self.to = "到"
        } else if XLanguage.get() == .Hindi {
            self.Buildings = "इमारतें"
            self.EstateType.font = UIFont(name: "ArialRoundedMTBold", size: 14)!
            self.to = "से"
        } else if XLanguage.get() == .Swedish {
            self.Buildings = "Byggnader"
            self.EstateType.font = UIFont(name: "ArialRoundedMTBold", size: 14)!
            self.to = "till"
        } else if XLanguage.get() == .Greek {
            self.Buildings = "Κτίρια"
            self.EstateType.font = UIFont(name: "ArialRoundedMTBold", size: 14)!
            self.to = "προς"
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
