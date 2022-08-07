//
//  DataTableVeiwCell.swift
//  RealEstates
//
//  Created by botan pro on 4/18/21.
//

import UIKit

class DataTableVeiwCell: UITableViewCell {

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
