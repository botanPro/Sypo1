//
//  DataCollectionViewCell.swift
//  RealEstates
//
//  Created by botan pro on 1/10/22.
//

import UIKit

class DataCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var rightimage: UIView!
    @IBOutlet weak var Value: UILabel!
    @IBOutlet weak var Typee: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    func updateKey(cell : String){
        self.Typee.text = cell
    }
    func updateValue(cell : String){
        self.Value.text = cell
    }
}
