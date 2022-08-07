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

    var count = 0.0
    var RateValue = 0.0
    func update(_ cell: OfficesObject){
        count = 0.0
        RateValue = 0.0
        guard let imagrUrl = cell.ImageURL, let url = URL(string: imagrUrl) else {return}
        self.Imagee.sd_setImage(with: url, completed: nil)
        self.Name.text = cell.name
        self.Location.text = cell.address
        
        
        OfficeRatingAip.GetRatingByOfficeId(office_id: cell.id ?? "") { arr in
            if arr.office_id == cell.id{
                self.count += 1
                self.RateValue += arr.rate ?? 0.0
            }
            self.RateValue = self.RateValue / self.count
            print("RateValue : \(self.RateValue)")
            self.RateLable.text = "\(self.RateValue)"
        }
       
    }
    
}
