//
//  FavoriteTableViewCell.swift
//  RealEstates
//
//  Created by botan pro on 1/29/22.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var Sold: Languagebutton!
    @IBOutlet weak var Edit: UIButton!
    @IBOutlet weak var Delete: UIButton!
    @IBOutlet weak var HomeSize: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var RoomNumber: UILabel!
    @IBOutlet weak var Location: UILabel!
    @IBOutlet weak var Direction: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Imagee: UIImageView!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var RightLayoutConstraint2: NSLayoutConstraint!
    @IBOutlet weak var RightLayoutConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
        
        if cell.sold == "0"{
            self.Sold.isHidden = false
        }else{
            self.Sold.isHidden = true
        }
        
        guard let imagrUrl = cell.ImageURL, let url = URL(string: imagrUrl[0]) else {return}
        self.Imagee.sd_setImage(with: url, placeholderImage: UIImage(named: "logoPlace"))
        self.Name.text = cell.name
        
        print(detectLanguage(for:self.Name.text!))
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
        
        
        
        
        let date = NSDate(timeIntervalSince1970: cell.Stamp ?? 0.0)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd MM,YYYY"
        let dateTimeString = dayTimePeriodFormatter.string(from: date as Date)
        let dateTime = dateTimeString.split(separator: ".")
        self.Date.text = "\(dateTime[0])".convertedDigitsToLocale(Locale(identifier: "EN"))
 
        
        if XLanguage.get() == .Arabic{
            self.Direction.font = UIFont(name: "PeshangDes2", size: 11)!
        }else  if XLanguage.get() == .Kurdish{
            self.Direction.font = UIFont(name: "PeshangDes2", size: 11)!
        }else{
            self.Direction.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
        }
        
        
            if cell.Direction == "N"{
                if XLanguage.get() == .Arabic {
                    self.Direction.text = "شمال"
                } else if XLanguage.get() == .Kurdish {
                    self.Direction.text = "باکور"
                } else if XLanguage.get() == .English {
                    self.Direction.text = "North"
                } else if XLanguage.get() == .Dutch {
                    self.Direction.text = "Noord"
                } else if XLanguage.get() == .French {
                    self.Direction.text = "Nord"
                } else if XLanguage.get() == .Spanish {
                    self.Direction.text = "Norte"
                } else if XLanguage.get() == .German {
                    self.Direction.text = "Norden"
                } else if XLanguage.get() == .Hebrew {
                    self.Direction.text = "צפון"
                } else if XLanguage.get() == .Chinese {
                    self.Direction.text = "北"
                } else if XLanguage.get() == .Hindi {
                    self.Direction.text = "उत्तर"
                } else if XLanguage.get() == .Portuguese {
                    self.Direction.text = "Norte"
                } else if XLanguage.get() == .Russian {
                    self.Direction.text = "Север"
                } else if XLanguage.get() == .Swedish {
                    self.Direction.text = "Norr"
                } else {
                    self.Direction.text = "Βορράς" // Assuming Greek as the default else case
                }

            }
            
            if cell.Direction == "NE"{
                if XLanguage.get() == .Arabic {
                    self.Direction.text = "الشمال الشرقي"
                } else if XLanguage.get() == .Kurdish {
                    self.Direction.text = "باکوورێ رۆژهەڵات"
                } else if XLanguage.get() == .English {
                    self.Direction.text = "Northeast"
                } else if XLanguage.get() == .Dutch {
                    self.Direction.text = "Noordoost"
                } else if XLanguage.get() == .French {
                    self.Direction.text = "Nord-est"
                } else if XLanguage.get() == .Spanish {
                    self.Direction.text = "Noreste"
                } else if XLanguage.get() == .German {
                    self.Direction.text = "Nordosten"
                } else if XLanguage.get() == .Hebrew {
                    self.Direction.text = "צפון מזרח"
                } else if XLanguage.get() == .Chinese {
                    self.Direction.text = "东北"
                } else if XLanguage.get() == .Hindi {
                    self.Direction.text = "उत्तर-पूर्व"
                } else if XLanguage.get() == .Portuguese {
                    self.Direction.text = "Nordeste"
                } else if XLanguage.get() == .Russian {
                    self.Direction.text = "Северо-восток"
                } else if XLanguage.get() == .Swedish {
                    self.Direction.text = "Nordost"
                } else if XLanguage.get() == .Greek {
                    self.Direction.text = "Βορειοανατολικά"
                }

            }
            
            if cell.Direction == "E"{
                if XLanguage.get() == .Arabic {
                    self.Direction.text = "شرق"
                } else if XLanguage.get() == .Kurdish {
                    self.Direction.text = "رۆژهەڵات"
                } else if XLanguage.get() == .English {
                    self.Direction.text = "East"
                } else if XLanguage.get() == .Dutch {
                    self.Direction.text = "Oost"
                } else if XLanguage.get() == .French {
                    self.Direction.text = "Est"
                } else if XLanguage.get() == .Spanish {
                    self.Direction.text = "Este"
                } else if XLanguage.get() == .German {
                    self.Direction.text = "Osten"
                } else if XLanguage.get() == .Hebrew {
                    self.Direction.text = "מזרח"
                } else if XLanguage.get() == .Chinese {
                    self.Direction.text = "东"
                } else if XLanguage.get() == .Hindi {
                    self.Direction.text = "पूर्व"
                } else if XLanguage.get() == .Portuguese {
                    self.Direction.text = "Leste"
                } else if XLanguage.get() == .Russian {
                    self.Direction.text = "Восток"
                } else if XLanguage.get() == .Swedish {
                    self.Direction.text = "Öst"
                } else if XLanguage.get() == .Greek {
                    self.Direction.text = "Ανατολή"
                }

            }
            
            
            if cell.Direction == "SE"{
                if XLanguage.get() == .Arabic {
                    self.Direction.text = "الجنوب الشرقي"
                } else if XLanguage.get() == .Kurdish {
                    self.Direction.text = "باشوورێ رۆژهەڵات"
                } else if XLanguage.get() == .English {
                    self.Direction.text = "Southeast"
                } else if XLanguage.get() == .Dutch {
                    self.Direction.text = "Zuidoost"
                } else if XLanguage.get() == .French {
                    self.Direction.text = "Sud-est"
                } else if XLanguage.get() == .Spanish {
                    self.Direction.text = "Sureste"
                } else if XLanguage.get() == .German {
                    self.Direction.text = "Südosten"
                } else if XLanguage.get() == .Hebrew {
                    self.Direction.text = "דרום מזרח"
                } else if XLanguage.get() == .Chinese {
                    self.Direction.text = "东南"
                } else if XLanguage.get() == .Hindi {
                    self.Direction.text = "दक्षिण-पूर्व"
                } else if XLanguage.get() == .Portuguese {
                    self.Direction.text = "Sudeste"
                } else if XLanguage.get() == .Russian {
                    self.Direction.text = "Юго-восток"
                } else if XLanguage.get() == .Swedish {
                    self.Direction.text = "Sydost"
                } else if XLanguage.get() == .Greek {
                    self.Direction.text = "Νοτιοανατολικά"
                }

            }
            
            
            if cell.Direction == "S"{
                if XLanguage.get() == .Arabic {
                    self.Direction.text = "الجنوب"
                } else if XLanguage.get() == .Kurdish {
                    self.Direction.text = "باشور"
                } else if XLanguage.get() == .English {
                    self.Direction.text = "South"
                } else if XLanguage.get() == .Dutch {
                    self.Direction.text = "Zuid"
                } else if XLanguage.get() == .French {
                    self.Direction.text = "Sud"
                } else if XLanguage.get() == .Spanish {
                    self.Direction.text = "Sur"
                } else if XLanguage.get() == .German {
                    self.Direction.text = "Süd"
                } else if XLanguage.get() == .Hebrew {
                    self.Direction.text = "דרום"
                } else if XLanguage.get() == .Chinese {
                    self.Direction.text = "南"
                } else if XLanguage.get() == .Hindi {
                    self.Direction.text = "दक्षिण"
                } else if XLanguage.get() == .Portuguese {
                    self.Direction.text = "Sul"
                } else if XLanguage.get() == .Russian {
                    self.Direction.text = "Юг"
                } else if XLanguage.get() == .Swedish {
                    self.Direction.text = "Söder"
                } else if XLanguage.get() == .Greek {
                    self.Direction.text = "Νότος"
                }

            }
            
            if cell.Direction == "SW"{
                if XLanguage.get() == .Arabic {
                    self.Direction.text = "جنوب غرب"
                } else if XLanguage.get() == .Kurdish {
                    self.Direction.text = "باشوورێ رۆژئاڤا"
                } else if XLanguage.get() == .English {
                    self.Direction.text = "Southwest"
                } else if XLanguage.get() == .Dutch {
                    self.Direction.text = "Zuidwest"
                } else if XLanguage.get() == .French {
                    self.Direction.text = "Sud-ouest"
                } else if XLanguage.get() == .Spanish {
                    self.Direction.text = "Suroeste"
                } else if XLanguage.get() == .German {
                    self.Direction.text = "Südwesten"
                } else if XLanguage.get() == .Hebrew {
                    self.Direction.text = "דרום מערב"
                } else if XLanguage.get() == .Chinese {
                    self.Direction.text = "西南"
                } else if XLanguage.get() == .Hindi {
                    self.Direction.text = "दक्षिण-पश्चिम"
                } else if XLanguage.get() == .Portuguese {
                    self.Direction.text = "Sudoeste"
                } else if XLanguage.get() == .Russian {
                    self.Direction.text = "Юго-запад"
                } else if XLanguage.get() == .Swedish {
                    self.Direction.text = "Sydväst"
                } else if XLanguage.get() == .Greek {
                    self.Direction.text = "Νοτιοδυτικά"
                }

            }
            
            if cell.Direction == "W"{
                if XLanguage.get() == .Arabic{
                    self.Direction.text = "الغرب"
                }else if XLanguage.get() == .Kurdish{
                    self.Direction.text = "رۆژئاڤا"
                }else if XLanguage.get() == .English {
                    self.Direction.text = "West"
                } else if XLanguage.get() == .Dutch {
                    self.Direction.text = "West"
                } else if XLanguage.get() == .French {
                    self.Direction.text = "Ouest"
                } else if XLanguage.get() == .Spanish {
                    self.Direction.text = "Oeste"
                } else if XLanguage.get() == .German {
                    self.Direction.text = "Westen"
                } else if XLanguage.get() == .Hebrew {
                    self.Direction.text = "מערב"
                } else if XLanguage.get() == .Chinese {
                    self.Direction.text = "西"
                } else if XLanguage.get() == .Hindi {
                    self.Direction.text = "पश्चिम"
                } else if XLanguage.get() == .Portuguese {
                    self.Direction.text = "Oeste"
                } else if XLanguage.get() == .Russian {
                    self.Direction.text = "Запад"
                } else if XLanguage.get() == .Swedish {
                    self.Direction.text = "Väst"
                } else if XLanguage.get() == .Greek {
                    self.Direction.text = "Δύση"
                }
            }
            
            if cell.Direction == "NW"{
                if XLanguage.get() == .Arabic{
                    self.Direction.text = "الشمال الغربي"
                }else if XLanguage.get() == .Kurdish{
                    self.Direction.text = "باکوورێ رۆژئاڤا"
                }else if XLanguage.get() == .English {
                    self.Direction.text = "Northwest"
                } else if XLanguage.get() == .Dutch {
                    self.Direction.text = "Noordwest"
                } else if XLanguage.get() == .French {
                    self.Direction.text = "Nord-ouest"
                } else if XLanguage.get() == .Spanish {
                    self.Direction.text = "Noroeste"
                } else if XLanguage.get() == .German {
                    self.Direction.text = "Nordwesten"
                } else if XLanguage.get() == .Hebrew {
                    self.Direction.text = "צפון מערב"
                } else if XLanguage.get() == .Chinese {
                    self.Direction.text = "西北"
                } else if XLanguage.get() == .Hindi {
                    self.Direction.text = "उत्तर-पश्चिम"
                } else if XLanguage.get() == .Portuguese {
                    self.Direction.text = "Noroeste"
                } else if XLanguage.get() == .Russian {
                    self.Direction.text = "Северо-запад"
                } else if XLanguage.get() == .Swedish {
                    self.Direction.text = "Nordväst"
                } else if XLanguage.get() == .Greek {
                    self.Direction.text = "Βορειοδυτικά"
                }
            }
            
        

    }
}
