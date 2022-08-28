//
//  Home.swift
//  RealEstates
//
//  Created by botan pro on 1/1/22.
//

import UIKit
import FSPagerView
import CRRefresh
import SDWebImage
import MapKit
import SwiftyJSON
import FirebaseDynamicLinks
import GameplayKit
import FirebaseRemoteConfig

import AZDialogView
class Home: UIViewController ,UITextFieldDelegate ,UIPickerViewDelegate , UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CityArray.count
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            if XLanguage.get() == .English{
                pickerLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
                pickerLabel?.text = self.CityArray[row].name
            }else if XLanguage.get() == .Arabic{
                pickerLabel?.font = UIFont(name: "PeshangDes2", size: 12)!
                pickerLabel?.text = self.CityArray[row].ar_name
            }else{
                pickerLabel?.font = UIFont(name: "PeshangDes2", size: 12)!
                pickerLabel?.text = self.CityArray[row].ku_name
            }
            pickerLabel?.textAlignment = .center
        }
        
        
        return pickerLabel!
    }
    
    
    
    
    
    var pickerView = UIPickerView(frame: CGRect(x: 10, y: 50, width: 250, height: 150))
    var CityArray : [CityObject] = []
    
    var cityTitle = ""
    var cityAction = ""
    var cityCancel = ""
    private func setupCitySelectionAlert() {
        if XLanguage.get() == .English{
            cityTitle = "Cities"
            cityAction = "Select"
            cityCancel = "Cancel"
        }else if XLanguage.get() == .Kurdish{
            cityTitle = "شارەکان"
            cityAction = "هەڵبژێرە"
            cityCancel = "هەڵوەشاندنەوە"
        }else{
            cityTitle = "مدن"
            cityAction = "تحديد"
            cityCancel = "إلغاء"
        }
        pickerView.delegate = self
        pickerView.dataSource = self
        let ac = UIAlertController(title: cityTitle, message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        ac.view.addSubview(pickerView)
        ac.addAction(UIAlertAction(title: cityAction , style: .default, handler: { [self] _ in
            if self.CityArray.count != 0{
                let pickerValue = self.CityArray[self.pickerView.selectedRow(inComponent: 0)]
                
                
                for _ in 0..<text.length{
                    text.replaceCharacters(in: NSMakeRange(0, text.length), with: "")
                    text.setAttributes([:], range: NSRange(0..<text.length))
                    //self.label.attributedText = text
                }
                
                
                print("text is : \(self.text)")
                if XLanguage.get() == .English{
                    self.location = "Location"
                    text.append(NSAttributedString(string: self.location, attributes: [.font : UIFont(name: "ArialRoundedMTBold", size: titleSize)!]))
                    CountryObjectAip.GeCountryById(id: pickerValue.country_id ?? "") { [self] country in
                        text.append(NSAttributedString(string: "\n\(country.name ?? "")-\(pickerValue.name ?? "")".uppercased(), attributes: [.font : UIFont(name: "ArialRoundedMTBold", size: subtitleSize)!]))
                        label.attributedText = text
                        self.navigationItem.titleView = label
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LocationChanged"), object: nil)
                    }
                }else if XLanguage.get() == .Kurdish{
                    self.location = "شوێن"
                    text.append(NSAttributedString(string: self.location, attributes: [.font : UIFont(name: "PeshangDes2", size: 12)!]))
                    CountryObjectAip.GeCountryById(id: pickerValue.country_id ?? "") { [self] country in
                        text.append(NSAttributedString(string: "\n\(country.ku_name ?? "")-\(pickerValue.ku_name ?? "")", attributes: [.font : UIFont(name: "PeshangDes2", size: subtitleSize)!]))
                        label.attributedText = text
                        self.navigationItem.titleView = label
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LocationChanged"), object: nil)
                    }
                }else{
                    self.location = "الموقع"
                    text.append(NSAttributedString(string: self.location, attributes: [.font : UIFont(name: "PeshangDes2", size: 12)!]))
                    CountryObjectAip.GeCountryById(id: pickerValue.country_id ?? "") { [self] country in
                        text.append(NSAttributedString(string: "\n\(country.ar_name ?? "")-\(pickerValue.ar_name ?? "")", attributes: [.font : UIFont(name: "PeshangDes2", size: subtitleSize)!]))
                        label.attributedText = text
                        self.navigationItem.titleView = label
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LocationChanged"), object: nil)
                    }
                }
                
                
                UserDefaults.standard.set(pickerValue.id, forKey: "CityId")
                UserDefaults.standard.set(pickerValue.country_id, forKey: "CountryId")
            }
        }))
        ac.addAction(UIAlertAction(title: cityCancel, style: .cancel, handler: nil))
        present(ac, animated: true)
    }
    
    func GetCity(){
        self.CityArray.removeAll()
        CityObjectAip.GetCities { city in
            self.CityArray = city
            self.pickerView.reloadAllComponents()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBOutlet weak var SliderView: FSPagerView!{
        didSet{
            self.SliderView.layer.masksToBounds = true
            self.SliderView.layer.cornerRadius = 10
            self.SliderView.automaticSlidingInterval = 4.0
            self.SliderView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.SliderView.transformer = FSPagerViewTransformer(type: .crossFading)
            self.SliderView.itemSize = FSPagerView.automaticSize
            self.GetSliderImages()
        }
    }
    
    var SearchArray : [EstateObject] = []
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        SearchArray = AllEstateArray.filter({ estate -> Bool in
            
                      let titleMatch = estate.name?.range(of: textField.text!, options: NSString.CompareOptions.caseInsensitive)
            
            return titleMatch != nil})
        
        
            self.SearchTableView.reloadData()
        return true
    }
    
    
    
    
    @IBOutlet weak var SearchTableView: UITableView!
    
    
    @IBOutlet weak var SearchView: UIView!
    @IBOutlet weak var SearchText: UITextField!
    @IBOutlet weak var ScrollView: UIScrollView!
    
      
   
    
    var EstatesType : [EstateTypeObject] = []
    var sliderImages : [SlidesObject] = []
    var ApartmentArray : [EstateObject] = []
    var AllEstateArray : [EstateObject] = []
    var NearArray : [EstateObject] = []
    
    
    let sectionInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
    var numberOfItemsPerRow: CGFloat = 2
    let spacingBetweenCells: CGFloat = 10
    
    
    
    @IBOutlet weak var AllEstatesCollectionLayout: NSLayoutConstraint!
    
    @IBOutlet weak var AllEstatesCollectionView: UICollectionView!
    @IBOutlet weak var ApartmentEstatesCollectionView: UICollectionView!
    @IBOutlet weak var NearYouCollectionView: UICollectionView!
    @IBOutlet weak var EstateTypeCollectionView: UICollectionView!
    
    var HistoryArray : [String] = []
    
    
    @IBOutlet weak var SearchViewRight: NSLayoutConstraint!
    
    @IBAction func Cancel(_ sender: Any) {
        self.view.endEditing(true)
        self.navigationItem.rightBarButtonItem?.isEnabled = true
       self.navigationItem.leftBarButtonItem?.isEnabled = true
        UIView.animate(withDuration: 0.2) {
            self.SearchTableView.alpha = 0
            self.SearchViewRight.constant = 10
            self.FilterLableWidth.constant = 0
            self.SearchText.text = ""
            self.ScrollView.isScrollEnabled = true
            self.view.layoutIfNeeded()
        }
    }
    
    
    var remoteConfig = RemoteConfig.remoteConfig()
    let settings = RemoteConfigSettings()
    func fetchRemoteConfig(){
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.fetch { (status, error) -> Void in
          if error == nil {
            print("Config fetched!")
            self.remoteConfig.activate { changed, error in
                self.IsUpdateAvaible()
            }
          } else {
            print("Config not fetched")
            print("Error: \(error?.localizedDescription ?? "No error available.")")
          }
        }
    }

    var titlee = ""
    var messagee = ""
    var Action = ""
    var cancel = ""
    func IsUpdateAvaible(){
        let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"]!
        let IsUpdateAvaiable = self.remoteConfig.configValue(forKey: "maskani_version").stringValue
        let IsAvaiable = self.remoteConfig.configValue(forKey: "IsAvaiable").boolValue
        
        print("old version is : V \(version)")
        print("new version is : V \(IsUpdateAvaiable ?? "")")
        if IsUpdateAvaiable != "\(version)" && IsAvaiable == true{
            DispatchQueue.main.async {
                if XLanguage.get() == .Kurdish{
                    self.titlee = "ئاگاداری"
                    self.messagee = "ئەپدەیتی نوێ بەردەستە"
                    self.Action = "نوێکردنەوە"
                    self.cancel = "ئێستا نا"
                }else if XLanguage.get() == . English{
                    self.titlee = "Warning"
                    self.messagee = "A new update is available"
                    self.Action = "Update"
                    self.cancel = "Not now"
                }else{
                    self.titlee = "تنبيه"
                    self.messagee = "يتوفر تحديث جديد"
                    self.Action = "تحديث"
                    self.cancel = "ليس الان"
                }
                let alertController = UIAlertController(title: self.titlee, message: self.messagee, preferredStyle: .alert)
                let okAction = UIAlertAction(title:  self.Action, style: UIAlertAction.Style.default) { _ in
                    if let url = URL(string: "https://apps.apple.com/us/app/maskani/id1602905831"),
                      UIApplication.shared.canOpenURL(url) {
                         if #available(iOS 10, *) {
                           UIApplication.shared.open(url, options: [:], completionHandler:nil)
                          } else {
                              UIApplication.shared.openURL(url)
                          }
                      } else { }
                }
                let cancelAction = UIAlertAction(title: self.cancel, style: UIAlertAction.Style.default) { UIAlertAction in  alertController.dismiss(animated: true)}
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    var Isupdated = false
    

    @IBOutlet weak var LoadingIndecator: UIActivityIndicatorView!
    
    var currentLocation: CLLocation?
    override func viewDidLoad() {
        super.viewDidLoad()
        GetCity()
        self.InternetViewHeight.constant = 0
        self.FilterLableWidth.constant = 0
        self.InternetConnectionView.isHidden = true
        fetchRemoteConfig()


        let yourBackImage = UIImage(named: "left-chevron")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        
        
        
        TitleSubTile()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        self.SearchText.delegate = self
        self.SearchView.layer.cornerRadius = 10
        self.SliderView.layer.cornerRadius = 10
        self.SearchText.delegate = self
        
        self.SearchTableView.register(UINib(nibName: "SearchHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        AllEstatesCollectionView.register(UINib(nibName: "AllEstatessCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AllCell")
        ApartmentEstatesCollectionView.register(UINib(nibName: "AllEstateCollectionView", bundle: nil), forCellWithReuseIdentifier: "ApartCell")
        NearYouCollectionView.register(UINib(nibName: "NearCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NearCell")
        EstateTypeCollectionView.register(UINib(nibName: "EstateTypeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        self.GetAllEstates()
        self.GetApartmentEstates()
        GetEstateType()

        if self.AllEstateArray.count == 0 && self.ApartmentArray.count == 0{
            self.ScrollView.isHidden = true
            self.LoadingIndecator.startAnimating()
        }
        
        
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() ==  .authorizedAlways{
            currentLocation = locManager.location
        }
        
        self.ScrollView.cr.addHeadRefresh(animator: FastAnimator()) {
            self.GetSliderImages()
            self.GetAllEstates()
            self.GetApartmentEstates()
            self.GetEstateType()
        }
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.LanguageChanged), name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReloadData), name: NSNotification.Name(rawValue: "EstateInserted"), object: nil)
    }
    @objc func ReloadData(){
        self.GetAllEstates()
        self.GetApartmentEstates()
    }
    
    @objc func LanguageChanged(){
        self.AllEstatesCollectionView.reloadData()
        self.ApartmentEstatesCollectionView.reloadData()
        self.NearYouCollectionView.reloadData()
        self.EstateTypeCollectionView.reloadData()
        self.TitleSubTile()
    }
    
    
    
    
    
        func GetSliderImages(){
            self.sliderImages.removeAll()
            SlidesAip.GetAllSlides { SlidesObject in
                self.sliderImages = SlidesObject
                self.SliderView.reloadData()
                self.ScrollView.cr.endHeaderRefresh()
            }
            
        }
    
    func GetEstateType(){
        self.EstatesType.removeAll()
        EstateTypeAip.GetEstateType { types in
            self.EstatesType = types
            self.EstateTypeCollectionView.reloadData()
            self.ScrollView.cr.endHeaderRefresh()
        }
    }

    
    @IBOutlet weak var GoToFavorites: UIBarButtonItem!
    @IBAction func GoToFavorites(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: "Login") == true {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let myVC = storyboard.instantiateViewController(withIdentifier: "ItemsVc") as! FavoritesVC
            if XLanguage.get() == .Kurdish{
                myVC.title = "خوازراوەکان"
            }else if XLanguage.get() == .Arabic{
                myVC.title = "العناصر المفضلة"
            }else{
                myVC.title = "FAVORITE ITEMS"
            }
            self.navigationController?.pushViewController(myVC, animated: true)
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVCViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBOutlet weak var GoToMyProfile: UIBarButtonItem!
    
    
    var Etitle = ""
    var Atitle = ""
    var Ktitle = ""
    var titleee = ""
    var message = ""
    @IBAction func GoToMyProfile(_ sender: Any) {
        if XLanguage.get() == .Kurdish{
            self.Etitle = "ئینگلیزی"
            self.Atitle = "عەرەبی"
            self.Ktitle = "کوردی"
            self.titleee = "گۆڕینی زمان"
            self.message = "زمان"
        }else if XLanguage.get() == .English{
            self.Etitle = "English"
            self.Atitle = "Arabic"
            self.Ktitle = "Kurdish"
            self.titleee = "Change Language"
            self.message = "Language"
        }else{
            self.Etitle = "إنجليزي"
            self.Atitle = "العربة"
            self.Ktitle = "الکردیة"
            self.titleee = "تغيير اللغة"
            self.message = "لغة"
        }
        
        let dialog = AZDialogViewController(title: titleee, message: message)
        dialog.titleColor = .black
        
        dialog.messageColor = .black
        
        dialog.alertBackgroundColor = .white
        
        dialog.dismissDirection = .bottom
        
        dialog.dismissWithOutsideTouch = true
        
        dialog.showSeparator = false
        
        dialog.separatorColor = UIColor.blue
        
        dialog.allowDragGesture = false
        
        dialog.rubberEnabled = true
        
        dialog.blurBackground = false
        
        dialog.blurEffectStyle = .light
        
        
        
        dialog.addAction(AZDialogAction(title: self.Ktitle) { (dialog) -> (Void) in
            self.Etitle = "ئینگلیزی"
            self.Atitle = "عەرەبی"
            self.Ktitle = "کوردی"
            self.titleee = "گۆڕینی زمان"
            self.message = "زمان"
            
            self.loadingLableMessage = "تكایه‌ چاوه‌ڕێبه‌..."
            self.LoadingView()
            XLanguage.set(Language: .Kurdish)
            
            UserDefaults.standard.set(1, forKey: "language")
            self.LanguageChanged()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)
            self.alert.dismiss(animated: true, completion: nil)
            dialog.dismiss()
        })
        
        dialog.addAction(AZDialogAction(title: self.Etitle) { (dialog) -> (Void) in
            self.Etitle = "English"
            self.Atitle = "Arabic"
            self.Ktitle = "Kurdish"
            self.titleee = "Change Language"
            self.message = "Language"
            
            self.loadingLableMessage = "Please wait..."
            self.LoadingView()
            XLanguage.set(Language: .English)
            UserDefaults.standard.set(2, forKey: "language")
            self.LanguageChanged()
            self.alert.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)
            dialog.dismiss()
        })
        
        dialog.addAction(AZDialogAction(title: self.Atitle) { (dialog) -> (Void) in
            self.Etitle = "إنجليزي"
            self.Atitle = "العربة"
            self.Ktitle = "الکردیة"
            self.titleee = "تغيير اللغة"
            self.message = "لغة"
            self.loadingLableMessage = "يرجى الانتظار..."
            self.LoadingView()
            XLanguage.set(Language: .Arabic)
            self.LanguageChanged()
            UserDefaults.standard.set(3, forKey: "language")
            self.alert.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)
            dialog.dismiss()
        })
        
        self.present(dialog, animated: false, completion: nil)
        
    }
    
    
    
    var alert = UIAlertController()
    var loadingLableMessage = ""
    func LoadingView(){
        alert = UIAlertController(title: nil, message: self.loadingLableMessage, preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    

    func getNearestPoints(array: [CLLocationCoordinate2D], currentLocation: CLLocationCoordinate2D) -> [CLLocationCoordinate2D]{
        let current = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        var dictArray = [[String: Any]]()
        for i in 0..<array.count{
            let loc = CLLocation(latitude: array[i].latitude, longitude: array[i].longitude)
            let distanceInMeters = current.distance(from: loc)
            let a:[String: Any] = ["distance": distanceInMeters, "coordinate": array[i]]
            dictArray.append(a)
        }
        
        dictArray = dictArray.sorted(by: {($0["distance"] as! CLLocationDistance) < ($1["distance"] as! CLLocationDistance)})
        var sortedArray = [CLLocationCoordinate2D]()
        for i in dictArray{
            sortedArray.append(i["coordinate"] as! CLLocationCoordinate2D)
        }
        return sortedArray
    }
    
    
    
    func GetAllEstates(){
        self.LocationdsArray.removeAll()
        self.NearArray.removeAll()
        self.AllEstateArray.removeAll()
        ProductAip.GetAllProducts { Product in
            for UnArchived in Product{
                if UnArchived.archived != "1"{
                   self.AllEstateArray.append(UnArchived)
                }
            }
            
            
            for product in self.AllEstateArray{
                let dbLat = Double(product.lat ?? "")
                let dbLong = Double(product.long ?? "")
                self.LocationdsArray.append(CLLocationCoordinate2D(latitude: dbLat!, longitude:dbLong!))
            }
            self.ClosestArray = self.getNearestPoints(array: self.LocationdsArray, currentLocation: self.currentLocation?.coordinate ?? CLLocationCoordinate2D())
            for loc in self.ClosestArray{
                for (j,_) in self.AllEstateArray.enumerated(){
                    if loc.latitude == Double(self.AllEstateArray[j].lat ?? "") &&  loc.longitude == Double(self.AllEstateArray[j].long ?? ""){
                        self.NearArray.append(self.AllEstateArray[j])
                    }
                }
            }
            
 
            self.AllEstateArray.shuffle()



            self.ScrollView.isHidden = false
            self.LoadingIndecator.stopAnimating()
            self.NearYouCollectionView.reloadData()
            self.AllEstatesCollectionView.reloadData()
        }
    }
    
    
    @IBAction func SeeAllNearEstatets(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myVC = storyboard.instantiateViewController(withIdentifier: "AllEstateVC") as! AllEstateVC
        myVC.AllEstate = self.NearArray
        if XLanguage.get() == .English{
            myVC.title = "Near you"
        }else if XLanguage.get() == .Kurdish{
            myVC.title = "بالقرب منك"
        }else{
            myVC.title = "نزیک لە تۆ"
        }
        self.navigationController?.pushViewController(myVC, animated: true)
    }
    
    
    @IBAction func SeeAllApartments(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myVC = storyboard.instantiateViewController(withIdentifier: "AllEstateVC") as! AllEstateVC
        myVC.AllEstate = self.ApartmentArray
        if XLanguage.get() == .English{
            myVC.title = "Apartments"
        }else if XLanguage.get() == .Kurdish{
            myVC.title = "شوقەکان"
        }else{
            myVC.title = "شقق"
        }
        self.navigationController?.pushViewController(myVC, animated: true)
    }
    
    
    
    
    
    var LocationdsArray : [CLLocationCoordinate2D] = []
    var ClosestArray : [CLLocationCoordinate2D] = []

    
    
    
    func GetApartmentEstates(){
        self.ApartmentArray.removeAll()
        
        ProductAip.GetAllSectionProducts(TypeId: "UTY25FYJHkliygt4nvPP") { estate in
                if estate.archived != "1"{
                   self.ApartmentArray.append(estate)
                }
            self.ApartmentArray.shuffle()
            self.ScrollView.isHidden = false
            self.LoadingIndecator.stopAnimating()
            self.ApartmentEstatesCollectionView.reloadData()
        }
        
    }
    
    

    @IBOutlet weak var FilterLableWidth: NSLayoutConstraint!
    @IBOutlet weak var FilterLable: LanguageLable!
    var IsFirst = true
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
           self.navigationItem.leftBarButtonItem?.isEnabled = false
            self.IsFirst = !self.IsFirst
            UIView.animate(withDuration: 0.2) {
                self.ScrollView.scrollToTop()
                self.SearchTableView.alpha = 1
                self.SearchViewRight.constant = 85
                self.FilterLableWidth.constant = 40
                self.ScrollView.isScrollEnabled = false
                self.view.layoutIfNeeded()
            }
        return true
    }
    
    
    var IsInternetChecked = false
    @IBOutlet weak var InternetViewHeight: NSLayoutConstraint!
    @IBOutlet weak var InternetConnectionView: UIView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let officeId = UserDefaults.standard.string(forKey: "OfficeId"){
            OfficeAip.GetOffice(ID: officeId) {office in
                if office.type_id != "h9nFfUrHgSwIg17uRwTD"{
                    self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.isEnabled = false
                }else{
                    self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.isEnabled = true
                }
            }
        }
        
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
       
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(EstateVCDismissed), name:  NSNotification.Name(rawValue: "EstateVCDismissed"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LocationChangedS), name: NSNotification.Name(rawValue: "LocationChangedS"), object: nil)
    }
    
    @objc func EstateVCDismissed(){
        print(self.SearchTableView.alpha)
        print("dshjdjshkhkjhksjhdkjhskdj")
        if self.SearchTableView.alpha == 1.0{print("[][][][][")
        self.SearchText.becomeFirstResponder()
        }
    }
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    var lang : Int = UserDefaults.standard.integer(forKey: "language")
    var location = ""
    let rect = CGRect(x: 0, y: 0, width: 400, height: 50)
    let titleSize: CGFloat = 10
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
    let subtitleSize: CGFloat = 13
    let text = NSMutableAttributedString()
    func TitleSubTile(){
        
        
       
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .darkGray
        
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.titleWasTapped))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(recognizer)
       
        for _ in 0..<text.length{
            text.replaceCharacters(in: NSMakeRange(0, text.length), with: "")
            text.setAttributes([:], range: NSRange(0..<text.length))
        }
        
        
        if XLanguage.get() == .English{
            self.location = "Location"
            text.append(NSAttributedString(string: self.location, attributes: [.font : UIFont(name: "ArialRoundedMTBold", size: titleSize)!]))
            if let cityId = UserDefaults.standard.string(forKey: "CityId"){
            CityObjectAip.GetCities { cities in
                    for city in cities {
                        if city.id == cityId{
                            CountryObjectAip.GeCountryById(id: city.country_id ?? "") { [self] country in
                                text.append(NSAttributedString(string: "\n\(country.name ?? "")-\(city.name ?? "")".uppercased(), attributes: [.font : UIFont(name: "ArialRoundedMTBold", size: subtitleSize)!]))
                                label.attributedText = text
                                self.navigationItem.titleView = label
                            }
                        }
                    }
                }
            }
        }else if XLanguage.get() == .Kurdish{
            self.location = "شوێن"
            text.append(NSAttributedString(string: self.location, attributes: [.font : UIFont(name: "PeshangDes2", size: 12)!]))
            
                if let cityId = UserDefaults.standard.string(forKey: "CityId"){
            CityObjectAip.GetCities { cities in
                    for city in cities {
                        if city.id == cityId{
                            CountryObjectAip.GeCountryById(id: city.country_id ?? "") { [self] country in
                                text.append(NSAttributedString(string: "\n\(country.ku_name ?? "")-\(city.ku_name ?? "")", attributes: [.font : UIFont(name: "PeshangDes2", size: subtitleSize)!]))
                                label.attributedText = text
                                self.navigationItem.titleView = label
                            }
                        }
                    }
                }
            }
        }else{
            self.location = "الموقع"
            text.append(NSAttributedString(string: self.location, attributes: [.font : UIFont(name: "PeshangDes2", size: 12)!]))
            if let cityId = UserDefaults.standard.string(forKey: "CityId"){
            CityObjectAip.GetCities { cities in
                    for city in cities {
                        if city.id == cityId{
                            CountryObjectAip.GeCountryById(id: city.country_id ?? "") { [self] country in
                                text.append(NSAttributedString(string: "\n\(country.ar_name ?? "")-\(city.ar_name ?? "")", attributes: [.font : UIFont(name: "PeshangDes2", size: subtitleSize)!]))
                                label.attributedText = text
                                self.navigationItem.titleView = label
                                print(text)
                            }
                        }
                    }
                }
            }
        }
        
        
    }
    
    
    
    
    @objc func LocationChangedS(){
        
         for _ in 0..<text.length{
             text.replaceCharacters(in: NSMakeRange(0, text.length), with: "")
             text.setAttributes([:], range: NSRange(0..<text.length))
         }
         
         
         if XLanguage.get() == .English{
             self.location = "Location"
             text.append(NSAttributedString(string: self.location, attributes: [.font : UIFont(name: "ArialRoundedMTBold", size: titleSize)!]))
             if let cityId = UserDefaults.standard.string(forKey: "CityId"){
             CityObjectAip.GetCities { cities in
                     for city in cities {
                         if city.id == cityId{
                             CountryObjectAip.GeCountryById(id: city.country_id ?? "") { [self] country in
                                 text.append(NSAttributedString(string: "\n\(country.name ?? "")-\(city.name ?? "")".uppercased(), attributes: [.font : UIFont(name: "ArialRoundedMTBold", size: subtitleSize)!]))
                                 label.attributedText = text
                                 self.navigationItem.titleView = label
                             }
                         }
                     }
                 }
             }
         }else if XLanguage.get() == .Kurdish{
             self.location = "شوێن"
             text.append(NSAttributedString(string: self.location, attributes: [.font : UIFont(name: "PeshangDes2", size: 12)!]))
             
                 if let cityId = UserDefaults.standard.string(forKey: "CityId"){
             CityObjectAip.GetCities { cities in
                     for city in cities {
                         if city.id == cityId{
                             CountryObjectAip.GeCountryById(id: city.country_id ?? "") { [self] country in
                                 text.append(NSAttributedString(string: "\n\(country.ku_name ?? "")-\(city.ku_name ?? "")", attributes: [.font : UIFont(name: "PeshangDes2", size: subtitleSize)!]))
                                 label.attributedText = text
                                 self.navigationItem.titleView = label
                             }
                         }
                     }
                 }
             }
         }else{
             self.location = "الموقع"
             text.append(NSAttributedString(string: self.location, attributes: [.font : UIFont(name: "PeshangDes2", size: 12)!]))
             if let cityId = UserDefaults.standard.string(forKey: "CityId"){
             CityObjectAip.GetCities { cities in
                     for city in cities {
                         if city.id == cityId{
                             CountryObjectAip.GeCountryById(id: city.country_id ?? "") { [self] country in
                                 text.append(NSAttributedString(string: "\n\(country.ar_name ?? "")-\(city.ar_name ?? "")", attributes: [.font : UIFont(name: "PeshangDes2", size: subtitleSize)!]))
                                 label.attributedText = text
                                 self.navigationItem.titleView = label
                             }
                         }
                     }
                 }
             }
         }
         
         
    }
    
    
    
    
    
    @objc private func titleWasTapped() {
        self.setupCitySelectionAlert()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let height = self.AllEstatesCollectionView.collectionViewLayout.collectionViewContentSize.height
                self.AllEstatesCollectionLayout.constant = height
            }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let estate = sender as? EstateObject{
            if let next = segue.destination as? EstateProfileVc{
                next.CommingEstate = estate
            }
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




extension Home : UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == EstateTypeCollectionView{
            if EstatesType.count == 0 {
                return 0
            }else{
                return EstatesType.count
            }
        }
        
        if collectionView == ApartmentEstatesCollectionView{
            if ApartmentArray.count == 0{
                return 0
            }else if ApartmentArray.count >= 10{
                return 10
            }else{
                return ApartmentArray.count
            }
        }
        
        if collectionView == NearYouCollectionView{
            if NearArray.count == 0{
                return 0
            }else if NearArray.count >= 10{
                return 10
            }else{
                return NearArray.count
            }
        }
        
        if collectionView == AllEstatesCollectionView{
            if AllEstateArray.count == 0{
                return 0
            }
            return AllEstateArray.count
        }
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == EstateTypeCollectionView{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EstateTypeCollectionViewCell
        if self.EstatesType.count != 0{
            cell.Vieww.backgroundColor = .white
            cell.Name.textColor = #colorLiteral(red: 0.4430069923, green: 0.4869378209, blue: 0.5339931846, alpha: 1)
            if XLanguage.get() == .English{
                cell.Name.text = EstatesType[indexPath.row].name
                cell.Name.font =  UIFont(name: "ArialRoundedMTBold", size: 11)!
            }else if XLanguage.get() == .Arabic{
                cell.Name.text = EstatesType[indexPath.row].ar_name
                cell.Name.font =  UIFont(name: "PeshangDes2", size: 12)!
            }else{
                cell.Name.text = EstatesType[indexPath.row].ku_name
                cell.Name.font =  UIFont(name: "PeshangDes2", size: 12)!
            }
        }
        return cell
        }
        
        if collectionView == ApartmentEstatesCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ApartCell", for: indexPath) as! AllEstateCollectionView
            cell.update(self.ApartmentArray[indexPath.row])
            return cell
        }
        
        if collectionView == NearYouCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NearCell", for: indexPath) as! NearCollectionViewCell    
            cell.update(self.NearArray[indexPath.row])
            return cell
        }
        
        
        if collectionView == AllEstatesCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllCell", for: indexPath) as! AllEstatessCollectionViewCell
            cell.update(self.AllEstateArray[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == AllEstatesCollectionView{
            let totalSpacing = (2 * sectionInsets.left) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
            let width = (collectionView.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: 250)
        }
        
        
        
        if collectionView == EstateTypeCollectionView{
            return CGSize(width: collectionView.frame.size.width / 4, height: 40)
        }
        
        if collectionView == ApartmentEstatesCollectionView{
            return CGSize(width: collectionView.frame.size.width / 1.06, height: 120)
        }
        
        if collectionView == NearYouCollectionView{
            return CGSize(width: collectionView.frame.size.width / 1.7, height: 290)
        }
        
        
        return CGSize()
    }

    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         if collectionView == EstateTypeCollectionView{
         return 5
         }
         if collectionView == ApartmentEstatesCollectionView{
             return 10
         }
         
         if collectionView == NearYouCollectionView{
             return 10
         }
         
         if collectionView == AllEstatesCollectionView{
             return spacingBetweenCells
         }
         return CGFloat()
     }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == EstateTypeCollectionView{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let myVC = storyboard.instantiateViewController(withIdentifier: "AllEstateVC") as! AllEstateVC
            myVC.EstateType = self.EstatesType[indexPath.row].id ?? ""
            if XLanguage.get() == .English{
            myVC.title = self.EstatesType[indexPath.row].name ?? ""
            }else if XLanguage.get() == .Arabic{
                myVC.title = self.EstatesType[indexPath.row].ar_name ?? ""
            }else{
                myVC.title = self.EstatesType[indexPath.row].ku_name ?? ""
            }
            self.navigationController?.pushViewController(myVC, animated: true)
        }
        if collectionView == ApartmentEstatesCollectionView{
            if ApartmentArray.count != 0 && indexPath.row <= ApartmentArray.count{
            InsertViewdItem(id : self.ApartmentArray[indexPath.row].id ?? "")
            self.performSegue(withIdentifier: "Next", sender: self.ApartmentArray[indexPath.row])
            }
        }
        
        if collectionView == NearYouCollectionView{
            if self.NearArray.count != 0 && indexPath.row <= self.NearArray.count{
                InsertViewdItem(id : self.NearArray[indexPath.row].id ?? "")
              self.performSegue(withIdentifier: "Next", sender: NearArray[indexPath.row])
            }
        }
        
        if collectionView == AllEstatesCollectionView{
            if self.AllEstateArray.count != 0 && indexPath.row <= self.AllEstateArray.count{
                InsertViewdItem(id : self.AllEstateArray[indexPath.row].id ?? "")
              self.performSegue(withIdentifier: "Next", sender: AllEstateArray[indexPath.row])
            }
        }
    }
    
    

    
}








