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
        if detectLanguage(for:self.Name.text!) == "Arabic" || detectLanguage(for:self.Name.text!) == "Urdu"{
            self.Name.font = UIFont(name: "PeshangDes2", size: 14)!
        }else{
            self.Name.font = UIFont(name: "ArialRoundedMTBold", size: 14)!
        }
        
        
        self.Location.text = cell.address

        
        if XLanguage.get() == .Arabic{
           self.rooms = "غرف"
           self.RoomNumber.font = UIFont(name: "PeshangDes2", size: 11)!
       }else  if XLanguage.get() == .Kurdish{
           self.rooms = "ژوور"
           self.RoomNumber.font = UIFont(name: "PeshangDes2", size: 11)!
       }else if XLanguage.get() == .English {
           self.rooms = "rooms"
           self.RoomNumber.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
       } else if XLanguage.get() == .French {
           self.rooms = "chambres"
           self.RoomNumber.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
       } else if XLanguage.get() == .Spanish {
           self.rooms = "habitaciones"
           self.RoomNumber.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
       } else if XLanguage.get() == .German {
           self.rooms = "Zimmer"
           self.RoomNumber.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
       } else if XLanguage.get() == .Dutch {
           self.rooms = "kamers"
           self.RoomNumber.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
       } else if XLanguage.get() == .Portuguese {
           self.rooms = "quartos"
           self.RoomNumber.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
       } else if XLanguage.get() == .Russian {
           self.rooms = "комнаты"
           self.RoomNumber.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
       } else if XLanguage.get() == .Chinese {
           self.rooms = "房间"
           self.RoomNumber.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
       } else if XLanguage.get() == .Hindi {
           self.rooms = "कमरे"
           self.RoomNumber.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
       } else if XLanguage.get() == .Swedish {
           self.rooms = "rum"
           self.RoomNumber.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
       } else if XLanguage.get() == .Greek {
           self.rooms = "δωμάτια"
           self.RoomNumber.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
       } else if XLanguage.get() == .Hebrew {
           self.rooms = "חדרים"
           self.RoomNumber.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
       }
        
        self.RoomNumber.text = "\(cell.RoomNo ?? "") \(self.rooms)"
        let font:UIFont? = UIFont.systemFont(ofSize: 10, weight: .bold)
        let fontSuper:UIFont? = UIFont(name: "Helvetica-bold", size:8)
        let attString:NSMutableAttributedString = NSMutableAttributedString(string: "\(cell.space ?? "")m2", attributes: [.font:font!])
        attString.setAttributes([.font:fontSuper!,.baselineOffset:4], range: NSRange(location:(cell.space?.count ?? 0) + 1,length:1))
        self.HomeSize.attributedText = attString
        if cell.RentOrSell == "0"{
            var longString = ""
            var longestWord = ""
            if XLanguage.get() == .Kurdish{
                longString = "\(cell.price?.description.currencyFormatting() ?? "")/ مانگانە"
                longestWord = "مانگانە"
                let longestWordRange = (longString as NSString).range(of: longestWord)

                let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "PeshangDes2", size: 16)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                
                self.Price.attributedText = attributedString
            }else if XLanguage.get() == .Arabic{
                 longString = "\(cell.price?.description.currencyFormatting() ?? "")/ شهريا"
                 longestWord  = "شهريا"
                let longestWordRange = (longString as NSString).range(of: longestWord)

                let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "PeshangDes2", size: 16)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                
                self.Price.attributedText = attributedString
            }else if XLanguage.get() == .English {
                longestWord = "Monthly"
                longString = "\(cell.price?.description.currencyFormatting() ?? "")/ \(longestWord)"
                let longestWordRange = (longString as NSString).range(of: longestWord)

                let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 15)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                
                self.Price.attributedText = attributedString
            } else if XLanguage.get() == .Hebrew {
                longestWord = "חודשי"
                longString = "\(cell.price?.description.currencyFormatting() ?? "")/ \(longestWord)"
                let longestWordRange = (longString as NSString).range(of: longestWord)

                let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 15)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                
                self.Price.attributedText = attributedString
            } else if XLanguage.get() == .Chinese {
                longestWord = "每月"
                longString = "\(cell.price?.description.currencyFormatting() ?? "")/ \(longestWord)"
                let longestWordRange = (longString as NSString).range(of: longestWord)

                let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 15)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                
                self.Price.attributedText = attributedString
            } else if XLanguage.get() == .Hindi {
                longestWord = "मासिक"
                longString = "\(cell.price?.description.currencyFormatting() ?? "")/ \(longestWord)"
                let longestWordRange = (longString as NSString).range(of: longestWord)

                let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 15)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                
                self.Price.attributedText = attributedString
            } else if XLanguage.get() == .Portuguese {
                longestWord = "Mensal"
                longString = "\(cell.price?.description.currencyFormatting() ?? "")/ \(longestWord)"
                let longestWordRange = (longString as NSString).range(of: longestWord)

                let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 15)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                
                self.Price.attributedText = attributedString
            } else if XLanguage.get() == .Swedish {
                longestWord = "Månadsvis"
                longString = "\(cell.price?.description.currencyFormatting() ?? "")/ \(longestWord)"
                let longestWordRange = (longString as NSString).range(of: longestWord)

                let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 15)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                
                self.Price.attributedText = attributedString
            } else if XLanguage.get() == .Greek {
                longestWord = "Μηνιαίως"
                longString = "\(cell.price?.description.currencyFormatting() ?? "")/ \(longestWord)"
                let longestWordRange = (longString as NSString).range(of: longestWord)

                let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 15)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                
                self.Price.attributedText = attributedString
            } else if XLanguage.get() == .Russian {
                longestWord = "Ежемесячно"
                longString = "\(cell.price?.description.currencyFormatting() ?? "")/ \(longestWord)"
                let longestWordRange = (longString as NSString).range(of: longestWord)

                let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 15)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                
                self.Price.attributedText = attributedString
            } else if XLanguage.get() == .Dutch {
                longestWord = "Maandelijks"
                longString = "\(cell.price?.description.currencyFormatting() ?? "")/ \(longestWord)"
                let longestWordRange = (longString as NSString).range(of: longestWord)

                let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 15)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                
                self.Price.attributedText = attributedString
            } else if XLanguage.get() == .French {
                longestWord = "Mensuel"
                longString = "\(cell.price?.description.currencyFormatting() ?? "")/ \(longestWord)"
                let longestWordRange = (longString as NSString).range(of: longestWord)

                let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 15)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                
                self.Price.attributedText = attributedString
            } else if XLanguage.get() == .Spanish {
                longestWord = "Mensual"
                longString = "\(cell.price?.description.currencyFormatting() ?? "")/ \(longestWord)"
                let longestWordRange = (longString as NSString).range(of: longestWord)

                let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 15)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                
                self.Price.attributedText = attributedString
            } else if XLanguage.get() == .German {
                longestWord = "Monatlich"
                longString = "\(cell.price?.description.currencyFormatting() ?? "")/ \(longestWord)"
                let longestWordRange = (longString as NSString).range(of: longestWord)

                let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 15)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                
                self.Price.attributedText = attributedString
            }
        }else{
            self.Price.text = cell.price?.description.currencyFormatting()
        }
        
        EstateTypeAip.GeEstateTypeNameById(id:  cell.estate_type_id ?? "") { type in
                self.Typee.text = type.name
                self.Typee.font =  UIFont(name: "ArialRoundedMTBold", size: 13)!
        }
        
        let date = NSDate(timeIntervalSince1970: cell.Stamp ?? 0.0)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd MM,YYYY"
        let dateTimeString = dayTimePeriodFormatter.string(from: date as Date)
        let dateTime = dateTimeString.split(separator: ".")
        self.Date.text = "\(dateTime[0])".convertedDigitsToLocale(Locale(identifier: "EN"))
    }

}
