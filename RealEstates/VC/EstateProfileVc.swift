//
//  EstateProfileVc.swift
//  RealEstates
//
//  Created by botan pro on 1/9/22.
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
import Drops
import NVActivityIndicatorView

class EstateProfileVc: UIViewController, UITextViewDelegate, WKYTPlayerViewDelegate , FCAlertViewDelegate, MKMapViewDelegate, CLLocationManagerDelegate,UIPickerViewDelegate , UIPickerViewDataSource, UIScrollViewDelegate, UIGestureRecognizerDelegate{
    
    func playerViewDidBecomeReady(_ playerView: WKYTPlayerView) {
    player.stopVideo()
    }
    override func viewDidDisappear(_ animated: Bool) {
    player.stopVideo()
    }
    
    
    
    @IBAction func Dismiss(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "EstateVCDismissed"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBOutlet weak var Scrollview: UIScrollView!{didSet{
        self.Scrollview.delegate = self
    }}
    
    
    @IBOutlet weak var DismissAfterScroll: UIButton!
    
    @IBOutlet weak var DismissAfterScrollTopLayout: NSLayoutConstraint!
    
    @IBAction func DismissAfterScroll(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y >= 80{
            UIView.animate(withDuration: 0.5) {
                self.DismissAfterScrollTopLayout.constant = 60
                self.view.layoutIfNeeded()
            }
        }
        
        if scrollView.contentOffset.y < 78{
            UIView.animate(withDuration: 0.3) {
                self.DismissAfterScrollTopLayout.constant = -100
                self.view.layoutIfNeeded()
            }
        }
        
    }
    
    
    
    
    @IBOutlet weak var AddToFav: UIButton!
    @IBAction func AddToFav(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: "Login") == true {
            if let FireId = UserDefaults.standard.string(forKey: "UserId"){
                FavoriteItemsObjectAip.GetFavoriteItemsById(fire_id: FireId) { item in
                    if item.fire_id == FireId && item.estate_id == self.CommingEstate?.id ?? ""{print("oooooo")
                        FavoriteItemsObject.init(fire_id: "", estate_id: "", id:item.id ?? "").Remov()
                        self.AddToFav.setImage(UIImage(named: "Heart"), for: .normal)
                    }else{print("iiiiii")
                        print("\(FireId)\n \(self.CommingEstate?.id ?? "")")
                        FavoriteItemsObject.init(fire_id: FireId, estate_id: self.CommingEstate?.id ?? "", id:UUID().uuidString).Upload()
                        self.AddToFav.setImage(UIImage(named: "fill_heart"), for: .normal)
                    }
                }
                
            }
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVCViewController
            vc.modalPresentationStyle = .fullScreen
            vc.IsFromAnotherVc = true
            self.present(vc, animated: true)
        }
    }
    
