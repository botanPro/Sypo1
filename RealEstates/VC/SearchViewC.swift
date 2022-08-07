//
//  SearchViewC.swift
//  RealEstates
//
//  Created by botan pro on 1/24/22.
//

import UIKit

class SearchViewC: UIViewController {

    @IBOutlet weak var SearchCollectionView: UICollectionView!
    @IBOutlet weak var Searchtext: UITextField!
    @IBOutlet weak var NavTitle: LanguageBarItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        NavTitle.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 20)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
    }
    

}
