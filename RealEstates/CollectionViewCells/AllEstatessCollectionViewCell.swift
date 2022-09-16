//
//  AllEstatessCollectionViewCell.swift
//  RealEstates
//
//  Created by botan pro on 1/2/22.
//

import UIKit
import SDWebImage
class AllEstatessCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var Location: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Imagee: UIImageView!
    @IBOutlet weak var BackView: UIView!
    @IBOutlet weak var Typee: UILabel!
    @IBOutlet weak var SoldView: UIView!
    @IBOutlet weak var Sold: LanguageLable!
    @IBOutlet weak var RoomNumber: UILabel!
    @IBOutlet weak var HomeSize: UILabel!
    @IBOutlet weak var Date: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.Imagee.layer.cornerRadius = 10
        self.BackView.layer.cornerRadius = 10
        self.Sold.isHidden = true
        self.SoldView.isHidden = true
    }
    
    func detectLanguage<T: StringProtocol>(for text: T) -> String? {
        let tagger = NSLinguisticTagger.init(tagSchemes: [.language], options: 0)
        tagger.string = String(text)

        guard let languageCode = tagger.tag(at: 0, scheme: .language, tokenRange: nil, sentenceRange: nil) else { return nil }
        print(languageCode.rawValue)
        return Locale.current.localizedString(forIdentifier: languageCode.rawValue)
    }
    
    
    var rooms = ""
    var lang : Int = UserDefaults.standard.integer(forKey: "language")
    func update(_ cell: EstateObject){
        
        
        if cell.sold == "1"{
            self.Sold.isHidden = false
            self.SoldView.isHidden = false
        }else{
            self.Sold.isHidden = true
            self.SoldView.isHidden = true
        }
        
        
        guard let imagrUrl = cell.ImageURL, let url = URL(string: imagrUrl[0]) else {return}
        self.Imagee.sd_setImage(with: url, placeholderImage: UIImage(named: "logoPlace"))
        self.Name.text = cell.name
        print(detectLanguage(for:self.Name.text!))
        if detectLanguage(for:self.Name.text!) == "Arabic"{
            self.Name.font = UIFont(name: "PeshangDes2", size: 14)!
        }else{
            self.Name.font = UIFont(name: "ArialRoundedMTBold", size: 14)!
        }
        self.Location.text = cell.address
        if XLanguage.get() == .English{
            self.rooms = "rooms"
            self.RoomNumber.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
        }else if XLanguage.get() == .Arabic{
            self.rooms = "غرف"
            self.RoomNumber.font = UIFont(name: "PeshangDes2", size: 11)!
        }else{
            self.rooms = "ژوور"
            self.RoomNumber.font = UIFont(name: "PeshangDes2", size: 11)!
        }
        self.RoomNumber.text = "\(cell.RoomNo ?? "") \(self.rooms)"
        let font:UIFont? = UIFont.systemFont(ofSize: 10, weight: .bold)
        let fontSuper:UIFont? = UIFont(name: "Helvetica-bold", size:8)
        let attString:NSMutableAttributedString = NSMutableAttributedString(string: "\(cell.space ?? "")m2", attributes: [.font:font!])
        attString.setAttributes([.font:fontSuper!,.baselineOffset:4], range: NSRange(location:(cell.space?.count ?? 0) + 1,length:1))
        self.HomeSize.attributedText = attString
        if cell.RentOrSell == "0"{
            if XLanguage.get() == .Kurdish{
                let longString = "\(cell.price?.description.currencyFormatting() ?? "")/ مانگانە"
                let longestWord = "مانگانە"
                let longestWordRange = (longString as NSString).range(of: longestWord)

                let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 16)!])

                attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "PeshangDes2", size: 12)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                
                self.Price.attributedText = attributedString
            }else if XLanguage.get() == .English{
                let longString = "\(cell.price?.description.currencyFormatting() ?? "")/ Monthly"
                let longestWord = "Monthly"
                let longestWordRange = (longString as NSString).range(of: longestWord)

                let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 16)!])

                attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 10)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                
                self.Price.attributedText = attributedString
            }else{
                let longString = "\(cell.price?.description.currencyFormatting() ?? "")/ شهريا"
                let longestWord  = "شهريا"
                let longestWordRange = (longString as NSString).range(of: longestWord)

                let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 16)!])

                attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "PeshangDes2", size: 12)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                
                self.Price.attributedText = attributedString
            }
        }else{
            self.Price.text = cell.price?.description.currencyFormatting()
        }
        
        EstateTypeAip.GeEstateTypeNameById(id:  cell.estate_type_id ?? "") { type in
            if XLanguage.get() == .English{
                self.Typee.text = type.name
                self.Typee.font =  UIFont(name: "ArialRoundedMTBold", size: 12)!
            }else if XLanguage.get() == .Arabic{
                self.Typee.text = type.ar_name
                self.Typee.font =  UIFont(name: "PeshangDes2", size: 13)!
            }else{
                self.Typee.text = type.ku_name
                self.Typee.font =  UIFont(name: "PeshangDes2", size: 13)!
            }
        }
        let date = NSDate(timeIntervalSince1970: cell.Stamp ?? 0.0)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd MM,YYYY"
        let dateTimeString = dayTimePeriodFormatter.string(from: date as Date)
        let dateTime = dateTimeString.split(separator: ".")
        self.Date.text = "\(dateTime[0])".convertedDigitsToLocale(Locale(identifier: "EN"))
    }

}