    @IBAction func Share(_ sender: Any) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.example.com"
        components.path = "/maskani"
        if let estateid = self.CommingEstate{
            let maskaniIdQueryItem = URLQueryItem(name: "estateid", value: "\(estateid.id ?? "")")
            components.queryItems = [maskaniIdQueryItem]
            
            
            guard let linkParameter =  components.url else{return}
            print("i'm sharing \(linkParameter.absoluteString)")
            
            guard let shareLink = DynamicLinkComponents.init(link: linkParameter, domainURIPrefix: "https://maskanis.page.link") else {
                print("could not create FDL components")
                return
            }
            
            
            
            if let bundleId = Bundle.main.bundleIdentifier{
                shareLink.iOSParameters = DynamicLinkIOSParameters(bundleID: bundleId)
            }
            shareLink.iOSParameters?.appStoreID = "1602905831"
            shareLink.androidParameters = DynamicLinkAndroidParameters(packageName: "com.alend.maskani")
            
            shareLink.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
            
            shareLink.socialMetaTagParameters?.title = estateid.name
            
            shareLink.socialMetaTagParameters?.descriptionText = String(estateid.price ?? 0.0).currencyFormatting()
            let urlImage = URL(string: estateid.ImageURL?[0] ?? "")
            shareLink.socialMetaTagParameters?.imageURL = urlImage
            
            shareLink.shorten { [weak self] (url, warnings, error) in
                if let error = error {
                    print("found error \(error.localizedDescription)")
                    return
                }
                
                if let warnings = warnings{
                    for warning in warnings{
                        print("warning : \(warning)")
                    }
                }
                guard let url = url else{return}
                print("short url : \(url)")
                self?.ShowShareSheet(url)
            }
        }
    }
    
    func ShowShareSheet(_ url : URL){
        let image = UIImageView()
        print("alan is bak home --------------------")
        guard let estate = self.CommingEstate else{return}
       
        let urlImage = URL(string: estate.ImageURL?[0] ?? "")
        let promtTex = "\(estate.name ?? "")"
        let activity = UIActivityViewController(activityItems: [promtTex , url , image.sd_setImage(with: urlImage, completed: nil)], applicationActivities: nil)
        
        activity.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo
        ]
        present(activity, animated: true)
    }
    
    
    
    let alert = FCAlertView()
    @IBAction func View365(_ sender: Any) {
        alert.titleColor = .black
        alert.subTitleColor = .darkGray
        alert.makeAlertTypeCaution()
        alert.fullCircleCustomImage = false
        alert.dismissOnOutsideTouch = true
        alert.showAlert(
            inView: self,
            withTitle: "365 Image",
            withSubtitle: "This feature will be available soon.",
            withCustomImage: nil,
            withDoneButtonTitle: nil,
            andButtons: nil)
        alert.doneActionBlock({
           // self.alert.dismiss()
        })
    }
    
    
    
    @IBOutlet weak var Dismiss: UIButton!
    @IBOutlet weak var MapView: MKMapView!
    
    var EstateId = ""
    var sliderImages : [String] = []
    var SimilarArray : [EstateObject] = []
    var pictures : [CollieGalleryPicture] = []
    var NighborArray : [EstateTypeObject] = []
    var selecteCell : EstateTypeObject?
    var SCell = ""
    let sectionInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
    var numberOfItemsPerRow: CGFloat = 2
    let spacingBetweenCells: CGFloat = 10
    
    
    
    
    @IBOutlet weak var EstateName: UILabel!
    
    @IBOutlet weak var OfficeLocation: UILabel!
    @IBOutlet weak var OfficeName: UILabel!
    @IBOutlet weak var OfficeImage: UIImageView!
    @IBOutlet weak var OfficeRate: UILabel!
    
    @IBOutlet weak var RoomNo: UILabel!
    @IBOutlet weak var propertyNo: UILabel!
    @IBOutlet weak var Meters: UILabel!
    
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
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return NighborArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            if XLanguage.get() == .English{
                pickerLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
                pickerLabel?.text = self.NighborArray[row].name
            }else if XLanguage.get() == .Arabic{
                pickerLabel?.font = UIFont(name: "PeshangDes2", size: 12)!
                pickerLabel?.text = self.NighborArray[row].ar_name
            }else{
                pickerLabel?.font = UIFont(name: "PeshangDes2", size: 12)!
                pickerLabel?.text = self.NighborArray[row].ku_name
            }
            pickerLabel?.textAlignment = .center
        }
        

        return pickerLabel!
    }
    
    
    
    
    
    
    var Locations : [Place] = []
 
    
    @IBAction func ChooseEstateType(_ sender: Any) {
        setupEstateTypesAlert()
    }
    var ProjectsTitle = ""
    var ProjectsAction = ""
    var ProjectsCancel = ""
    @IBOutlet weak var NVLoaderView: NVActivityIndicatorView!
    
    var EstateTypepickerView = UIPickerView(frame: CGRect(x: 10, y: 50, width: 250, height: 150))
    private func setupEstateTypesAlert() {
        EstateTypepickerView.delegate = self
        EstateTypepickerView.dataSource = self
        
        if XLanguage.get() == .Kurdish{
            self.ProjectsTitle = "جۆری خانوبەر هەلبژێرە"
            self.ProjectsAction = "هەڵبژێرە"
            self.ProjectsCancel = "هەڵوەشاندنەوە"
        }else if XLanguage.get() == .English{
            self.ProjectsTitle = "Choose Estate Type"
            self.ProjectsAction = "Select"
            self.ProjectsCancel = "Cancel"
        }else{
            self.ProjectsTitle = "اختر نوع العقار"
            self.ProjectsAction  = "تحديد"
            self.ProjectsCancel  = "إلغاء"
        }
        let ac = UIAlertController(title:  self.ProjectsTitle, message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        ac.view.addSubview(EstateTypepickerView)
        ac.addAction(UIAlertAction(title:  self.ProjectsAction, style: .default, handler: { _ in
            self.EstateForMap.removeAll()
            self.Locations.removeAll()
            self.NVLoaderView.startAnimating()
            self.MapView.annotations.forEach {
              if !($0 is MKUserLocation) {
                self.MapView.removeAnnotation($0)
              }
            }
            let pickerValue = self.NighborArray[self.EstateTypepickerView.selectedRow(inComponent: 0)]
            self.EstateTypeLable.text = pickerValue.name
            ProductAip.GetAllEstateForNeighburs(TypeId: pickerValue.id ?? "") { Product in
                self.EstateForMap = Product
                if Product.count != 0{
                    for loc in Product{
                        let lat = Double(loc.lat ?? "")
                        let long = Double(loc.long ?? "")
                            self.Locations.append(Place(coordinate: CLLocationCoordinate2D(latitude: lat ?? 0.0, longitude: long ?? 0.0), profileId: loc.id ?? "", title: loc.name ?? "", subtitle: loc.address ?? ""))
                    }
                }else{
                        var title = "Empty"
                        var message = "No Estates are found"
                        
                        if XLanguage.get() == .English{
                            title = "Empty"
                            message = "No Estates are found"
                        }else if XLanguage.get() == .Kurdish{
                            title = "بەتاڵ"
                            message = "هیچ خانوبەرێک نەدۆزراوەتەوە"
                        }else{
                            title = "فارغة"
                            message = "لم يتم العثور على عقار"
                        }
                        let drop = Drop(
                            title: title,
                            subtitle: message,
                            icon: UIImage(named: "attention"),
                            action: .init {
                                print("Drop tapped")
                                Drops.hideCurrent()
                            },
                            position: .bottom,
                            duration: 3.0,
                            accessibility: "Alert: Title, Subtitle"
                        )
                        Drops.show(drop)
                }
                self.NVLoaderView.stopAnimating()
                self.MapView.addAnnotations(self.Locations)
            }
            
        }))
        ac.addAction(UIAlertAction(title: self.ProjectsCancel, style: .cancel, handler: nil))
        present(ac, animated: true)
        
    }
    
    var Count = 0
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Place else {return nil }

           let identifier = "Capital"
           var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

           if annotationView == nil {
               annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
               annotationView?.canShowCallout = true
               annotationView?.image = UIImage(named: "pin")
               let btn = UIButton(type: .detailDisclosure)
               btn.addTarget(self, action: #selector(callSegueFromCell(_:)), for: .touchUpInside)
               annotationView?.rightCalloutAccessoryView = btn
           } else {
               annotationView?.annotation = annotation
           }
           return annotationView
    }
    
    
    
    
    var SelectedEstateId = ""
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is MKUserLocation{
            return
        }
        
        if let profileID = view.annotation as? Place {
            self.SelectedEstateId = profileID.profileId
        }
    }
    
    
    
    
    @objc  func callSegueFromCell(_ sender:UIButton) {
        ProductAip.GetProduct(ID: self.SelectedEstateId) { product in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let myVC = storyboard.instantiateViewController(withIdentifier: "GoToEstateProfileVc") as! EstateProfileVc
            myVC.CommingEstate = product
            myVC.modalPresentationStyle = .fullScreen
            self.present(myVC, animated: true, completion: nil)
        }
    }
    
    
    
    
    
    
    
    
    @IBOutlet weak var ImagesHeightLayout: NSLayoutConstraint!
    
    
    let device = UIDevice.current
    
    @IBOutlet weak var EstateTypeLable: UILabel!
    @IBOutlet weak var EstateTypeView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        GetAllEstates()
        self.ProjectNameTop.constant = 0
        let deviceName = device.modelNamee
        print(UIDevice.current.modelNamee)
        if deviceName == "iPhone 8" ||  deviceName == "iPhone 7" ||  deviceName == "iPhone 6"{
            self.ImagesHeightLayout.constant = 360
        }
        
        
        print(self.CommingEstate?.bound_id ?? "")
        BoundTypeAip.GetBoundTypeByOfficeId(id: self.CommingEstate?.bound_id ?? "") { bound in
            if XLanguage.get() == .English{
            self.BoundType = bound.en_title ?? ""
            }else if XLanguage.get() == .Arabic{
                self.BoundType = bound.ar_title ?? ""
            }else{
                self.BoundType = bound.ku_title ?? ""
            }
            self.GetData()
        }
        EstateTypeView.layer.backgroundColor = UIColor.clear.cgColor
        EstateTypeView.layer.borderWidth = 1
        EstateTypeView.layer.borderColor = #colorLiteral(red: 0.776776731, green: 0.8295580745, blue: 0.8200985789, alpha: 1)
        
        
        RelatedCollectionView.register(UINib(nibName: "AllEstatessCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RelatedCell")
        DataCollectionView.register(UINib(nibName: "DataCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DataCell")
        ImageCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        self.MapView.layer.cornerRadius = 10
        self.MapView.delegate = self
        if sliderImages.count <= 5 {
            self.PagerControl.maxDots = 5
            self.PagerControl.centerDots = 5
        } else {
            self.PagerControl.maxDots = 7
            self.PagerControl.centerDots = 3
        }
        self.Description.delegate = self
        self.PagerControl.pages = 10
        
        
        GetEstateType()
 
        if let FireId = UserDefaults.standard.string(forKey: "UserId"){
            FavoriteItemsObjectAip.GetFavoriteItemsById(fire_id: FireId) { item in
                if item.fire_id == FireId && item.estate_id == self.CommingEstate?.id ?? ""{
                    self.AddToFav.setImage(UIImage(named: "fill_heart"), for: .normal)
                }else{
                    self.AddToFav.setImage(UIImage(named: "Heart"), for: .normal)
                }
            }
        }
        
    }
    

    
    
    
    func GetEstateType(){
        EstateTypeAip.GetEstateType { types in
            self.NighborArray = types
            self.EstateTypepickerView.reloadAllComponents()
        }
    }
    
    
    func GetRelated(type:String){
            self.SimilarArray.removeAll()
            ProductAip.GetAllSectionProducts(TypeId: type) { Product in
                if Product.archived != "1"{
                   self.SimilarArray.append(Product)
                }
                self.RelatedCollectionView.reloadData()
            }
    }
    
    var EstateForMap : [EstateObject] = []
    var youtubeUrl = ""
    var youtubeId = ""
    @IBOutlet weak var player: WKYTPlayerView!
    var lat = ""
    var long = ""
    var count = 0.0
    var RateValue = 0.0
    var OfficeData : OfficesObject?
    var CommingEstate : EstateObject?
    var RealDirection  = ""
    var lang : Int = UserDefaults.standard.integer(forKey: "language")
    var m2 = ""
    @IBOutlet weak var ProjectNameTop: NSLayoutConstraint!
    @IBOutlet weak var ProjectName: UILabel!
    @IBOutlet weak var DescLable: LanguageLable!
    @IBOutlet weak var DescBottomLayout: NSLayoutConstraint!
    var BoundType = ""
    @IBOutlet weak var VideoHeightLayout: NSLayoutConstraint!
    func GetData(){
        if let data = CommingEstate{
            
            self.profileID = data.id ?? ""
            self.sliderImages = data.ImageURL ?? []
            
            self.PagerControl.pages = data.ImageURL?.count ?? 0
            self.ImageCollectionView.reloadData()
            self.GetRelated(type:data.estate_type_id ?? "")
            self.EstateName.text = data.name
            
            self.RoomNo.text = data.RoomNo
            let font:UIFont? = UIFont(name: "ArialRoundedMTBold", size: 23)!
            let fontSuper:UIFont? = UIFont(name: "ArialRoundedMTBold", size: 15)!
            if XLanguage.get() == .English{
                self.m2 = "m2"
            }else if XLanguage.get() == .Arabic{
                self.m2 = "م٢"
            }else{
                self.m2 = "م٢"
            }
            
            
            
            let attString:NSMutableAttributedString = NSMutableAttributedString(string: "\(data.space ?? "")\(self.m2)", attributes: [.font:font!])
            attString.setAttributes([.font:fontSuper!,.baselineOffset:4], range: NSRange(location:(data.space?.count ?? 0) + 1,length:1))
            self.Meters.attributedText = attString
            self.propertyNo.text = data.propertyNo
            
            self.Location.text = data.address
            
            if data.desc == ""{
                self.DescLable.isHidden = true
                UIView.animate(withDuration: 1) {
                    self.DescHight.constant = 0
                    self.DescBottomLayout.constant = 0
                }
                self.view.layoutIfNeeded()
            }else{
                self.Description.text = data.desc
                self.DescHight.constant = self.Description.contentSize.height
                UIView.animate(withDuration: 0.2) {
                    self.DescHight.constant = self.Description.contentSize.height
                    self.DescBottomLayout.constant = 25
                }
                self.view.layoutIfNeeded()
            }
            let date = NSDate(timeIntervalSince1970: data.Stamp ?? 0.0)
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = "dd MM,YYYY"
            let dateTimeString = dayTimePeriodFormatter.string(from: date as Date)
            let dateTime = dateTimeString.split(separator: ".")
            
            if XLanguage.get() == .Kurdish{
                self.keys.append("بەروار")
                self.keys.append("مۆبیلیات کراوە")
                self.keys.append("جۆری سەنەد")
                self.keys.append("ساڵی دروست کردن")
                self.keys.append("ئاڕاستە")
                self.keys.append("ئەم خانووبەرە")
            }else if XLanguage.get() == .English{
                self.keys.append("Date")
                self.keys.append("Furnished")
                self.keys.append("Bond Type")
                self.keys.append("Constraction year")
                self.keys.append("Direction")
                self.keys.append("This estate is")
            }else{
                self.keys.append("تاريخ")
                self.keys.append("مفروشة")
                self.keys.append("نوع السند")
                self.keys.append("سنة البناء")
                self.keys.append("الاتجاه")
                self.keys.append("هذا العقار")
            }
            self.value.append("\(dateTime[0])".convertedDigitsToLocale(Locale(identifier: "EN")))
            
            
            if data.Furnished == "0" && XLanguage.get() == .English{
                self.value.append("Furnished")
            }else if data.Furnished == "1" && XLanguage.get() == .English{
                self.value.append("Not Furnished")
            }
            if data.Furnished == "0" && XLanguage.get() == .Kurdish{
                self.value.append("مۆبیلیات کراوە")
            }else if data.Furnished == "1" && XLanguage.get() == .Kurdish{
                self.value.append("مۆبیلیات نییە")
            }
            if data.Furnished == "0" && XLanguage.get() == .Arabic{
                self.value.append("مفروشة")
            }else if data.Furnished == "1" && XLanguage.get() == .Arabic{
                self.value.append("غير مفروشة")
            }
            
            
            
            self.value.append(self.BoundType)
            
            self.value.append(data.Year ?? "")
            

            
            if data.Direction == "N"{
                if XLanguage.get() == .English{
                    self.value.append("North")
                }else if XLanguage.get() == .Arabic{
                    self.value.append("شمال")
                }else{
                    self.value.append("باکور")
                }
            }
            
            if data.Direction == "NE"{
                if XLanguage.get() == .English{
                    self.value.append("Northeast")
                }else if XLanguage.get() == .Arabic{
                    self.value.append("الشمال الشرقي")
                }else{
                    self.value.append("باکوورێ رۆژهەڵات")
                }
            }
            
            if data.Direction == "E"{
                if XLanguage.get() == .English{
                    self.value.append("East")
                }else if XLanguage.get() == .Arabic{
                    self.value.append("شرق")
                }else{
                    self.value.append("رۆژهەڵات")
                }
            }
            
            
            if data.Direction == "SE"{
                if XLanguage.get() == .English{
                    self.value.append("Southeast")
                }else if XLanguage.get() == .Arabic{
                    self.value.append("الجنوب الشرقي")
                }else{
                    self.value.append("باشوورێ رۆژهەڵات")
                }
            }
            
            
            if data.Direction == "S"{
                if XLanguage.get() == .English{
                    self.value.append("South")
                }else if XLanguage.get() == .Arabic{
                    self.value.append("الجنوب")
                }else{
                    self.value.append("باشور")
                }
            }
            
            if data.Direction == "SW"{
                if XLanguage.get() == .English{
                    self.value.append("Southwest")
                }else if XLanguage.get() == .Arabic{
                    self.value.append("جنوب غرب")
                }else{
                    self.value.append("باشوورێ رۆژئاڤا")
                }
            }
            
            if data.Direction == "W"{
                if XLanguage.get() == .English{
                    self.value.append("West")
                }else if XLanguage.get() == .Arabic{
                    self.value.append("الغرب")
                }else{
                    self.value.append("رۆژئاڤا")
                }
            }
            
            if data.Direction == "NW"{
                if XLanguage.get() == .English{
                    self.value.append("Northwest")
                }else if XLanguage.get() == .Arabic{
                    self.value.append( "الشمال الغربي")
                }else{
                    self.value.append("باکوورێ رۆژئاڤا")
                }
            }
            
            
            if data.RentOrSell == "0"{
                if XLanguage.get() == .Kurdish{
                    let longString = "\(data.price?.description.currencyFormatting() ?? "")/ مانگانە"
                    let longestWord = "مانگانە"
                    let longestWordRange = (longString as NSString).range(of: longestWord)

                    let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                    attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "PeshangDes2", size: 16)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                    
                    self.Price.attributedText = attributedString
                }else if XLanguage.get() == .English{
                    let longString = "\(data.price?.description.currencyFormatting() ?? "")/ Monthly"
                    let longestWord = "Monthly"
                    let longestWordRange = (longString as NSString).range(of: longestWord)

                    let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                    attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 15)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                    
                    self.Price.attributedText = attributedString
                }else{
                    let longString = "\(data.price?.description.currencyFormatting() ?? "")/ شهريا"
                    let longestWord  = "شهريا"
                    let longestWordRange = (longString as NSString).range(of: longestWord)

                    let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                    attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "PeshangDes2", size: 16)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                    
                    self.Price.attributedText = attributedString
                }
                
                if XLanguage.get() == .Kurdish{
                    self.value.append("بۆ کرێ")
                }else if XLanguage.get() == .English{
                    self.value.append("For Rent")
                }else{
                    self.value.append("للايجار")
                }
            }else{
                if XLanguage.get() == .Kurdish{
                    self.value.append("بۆ فرۆشتن")
                }else if XLanguage.get() == .English{
                    self.value.append("For Sell")
                }else{
                    self.value.append("للبيع")
                }
                self.Price.text = data.price?.description.currencyFormatting()
            }
           
            
            
            if data.video_link == ""{
                self.VideoHeightLayout.constant = 0
            }else{
            self.youtubeUrl = data.video_link ?? ""
            self.youtubeId = youtubeUrl.youtubeID ?? ""
            player.load(withVideoId: self.youtubeId, playerVars: ["playsinline":"1"])
            player.delegate = self
            player.layer.masksToBounds = true
            }
            
            
            if data.estate_type_id == "UTY25FYJHkliygt4nvPP"{
                self.ProjectNameTop.constant = 8
                GetAllProjectsAip.GeeProjectById(fire_id: data.project_id ?? "") { project in
                    if XLanguage.get() == .English{
                        self.ProjectName.text = project.project_name
                        self.ProjectName.font = UIFont(name: "ArialRoundedMTBold", size: 17)!
                    }else if XLanguage.get() == .Arabic{
                        self.ProjectName.text = project.project_ar_name
                        self.ProjectName.font = UIFont(name: "PeshangDes2", size: 17)!
                    }else{
                        self.ProjectName.text = project.project_ku_name
                        self.ProjectName.font = UIFont(name: "PeshangDes2", size: 17)!
                    }
                }
                
                if XLanguage.get() == .Kurdish{
                    self.keys.append("کرێی خزمەتگوزارییەکانی مانگانە")
                    self.keys.append("باڵەخانە")
                    self.keys.append("نهۆم")
                    self.keys.append("ژمارەی خانووبەر")
                }else if XLanguage.get() == .English{
                    self.keys.append("Monthly Services Fee")
                    self.keys.append("Building")
                    self.keys.append("Floor")
                    self.keys.append("Property No.")
                }else{
                    self.keys.append("رسوم الخدمات الشهرية")
                    self.keys.append("عمارة")
                    self.keys.append("الطابق")
                    self.keys.append("رقم العقار")
                }
                
                
                self.value.append(data.MonthlyService?.description.currencyFormattingIQD() ?? "")
                
                self.value.append(data.Building ?? "")
                
                self.value.append(data.floor ?? "")
                
                self.value.append(data.propertyNo ?? "")
                

            }
            
            self.DataCollectionView.reloadData()
            
            
                OfficeAip.GetOffice(ID: data.office_id ?? "") { office in
                    self.OfficeData = office
                    let url = URL(string: office.ImageURL ?? "")
                    self.OfficeImage.sd_setImage(with: url, completed: nil)
                    self.OfficeName.text = office.name?.description.uppercased()
                    self.OfficeLocation.text = office.address
                    
                    OfficeRatingAip.GetRatingByOfficeId(office_id: office.id ?? "") { arr in
                        self.count += 1
                        self.RateValue = self.RateValue + (arr.rate ?? 0.0)
                        self.OfficeRate.text = "\((self.RateValue / self.count).rounded(toPlaces: 1))"
                    }
                }
                self.lat = data.lat ?? ""
                self.long = data.long ?? ""
                let dbLat = Double(data.lat ?? "")
                let dbLong = Double(data.long ?? "")
                self.zoomToLocation(with: CLLocationCoordinate2D(latitude: dbLat!, longitude: dbLong!))
            
            }
        
        
        
        
        
        
        
        
    }
    
    
    var AllEstateArray : [EstateObject] = []
    func GetAllEstates(){
        self.AllEstateArray.removeAll()
        ProductAip.GetAllProducts { Product in
            for UnArchived in Product{
                if UnArchived.archived != "1"{
                   self.AllEstateArray.append(UnArchived)
                }
            }
        }
    }
    
    
    
    
    func zoomToLocation(with coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        self.MapView.setRegion(region, animated: true)
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = coordinate
        objectAnnotation.title = ""
        self.MapView.addAnnotation(objectAnnotation)
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
    
    
    
    

    
    
    
    @IBAction func GoToOffice(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myVC = storyboard.instantiateViewController(withIdentifier: "OfficeVC") as! OfficeVC
        myVC.modalPresentationStyle = .fullScreen
        myVC.OfficeData = self.OfficeData
        self.present(myVC, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var DescHight: NSLayoutConstraint!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            let height = self.RelatedCollectionView.collectionViewLayout.collectionViewContentSize.height
            self.RelatedEstatesCollectionLayout.constant = height
        }
    }
    
    
    
    func GetImages(){
        if self.profileID != ""{
//            self.sliderImages.removeAll()
//            profileImageObjectAPI.GetprofileImage(profileId: (self.profileID as NSString).integerValue) { (images) in
//                self.sliderImages = images
//                //self.SliderController.numberOfPages = self.sliderImages.count
//                for image in images{
//                    let strUrl = "\(API.RealEstateImages)\(image.image)"
//                    let picture = CollieGalleryPicture(url: strUrl.replacingOccurrences(of: " ", with: "%20"))
//                    print(strUrl)
//                    self.pictures.append(picture)
//                }
//                self.ImageCollectionView.reloadData()
//            }
        }
    }
    
    
    
    
    
    var keys : [String] = []
    var value  : [String] = []
    var profileID = ""
    

    
    
    
    @IBOutlet weak var RelatedEstatesCollectionLayout: NSLayoutConstraint!
    
 
    
    
    
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









extension EstateProfileVc : UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    
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
            
            if indexPath.row + 1 == self.value.count{
                cell.rightimage.isHidden = true
            }
            
            if XLanguage.get() == .Kurdish{
                cell.Typee.font = UIFont(name: "PeshangDes2", size: 11)!
                cell.Value.font = UIFont(name: "PeshangDes2", size: 10)!
            }else if XLanguage.get() == .English{
                cell.Typee.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
                cell.Value.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
            }else{
                cell.Typee.font = UIFont(name: "PeshangDes2", size: 11)!
                cell.Value.font = UIFont(name: "PeshangDes2", size: 10)!
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
        if collectionView == RelatedCollectionView ||  collectionView == DataCollectionView{
            return UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
        }
        return UIEdgeInsets()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
        if collectionView == RelatedCollectionView{
            if self.SimilarArray.count != 0 && indexPath.row <= self.SimilarArray.count{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let myVC = storyboard.instantiateViewController(withIdentifier: "GoToEstateProfileVc") as! EstateProfileVc
                myVC.CommingEstate = self.SimilarArray[indexPath.row]
                myVC.modalPresentationStyle = .fullScreen
                InsertViewdItem(id : self.SimilarArray[indexPath.row].id ?? "")
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




extension String {
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)
        
        guard let result = regex?.firstMatch(in: self, range: range) else {
            return nil
        }
        
        return (self as NSString).substring(with: result.range)
    }
    
}




