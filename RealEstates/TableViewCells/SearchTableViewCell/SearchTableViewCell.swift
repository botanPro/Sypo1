//
//  SearchTableViewCell.swift
//  RealEstates
//
//  Created by botan pro on 4/16/21.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var NRlable: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var NumberOfRooms: UILabel!
    @IBOutlet weak var Metters: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var Imagee: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.Imagee.layer.cornerRadius = 12
    }

    
    
//    
//    func update(cell: RelatedProfilesObject){
//        self.Price.text = "\(cell.price) USD"
//        self.Name.text = cell.name
//        self.Metters.text = cell.space
//        self.NumberOfRooms.text = cell.type_name
//        self.NRlable.isHidden = true
//        let strUrl = "\(API.RealEstateImages)\(cell.image)";
//        guard let urlString = strUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return  }
//        let Url = URL(string: urlString)
//        self.Imagee?.sd_setImage(with: Url, completed: nil)
//    }
//    
//    func update(cell: ProfilesHomeObject){
//        self.Price.text = "\(cell.price) USD"
//        self.Name.text = cell.name
//        self.Metters.text = cell.space
//        self.NumberOfRooms.text = cell.type_name
//        self.NRlable.isHidden = true
//        let strUrl = "\(API.RealEstateImages)\(cell.image)";
//        guard let urlString = strUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return  }
//        let Url = URL(string: urlString)
//        self.Imagee?.sd_setImage(with: Url, completed: nil)
//    }
}