extension Home: FSPagerViewDataSource,FSPagerViewDelegate {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        if sliderImages.count == 0{
            return 0
        }
        return sliderImages.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        if sliderImages.count != 0{
        let urlString = sliderImages[index].image
        let url = URL(string: urlString ?? "")
        cell.imageView?.sd_setImage(with: url, completed: nil)
        cell.imageView?.contentMode = .scaleToFill
        cell.imageView?.clipsToBounds = true
        cell.imageView?.layer.cornerRadius = 10
        }
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        if sliderImages.count != 0{
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
            
            if let url = NSURL(string: sliderImages[index].link ?? ""){
                UIApplication.shared.open(url as URL)
            }
        }
    }

}




extension Home : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if SearchArray.count == 0{
            return 0
        }
        return SearchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SearchHistoryTableViewCell
              cell.Name.text = SearchArray[indexPath.row].name
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "Next", sender: SearchArray[indexPath.row])
    }
}



extension Array {

// Non-mutating shuffle
    var shuffled : Array {
        let totalCount : Int = self.count
        var shuffledArray : Array = []
        var count : Int = totalCount
        var tempArray : Array = self
        for _ in 0..<totalCount {
            let randomIndex : Int = Int(arc4random_uniform(UInt32(count)))
            let randomElement : Element = tempArray.remove(at: randomIndex)
            shuffledArray.append(randomElement)
            count -= 1
        }
        return shuffledArray
    }

// Mutating shuffle
    mutating func shuffle() {
        let totalCount : Int = self.count
        var shuffledArray : Array = []
        var count : Int = totalCount
        var tempArray : Array = self
        for _ in 0..<totalCount {
            let randomIndex : Int = Int(arc4random_uniform(UInt32(count)))
            let randomElement : Element = tempArray.remove(at: randomIndex)
            shuffledArray.append(randomElement)
            count -= 1
        }
        self = shuffledArray
    }
}
extension UIScrollView {
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
   }
}
