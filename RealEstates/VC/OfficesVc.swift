//
//  EstatesVC.swift
//  RealEstates
//
//  Created by botan pro on 4/16/21.
//

import UIKit
import CRRefresh
class EstatesVC: UIViewController {
    @IBOutlet weak var NavTitle: LanguageBarItem!
    @IBOutlet weak var EstateCollectionView: UICollectionView!{didSet{self.EstateCollectionView.delegate = self; self.EstateCollectionView.dataSource = self ; self.GetOffices()}}
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
    var numberOfItemsPerRow: CGFloat = 1
    let spacingBetweenCells: CGFloat = 10
    var Offices : [OfficesObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.InternetViewHeight.constant = 0
        self.InternetConnectionView.isHidden = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
       
        EstateCollectionView.register(UINib(nibName: "EstatesOfficeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")

        self.EstateCollectionView.cr.addHeadRefresh(animator: FastAnimator()) {
            self.GetOffices()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.LanguageChanged), name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)
        
    }
    
    
    @objc func LanguageChanged(){
        self.EstateCollectionView.reloadData()
    }
    
    var IsInternetChecked = false
    @IBOutlet weak var InternetViewHeight: NSLayoutConstraint!
    @IBOutlet weak var InternetConnectionView: UIView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if CheckInternet.Connection(){
            self.IsInternetChecked = false
            UIView.animate(withDuration: 0.3) {
                self.InternetViewHeight.constant = 0
                self.InternetConnectionView.isHidden = true
                self.view.layoutIfNeeded()
            }
        }
        if !CheckInternet.Connection(){
            self.InternetViewHeight.constant = 20
            self.InternetConnectionView.isHidden = false
        }else{
            self.IsInternetChecked = false
            UIView.animate(withDuration: 0.3) {
                self.InternetViewHeight.constant = 0
                self.InternetConnectionView.isHidden = true
                self.view.layoutIfNeeded()
            }
        }
        
    }
    
   func GetOffices(){
        self.Offices.removeAll()
        OfficeAip.GetAllOffice{ office in
            for off in office {
                if off.archived != "1" && off.type_id == "h9nFfUrHgSwIg17uRwTD"{
                    self.Offices.append(off)
                }
            }
            print("office count is : \(office.count)")
            self.EstateCollectionView.reloadData()
            self.EstateCollectionView.cr.endHeaderRefresh()
        }
    }
    
}

extension EstatesVC : UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if Offices.count == 0 {
            return 0
        }else{
            return Offices.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EstatesOfficeCollectionViewCell
        if self.Offices.count != 0{
            cell.update(self.Offices[indexPath.row])
        }
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing = (1 * sectionInsets.left) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row

        if let collection = self.EstateCollectionView{
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: 220)
        } else {
            return CGSize(width: 0, height: 0)
        }
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return sectionInsets
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return spacingBetweenCells
     }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.Offices.count != 0  && indexPath.row <= self.Offices.count{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let myVC = storyboard.instantiateViewController(withIdentifier: "OfficeVC") as! OfficeVC
            myVC.modalPresentationStyle = .fullScreen
            myVC.OfficeData = self.Offices[indexPath.row]
            self.present(myVC, animated: true, completion: nil)
        }
    }
    
    

}
