//
//  ExpImagesCollectionViewCell.swift
//  ForNeed
//
//  Created by botan pro on 7/26/21.
//

import UIKit

class ExpImagesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var Delete: UIButton!
    @IBOutlet weak var Imagee: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        Imagee.layer.cornerRadius = 8
        
    }

}
