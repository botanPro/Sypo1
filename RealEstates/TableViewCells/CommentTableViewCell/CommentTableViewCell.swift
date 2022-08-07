//
//  CommentTableViewCell.swift
//  RealEstates
//
//  Created by botan pro on 6/8/21.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var Datee: UILabel!
    
    @IBOutlet weak var Name: UILabel!
    
    @IBOutlet weak var Imagee: UIImageView!
    
    @IBOutlet weak var Comment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.Imagee.layer.cornerRadius = self.Imagee.bounds.width / 2
    }

    
//    func update(cell : CommentObject){
//        self.Comment.text = cell.comment
//        self.Datee.text = cell.date
//        self.Name.text = cell.name
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
