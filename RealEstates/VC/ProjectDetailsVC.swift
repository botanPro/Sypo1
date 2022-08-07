//
//  ProjectDetailsVC.swift
//  RealEstates
//
//  Created by Botan Amedi on 30/07/2022.
//
import UIKit
import FSPagerView
import SDWebImage
import CRRefresh
import Alamofire
import SwiftyJSON
import CollieGallery
import MapKit
import ScrollingPageControl
import SKPhotoBrowser
import YoutubePlayer_in_WKWebView
import FirebaseDynamicLinks
import FCAlertView
class ProjectDetailsVC: UIViewController , WKYTPlayerViewDelegate ,UITextViewDelegate{
    
    
    func playerViewDidBecomeReady(_ playerView: WKYTPlayerView) {
    player.stopVideo()
    }
    override func viewDidDisappear(_ animated: Bool) {
    player.stopVideo()
    }
    

    @IBOutlet weak var Name: UILabel!
    
    
    @IBOutlet weak var Description: UITextView!
    @IBOutlet weak var Location: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var RelatedCollectionView: UICollectionView!
    @IBOutlet weak var DataCollectionView: UICollectionView!
    @IBOutlet weak var ImageCollectionView: UICollectionView!
    
    
    @IBOutlet weak var PagerControl: ScrollingPageControl!{
        didSet {
            self.PagerControl.dotColor = #colorLiteral(red: 0.7037086487, green: 0.7125672698, blue: 0.7124114633, alpha: 0.4034000422)
            self.PagerControl.selectedColor = #colorLiteral(red: 1, green: 0.9771955609, blue: 1, alpha: 1)
            self.PagerControl.dotSize = CGFloat(8)
        }
    }
    
    @IBAction func Dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    var youtubeUrl = ""
    var youtubeId = ""
    @IBOutlet weak var player: WKYTPlayerView!
    
    var sliderImages : [String] = []
    var SimilarArray : [EstateObject] = []
    var pictures : [CollieGalleryPicture] = []
    let sectionInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
    var numberOfItemsPerRow: CGFloat = 2
    let spacingBetweenCells: CGFloat = 10
    var lat = ""
    var long = ""
    var keys : [String] = []
    @IBOutlet weak var State: UILabel!
    var value  : [String] = []
    var ProjectEstate : ProjectObject?
    override func viewDidLoad() {
        super.viewDidLoad()

        RelatedCollectionView.register(UINib(nibName: "AllEstatessCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RelatedCell")
        DataCollectionView.register(UINib(nibName: "DataCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DataCell")
        ImageCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
   
        if sliderImages.count <= 5 {
            self.PagerControl.maxDots = 5
            self.PagerControl.centerDots = 5
        } else {
            self.PagerControl.maxDots = 7
            self.PagerControl.centerDots = 3
        }
        self.Description.delegate = self
        
        
        
        
        if let data = ProjectEstate{
            self.sliderImages = data.images ?? []
            self.PagerControl.pages = data.images?.count ?? 0
            
            self.Name.text = data.project_name ?? ""
            self.Price.text = "\(data.from_price?.description.currencyFormatting() ?? "") to \(data.to_price?.description.currencyFormatting() ?? "")"
            self.Location.text = data.address ?? ""
            self.lat = data.latitude ?? ""
            self.long = data.longitude ?? ""
            self.Description.text = data.desc ?? ""
            self.State.text = data.state ?? ""
            
            let date = NSDate(timeIntervalSince1970: data.uploaded_date_stamp ?? 0.0)
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = "dd MM,YYYY"
            let dateTimeString = dayTimePeriodFormatter.string(from: date as Date)
            let dateTime = dateTimeString.split(separator: ".")
            
            if XLanguage.get() == .Kurdish{
                self.keys.append("بەروار")
                self.keys.append("ژمارەی بیناکان")
                self.keys.append("کرێی خزمەتگوزارییەکانی مانگانە")
                self.keys.append("ساڵی دروست کردن")
                self.keys.append("تەلەفۆنی نووسینگە")
            }else if XLanguage.get() == .English{
                self.keys.append("Date")
                self.keys.append("Buildings No.")
                self.keys.append("Monthly services fee")
                self.keys.append("Constraction year")
                self.keys.append("Office Phone")
            }else{
                self.keys.append("تاريخ")
                self.keys.append("عدد المباني")
                self.keys.append("رسوم الخدمات الشهرية")
                self.keys.append("سنة البناء")
                self.keys.append("هاتف المكتب")
            }
            
            self.value.append("\(dateTime[0])")
            
            self.value.append(data.Buildings_count ?? "")
            
            self.value.append(data.monthly_fee ?? "")
            
            self.value.append(data.year ?? "")
            
            self.value.append(data.project_office_phone ?? "")
            
            
            self.youtubeUrl = data.video_link ?? ""
            self.youtubeId = youtubeUrl.youtubeID ?? ""
            player.load(withVideoId: self.youtubeId, playerVars: ["playsinline":"1"])
            player.delegate = self
            player.layer.masksToBounds = true
            self.player.layer.cornerRadius = 10
            
            
            ProductAip.GetProjectsById(project_id: data.id ?? "") { estates in
                self.SimilarArray.append(estates)
                self.RelatedCollectionView.reloadData()
            }
        }
    }
    
    
    @IBAction func GoToLocation(_ sender: Any) {
        if let UrlNavigation = URL.init(string: "comgooglemaps://") {
            if UIApplication.shared.canOpenURL(UrlNavigation){
                if let urlDestination = URL.init(string: "comgooglemaps://?saddr=&daddr=\(self.lat.trimmingCharacters(in: .whitespaces)),\(self.long.trimmingCharacters(in: .whitespaces))&directionsmode=driving") {
                    UIApplication.shared.open(urlDestination)
                }
            }else {print("opopopopop")
                NSLog("Can't use comgooglemaps://");
                self.openTrackerInBrowser()
            }
        }else{print("lkklklklkl")
            NSLog("Can't use comgooglemaps://");
            self.openTrackerInBrowser()
        }
    }
    
    
    
    func openTrackerInBrowser(){
       if let urlDestination = URL.init(string: "http://maps.google.com/maps?q=loc:\(self.lat.trimmingCharacters(in: .whitespaces)),\(self.long.trimmingCharacters(in: .whitespaces))&directionsmode=driving") {
              UIApplication.shared.open(urlDestination)
          }
      }
    
    
    
    
    
    
    @IBOutlet weak var DescHight: NSLayoutConstraint!
    
    @IBOutlet weak var RelatedEstatesCollectionLayout: NSLayoutConstraint!
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
            UIView.animate(withDuration: 0.2) {
                self.DescHight.constant = self.Description.contentSize.height
            }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            let height = self.RelatedCollectionView.collectionViewLayout.collectionViewContentSize.height
            self.RelatedEstatesCollectionLayout.constant = height
        }
        self.view.layoutIfNeeded()
    }
    
    
}


