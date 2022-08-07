//
//  AllEstateVC.swift
//  RealEstates
//
//  Created by botan pro on 6/11/22.
//

import UIKit
import CRRefresh
class AllEstateVC: UIViewController {
    @IBOutlet weak var AllEstateCollectionView: UICollectionView!
    var AllEstate : [EstateObject] = []
    let sectionInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
    var numberOfItemsPerRow: CGFloat = 2
    let spacingBetweenCells: CGFloat = 10
    var EstateType = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        AllEstateCollectionView.register(UINib(nibName: "AllEstatessCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AllCell")
        
        
        
        
        
        if AllEstate.count != 0{
            
            self.AllEstateCollectionView.reloadData()
            
        }else if EstateType != ""{
            
            self.GetEstates(type: self.EstateType)

        }
        
        
        
        
        self.AllEstateCollectionView.cr.addHeadRefresh(animator: FastAnimator()) {
            if self.EstateType != ""{
                self.GetEstates(type: self.EstateType)
            }else{
                self.AllEstateCollectionView.cr.endHeaderRefresh()
            }
        }
        
        
        
      
    }
    
    func GetEstates(type : String){
        ProductAip.GetAllSectionProducts(TypeId: type) { Product in
            self.AllEstate.append(Product)
            self.AllEstateCollectionView.cr.endHeaderRefresh()
            self.AllEstateCollectionView.reloadData()
        }
        
    }
}

extension AllEstateVC : UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if AllEstate.count == 0{
                self.AllEstateCollectionView.alpha = 0
                return 0
            }
             self.AllEstateCollectionView.alpha = 1
            return AllEstate.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllCell", for: indexPath) as! AllEstatessCollectionViewCell
        cell.update(self.AllEstate[indexPath.row])
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let totalSpacing = (2 * sectionInsets.left) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
            let width = (collectionView.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: 250)
    }

    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

             return spacingBetweenCells
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.AllEstate.count != 0 && indexPath.row <= self.AllEstate.count{
            InsertViewdItem(id : self.AllEstate[indexPath.row].id ?? "")
        self.performSegue(withIdentifier: "Next", sender: AllEstate[indexPath.row])
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let estate = sender as? EstateObject{
            if let next = segue.destination as? EstateProfileVc{
                next.CommingEstate = estate
            }
        }
    }
    
    
    func InsertViewdItem(id : String){
        if let FireId = UserDefaults.standard.string(forKey: "UserId"){
            ViewdItemsObjectAip.GeViewdItemsById(fire_id: FireId) { item in
                if item.estate_id != id || FireId != item.fire_id{
                    //ViewdItemsObject.init(fire_id: FireId, estate_id: id, id: UUID().uuidString).Upload()
                }
            }
        }
    }
}
