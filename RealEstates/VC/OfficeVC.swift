//
//  OfficeVC.swift
//  RealEstates
//
//  Created by botan pro on 1/15/22.
//

import UIKit
import SDWebImage
import Cosmos
import Photos
class OfficeVC: UIViewController {

    @IBAction func Dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var OfficeEstatesCollectionView: UICollectionView!
    
    
    
    
    let sectionInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
    var numberOfItemsPerRow: CGFloat = 2
    let spacingBetweenCells: CGFloat = 10
    
    var OfficeData : OfficesObject?
    var SimilarArray : [EstateObject] = []
    
    @IBOutlet weak var Location: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var AboutHeight: NSLayoutConstraint!
    @IBOutlet weak var Number: UIButton!
    @IBOutlet weak var About: UITextView!
    @IBOutlet weak var CollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var Number2: UIButton!
    @IBOutlet weak var Imagee: UIImageView!
    
    
    
    
    
    var message = ""
    var action = ""
    
    
    var RaterBefor = false
    @IBOutlet weak var RatingStars: CosmosView!{
        didSet{
            if XLanguage.get() == .Kurdish{
                self.message = "پێشتر ئەم ئۆفیسەت هەڵسەنگاندووە."
                self.action = "هەڵوەشاندنەوە"
            }else if XLanguage.get() == .Arabic{
                self.message = "لقد قمت بالفعل بتقييم هذا المكتب من قبل."
                self.action = "إلغاء"
            }else{
                self.message = "you have already rate this office before."
                self.action = "Cancel"
            }
            RatingStars.settings.fillMode = .half
            self.RatingStars.rating = 2.0
            RatingStars.didFinishTouchingCosmos = { rating in
                if UserDefaults.standard.bool(forKey: "Login") == true{
                    if let FireId = UserDefaults.standard.string(forKey: "UserId"){
                        if self.RaterBefor != true{
                            OfficeRatingObject.init(rate: self.RatingStars.rating, rater_fire_id: FireId, office_id: self.OfficeData?.id ?? "", id: UUID().uuidString).Upload()
                            AudioServicesPlaySystemSound(1519);
                            self.RatingStars.isUserInteractionEnabled = false
                        }else{
                            self.RatingStars.rating = 2.0
                            let alertController = UIAlertController(title: "", message: self.message , preferredStyle: .alert)
                            let cancelAction = UIAlertAction(title: self.action, style: UIAlertAction.Style.cancel) { UIAlertAction in }
                            alertController.addAction(cancelAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                }else{
                    self.RatingStars.rating = 2.0
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVCViewController
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                }
            }
            
        }
    }
    
    
    
    @IBOutlet weak var Phone2Stack: UIStackView!
    
    
    @IBOutlet weak var RateLable: UILabel!
    
    
    
    @IBOutlet weak var TopConstraint: NSLayoutConstraint!
    
    let device = UIDevice.current
    var count = 0.0
    var RateValue = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        let deviceName = device.modelNamee
        
        if deviceName == "iPhone X" || deviceName == "iPhone XS" || deviceName == "iPhone XS Max" || deviceName == "iPhone XR" || deviceName == "iPhone 11" || deviceName == "iPhone 11 Pro" || deviceName == "iPhone 11 Pro Max" ||  deviceName == "iPhone 12 mini" || deviceName == "iPhone 12"  || deviceName == "iPhone 12 Pro" || deviceName == "iPhone 12 Pro Max" || deviceName == "iPhone 13 mini"  || deviceName == "iPhone 13" || deviceName == "iPhone 13 Pro" || deviceName == "iPhone 13 Pro Max"{
            self.TopConstraint.constant = 43
        }
        
        OfficeEstatesCollectionView.register(UINib(nibName: "AllEstatessCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RelatedCell")
        
        
        
        
        
        if let data = self.OfficeData{
            self.Name.text = data.name ?? ""
            self.About.text = data.about ?? ""
            UIView.animate(withDuration: 0.2) {
                self.AboutHeight.constant = self.About.contentSize.height
                self.view.layoutIfNeeded()
            }
            
            let url = URL(string: data.ImageURL ?? "")
            self.Imagee.sd_setImage(with: url, completed: nil)
            self.Number.setTitle(data.phone1 ?? "")
            if data.phone2 == ""{
                self.Phone2Stack.isHidden = true
            }else{
                self.Number2.setTitle(data.phone2 ?? "")
            }
            self.Location.text = data.address ?? ""
            ProductAip.GetMyEstates(office_id: data.id ?? "") { estates in
                self.SimilarArray.append(estates)
                self.OfficeEstatesCollectionView.reloadData()
            }
            
            OfficeRatingAip.GetRatingByOfficeId(office_id: data.id ?? "") { arr in
                if arr.office_id == data.id{
                    self.count += 1
                    self.RateValue += arr.rate ?? 0.0
                }
                self.RateValue = self.RateValue / self.count
                print("RateValue : \(self.RateValue)")
                self.RateLable.text = "\(self.RateValue)"
            }
            
            
            if let FireId = UserDefaults.standard.string(forKey: "UserId"){
                OfficeRatingAip.GetAllRating { arr in
                    for i in arr{
                        if i.office_id == self.OfficeData?.id ?? "" && i.rater_fire_id == FireId{
                            self.RaterBefor = true
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func Number(_ sender: Any) {
        
    }
    
    
    @IBAction func Number2(_ sender: Any) {
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
            UIView.animate(withDuration: 0.2) {
                self.AboutHeight.constant = self.About.contentSize.height
                //self.view.layoutIfNeeded()
            }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            let height = self.OfficeEstatesCollectionView.collectionViewLayout.collectionViewContentSize.height
            self.CollectionHeight.constant = height
        }
    }
    
    
    var IsViewd = false
    func InsertViewdItem(id : String){
        if let FireId = UserDefaults.standard.string(forKey: "UserId"){
            self.IsViewd = false
            ViewdItemsObjectAip.GeViewdItemsById(fire_id: FireId) { item in
                
                for i in item{
                    print("CurrentEstateId : \(id)")
                    print("ViewdEstateId : \(i.estate_id ?? "")")
                    
                    print("CurrentFireId : \(FireId)")
                    print("ViewdFireId : \(i.fire_id ?? "")")
                    if i.estate_id == id && FireId == i.fire_id{
                        print("Item is Viewd")
                        self.IsViewd = true
                    }
                }
                if self.IsViewd == false{print("Item is Not Viewd")
                  ViewdItemsObject.init(fire_id: FireId, estate_id: id, id: UUID().uuidString).Upload()
                }
            }
        }
    }
}




extension OfficeVC : UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if SimilarArray.count == 0{
                return 0
            }
            return SimilarArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RelatedCell", for: indexPath) as! AllEstatessCollectionViewCell
            cell.update(self.SimilarArray[indexPath.row])
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
        if self.SimilarArray.count != 0 && indexPath.row <= self.SimilarArray.count{
           InsertViewdItem(id : self.SimilarArray[indexPath.row].id ?? "")
        }
    }
    
    
    
}