extension ProjectDetailsVC : UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == ImageCollectionView{
            if sliderImages.count == 0 {
                return 0
            }else{
                return sliderImages.count
            }
        }
        
        if collectionView == DataCollectionView{
            if keys.count == 0{
                return 0
            }
            return keys.count
        }
        
        if collectionView == RelatedCollectionView{
            if SimilarArray.count == 0{
                return 0
            }
            return SimilarArray.count
        }
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == ImageCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
            if self.sliderImages.count != 0{
                let url = URL(string: sliderImages[indexPath.row])
                cell.imagee.sd_setImage(with: url, completed: nil)
            }
            return cell
        }
        
        
        if collectionView == DataCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DataCell", for: indexPath) as! DataCollectionViewCell
            cell.updateKey(cell: self.keys[indexPath.row])
            cell.updateValue(cell: self.value[indexPath.row])
            if XLanguage.get() == .Kurdish{
                cell.Typee.font = UIFont(name: "PeshangDes2", size: 10)!
            }else if XLanguage.get() == .Kurdish{
                cell.Typee.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            }else{
                cell.Typee.font = UIFont(name: "PeshangDes2", size: 10)!
            }
            return cell
        }
        
        if collectionView == RelatedCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RelatedCell", for: indexPath) as! AllEstatessCollectionViewCell
            cell.update(self.SimilarArray[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == ImageCollectionView{
            return CGSize(width: collectionView.frame.size.width, height: 480)
        }
        
        if collectionView == DataCollectionView{
            return CGSize(width: collectionView.frame.size.width / 4, height: 65)
        }
        
        if collectionView == RelatedCollectionView{
            let totalSpacing = (2 * sectionInsets.left) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
            let width = (collectionView.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: 250)
        }
        
        return CGSize()
    }

    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == ImageCollectionView{
             self.PagerControl.selectedPage = indexPath.row
        }
    }
    
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         if collectionView == ImageCollectionView{
         return 0
         }
         if collectionView == DataCollectionView{
             return 0
         }
         if collectionView == RelatedCollectionView{
             return spacingBetweenCells
         }
         return CGFloat()
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == RelatedCollectionView ||  collectionView == DataCollectionView {
            return UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
        }
        return UIEdgeInsets()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == RelatedCollectionView{
            if self.SimilarArray.count != 0 && indexPath.row <= self.SimilarArray.count{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let myVC = storyboard.instantiateViewController(withIdentifier: "GoToProductVC") as! EstateProfileVc
                myVC.CommingEstate = self.SimilarArray[indexPath.row]
                myVC.modalPresentationStyle = .fullScreen
                self.present(myVC, animated: true, completion: nil)
            }
        }
        
        if collectionView == ImageCollectionView{
            var images = [SKPhoto]()
            for img in self.sliderImages{
                let photo = SKPhoto.photoWithImageURL(img)
                photo.shouldCachePhotoURLImage = false
                images.append(photo)
            }
            
            let browser = SKPhotoBrowser(photos: images)
            browser.initializePageIndex(indexPath.row)
            present(browser, animated: true, completion: {})
        }
    }
 
    
}



