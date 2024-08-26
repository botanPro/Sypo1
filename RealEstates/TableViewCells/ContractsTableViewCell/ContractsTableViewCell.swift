//
//  ContractsTableViewCell.swift
//  RealEstates
//
//  Created by Botan Amedi on 01/06/2023.
//

import UIKit

class ContractsTableViewCell: UITableViewCell {
    @IBOutlet weak var SellBuyLable: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var Location: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Imagee: UIImageView!
    @IBOutlet weak var Date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        
    }
    func detectLanguage<T: StringProtocol>(for text: T) -> String? {
        let tagger = NSLinguisticTagger.init(tagSchemes: [.language], options: 0)
        tagger.string = String(text)

        guard let languageCode = tagger.tag(at: 0, scheme: .language, tokenRange: nil, sentenceRange: nil) else { return nil }
        print(languageCode.rawValue)
        return Locale.current.localizedString(forIdentifier: languageCode.rawValue)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var lang : Int = UserDefaults.standard.integer(forKey: "language")
    func update(_ cell: ContracsObject){
        
        ProductAip.GetProduct(ID: cell.estate_id  ?? "") { product in
            guard let imagrUrl = product.ImageURL, let url = URL(string: imagrUrl[0]) else {return}
            self.Imagee.sd_setImage(with: url, placeholderImage: UIImage(named: "logoPlace"))
            self.Location.text = product.address
            self.Name.text = product.name
            self.Price.text  = product.price?.description.currencyFormatting()
            if self.detectLanguage(for:self.Name.text!) == "Arabic" || self.detectLanguage(for:self.Name.text!) == "Urdu"{
                self.Name.font = UIFont(name: "PeshangDes2", size: 14)!
            }else{
                self.Name.font = UIFont(name: "ArialRoundedMTBold", size: 14)!
            }
        }
        
        
        
        self.Date.text = cell.buy_date?.convertedDigitsToLocale(Locale(identifier: "EN"))
        
        
    }
    
}
