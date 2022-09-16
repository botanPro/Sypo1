//
//  EstatesOfficeCollectionViewCell.swift
//  RealEstates
//
//  Created by botan pro on 1/21/22.
//

import UIKit

class EstatesOfficeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var RateLable: UILabel!
    @IBOutlet weak var Imagee: UIImageView!
    @IBOutlet weak var Location: UILabel!
    @IBOutlet weak var Name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func detectLanguage<T: StringProtocol>(for text: T) -> String? {
        let tagger = NSLinguisticTagger.init(tagSchemes: [.language], options: 0)
        tagger.string = String(text)

        guard let languageCode = tagger.tag(at: 0, scheme: .language, tokenRange: nil, sentenceRange: nil) else { return nil }
        print(languageCode.rawValue)
        return Locale.current.localizedString(forIdentifier: languageCode.rawValue)
    }
    var count = 0.0
    var RateValue = 0.0
    func update(_ cell: OfficesObject){
        count = 0.0
        RateValue = 0.0
        guard let imagrUrl = cell.ImageURL, let url = URL(string: imagrUrl) else {return}
        self.Imagee.sd_setImage(with: url, completed: nil)
        self.Name.text = cell.name
        self.Location.text = cell.address
        if detectLanguage(for:self.Name.text!) == "Arabic"{
            self.Name.font = UIFont(name: "PeshangDes2", size: 14)!
        }else{
            self.Name.font = UIFont(name: "ArialRoundedMTBold", size: 14)!
        }
        
        OfficeRatingAip.GetRatingByOfficeId(office_id: cell.id ?? "") { arr in
            self.count += 1
            self.RateValue = self.RateValue + (arr.rate ?? 0.0)
            self.RateLable.text = "\((self.RateValue / self.count).rounded(toPlaces: 1))"
        }
    }
}

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
