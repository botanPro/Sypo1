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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var rooms = ""
    var lang : Int = UserDefaults.standard.integer(forKey: "language")
    func update(_ cell: EstateObject){
        guard let imagrUrl = cell.ImageURL, let url = URL(string: imagrUrl[0]) else {return}
        self.Imagee.sd_setImage(with: url, completed: nil)
        self.Name.text = cell.name
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
 
        
        if XLanguage.get() == .English{
            self.Direction.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
        }else if XLanguage.get() == .Arabic{
            self.Direction.font = UIFont(name: "PeshangDes2", size: 11)!
        }else{
            self.Direction.font = UIFont(name: "PeshangDes2", size: 11)!
        }
        
        if cell.Direction == "N"{
            if XLanguage.get() == .English{
                self.Direction.text = "North"
            }else if XLanguage.get() == .Arabic{
                self.Direction.text = "شمال"
            }else{
                self.Direction.text = "باکور"
            }
        }
        
        if cell.Direction == "NE"{
            if XLanguage.get() == .English{
                self.Direction.text = "Northeast"
            }else if XLanguage.get() == .Arabic{
                self.Direction.text = "الشمال الشرقي"
            }else{
                self.Direction.text = "باکوورێ رۆژهەڵات"
            }
        }
        
        if cell.Direction == "E"{
            if XLanguage.get() == .English{
                self.Direction.text = "East"
            }else if XLanguage.get() == .Arabic{
                self.Direction.text = "شرق"
            }else{
                self.Direction.text = "رۆژهەڵات"
            }
        }
        
        
        if cell.Direction == "SE"{
            if XLanguage.get() == .English{
                self.Direction.text = "Southeast"
            }else if XLanguage.get() == .Arabic{
                self.Direction.text = "الجنوب الشرقي"
            }else{
                self.Direction.text = "باشوورێ رۆژهەڵات"
            }
        }
        
        
        if cell.Direction == "S"{
            if XLanguage.get() == .English{
                self.Direction.text = "South"
            }else if XLanguage.get() == .Arabic{
                self.Direction.text = "الجنوب"
            }else{
                self.Direction.text = "باشور"
            }
        }
        
        if cell.Direction == "SW"{
            if XLanguage.get() == .English{
                self.Direction.text = "Southwest"
            }else if XLanguage.get() == .Arabic{
                self.Direction.text = "جنوب غرب"
            }else{
                self.Direction.text = "باشوورێ رۆژئاڤا"
            }
        }
        
        if cell.Direction == "W"{
            if XLanguage.get() == .English{
                self.Direction.text = "West"
            }else if XLanguage.get() == .Arabic{
                self.Direction.text = "الغرب"
            }else{
                self.Direction.text = "رۆژئاڤا"
            }
        }
        
        if cell.Direction == "NW"{
            if XLanguage.get() == .English{
                self.Direction.text = "Northwest"
            }else if XLanguage.get() == .Arabic{
                self.Direction.text = "الشمال الغربي"
            }else{
                self.Direction.text = "باکوورێ رۆژئاڤا"
            }
        }
        

    }
}
