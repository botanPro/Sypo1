//
//  ProductCollectionViewCell.swift
//  RealEstates
//
//  Created by botan pro on 4/16/21.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var BlurView: UIVisualEffectView!
    @IBOutlet weak var NRLable: UILabel!
    
    @IBOutlet weak var Typee: UILabel!
    @IBOutlet weak var NRoom: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Imagee: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.Imagee.layer.cornerRadius = 13
        self.BlurView.layer.cornerRadius = 13
        self.contentView.layer.masksToBounds = true
        self.layer.cornerRadius = 13
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
    }

    
//    func update(cell : OfficObject){
//        print(cell.name)
//        self.Name.text = cell.name
//        self.price.text = cell.phone1
//        let strUrl = "\(API.OfficeImages)\(cell.image)";
//        guard let urlString = strUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return  }
//        let Url = URL(string: urlString)
//        self.Imagee?.sd_setImage(with: Url, completed: nil)
//    }
//    
//
//    func update(cell : ProfilesHomeObject){
//        self.Name.text = cell.name
//        self.price.text = "\(cell.price) USD"
//        self.Typee.text = cell.type_name
//        self.NRoom.text = cell.space
//        let strUrl = "\(API.RealEstateImages)\(cell.image)";
//        guard let urlString = strUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return  }
//        let Url = URL(string: urlString)
//        self.Imagee?.sd_setImage(with: Url, completed: nil)
//    }
//    
//    func update(cell : ProfilesByIdObject){
//        self.Name.text = cell.name
//        self.price.text = "\(cell.price) USD"
//        self.Typee.text = cell.type_name
//        self.NRoom.text = cell.space
//        let strUrl = "\(API.RealEstateImages)\(cell.image)";
//        guard let urlString = strUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return  }
//        let Url = URL(string: urlString)
//        self.Imagee?.sd_setImage(with: Url, completed: nil)
//    }
//    
//    func update(cell : ){
//
//    }
}
