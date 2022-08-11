
import UIKit
import WebKit
import Firebase
import FirebaseStorage
import FirebaseFirestore
import SwiftyJSON
import CRRefresh
class MXWebViewController: UIViewController {


    let sectionInsets = UIEdgeInsets(top: 16.0, left: 10.0, bottom: 20.0, right: 10.0)
    var numberOfItemsPerRow: CGFloat = 2
    let spacingBetweenCells: CGFloat = 10
    var RentAndSellArray : [EstateObject] = []
    
    @IBOutlet weak var RentAndSellCollectionView: UICollectionView!{didSet{self.RentAndSellCollectionView.delegate = self; self.RentAndSellCollectionView.dataSource = self}}
    override func viewDidLoad() {
        super.viewDidLoad()
        RentAndSellCollectionView.register(UINib(nibName: "AllEstatessCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        self.RentAndSellCollectionView.cr.addHeadRefresh(animator: FastAnimator()) {
            self.GetEstatesByType()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.LanguageChanged), name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GetEstatesByType()
    }
    
    @objc func LanguageChanged(){
        self.RentAndSellCollectionView.reloadData()
    }
    func GetEstatesByType(){
        self.RentAndSellArray.removeAll()
        Firestore.firestore().collection("EstateProducts").whereField("rent_or_sell", isEqualTo: "1").getDocuments { (Snapshot, error) in
            if error != nil { print(error.debugDescription) ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    if EstateObject(Dictionary: data).archived != "1"{
                         self.RentAndSellArray.append(EstateObject(Dictionary: data))
                    }
                }
            }
            self.RentAndSellCollectionView.cr.endHeaderRefresh()
            self.RentAndSellCollectionView.reloadData()
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




extension MXWebViewController : UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.RentAndSellCollectionView{
            if RentAndSellArray.count == 0 {
                self.RentAndSellCollectionView.alpha = 0
                return 0
            }else{
                self.RentAndSellCollectionView.alpha = 1
                return RentAndSellArray.count
            }
        }

        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.RentAndSellCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AllEstatessCollectionViewCell
            if self.RentAndSellArray.count != 0{
                cell.update(self.RentAndSellArray[indexPath.row])
            }
            return cell
        }

        return UICollectionViewCell()
    }



    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing = (2 * sectionInsets.left) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        if let collection = self.RentAndSellCollectionView{
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: 250)
        }
        return CGSize()
    }



     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == self.RentAndSellCollectionView{
         return sectionInsets
        }
        return UIEdgeInsets()
     }



     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.RentAndSellCollectionView {
         return spacingBetweenCells
        }
        return CGFloat()
     }



    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.RentAndSellCollectionView{
            if self.RentAndSellArray.count != 0  && indexPath.row <= self.RentAndSellArray.count{
                InsertViewdItem(id : self.RentAndSellArray[indexPath.row].id ?? "")
            self.performSegue(withIdentifier: "Next", sender: RentAndSellArray[indexPath.row])
            }
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let estate = sender as? EstateObject{
            if let next = segue.destination as? EstateProfileVc{
                next.CommingEstate = estate
            }
        }
    }
    
    



}
