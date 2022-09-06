//
//  Settings.swift
//  RealEstates
//
//  Created by botan pro on 4/16/21.
//

import UIKit
import Firebase
import FirebaseAuth
import AZDialogView
import SDWebImage
import SwiftyJSON
import AAShimmerView
import ShimmerLabel
import FlipLabel
import Drops
class Settings: UIViewController ,UIPickerViewDelegate , UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CityArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        UserDefaults.standard.set(self.CityArray[row].name, forKey: "CityName")
//        self.Location.text = "\("IRAQ-\(self.CityArray[row].name ?? "")")".uppercased()
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
    
    
    
    
    @IBAction func SharkTeam(_ sender: Any) {
        if let url = NSURL(string: "http://www.shark-team.com"){
            UIApplication.shared.open(url as URL)
        }
    }
    
    
    //    @IBAction func Logout(_ sender: Any) {
    //        if UserDefaults.standard.bool(forKey: "Login") == true{
    //            let myAlert = UIAlertController(title: "Logout?", message: nil, preferredStyle: UIAlertController.Style.alert)
    //            myAlert.addAction(UIAlertAction(title: "Ok", style:  UIAlertAction.Style.default, handler: { _ in
    //                let firebaseAuth = Auth.auth()
    //                do {
    //                    try firebaseAuth.signOut()
    //                    UserDefaults.standard.set(false, forKey: "Login")
    //                    UserDefaults.standard.set("", forKey: "UserId")
    //
    //                    self.LangChanged()
    //                } catch let signOutError as NSError {
    //                    print ("Error signing out: %@", signOutError)
    //                }
    //            }))
    //
    //
    //            myAlert.addAction(UIAlertAction(title: "No", style:  UIAlertAction.Style.cancel, handler: nil))
    //            self.present(myAlert, animated: true, completion: nil)
    //        }
    //    }
    
    
    
    var Etitle = ""
    var Atitle = ""
    var Ktitle = ""
    var titlee = ""
    var message = ""
    @IBOutlet weak var LanguageLable: UILabel!
    @IBAction func ChangLang(_ sender: Any) {
        let dialog = AZDialogViewController(title: titlee, message: message)
        dialog.titleColor = .black
        
        //set the message color
        dialog.messageColor = .black
        
        //set the dialog background color
        dialog.alertBackgroundColor = .white
        
        //set the gesture dismiss direction
        dialog.dismissDirection = .bottom
        
        //allow dismiss by touching the background
        dialog.dismissWithOutsideTouch = true
        
        //show seperator under the title
        dialog.showSeparator = false
        
        //set the seperator color
        dialog.separatorColor = UIColor.blue
        
        //enable/disable drag
        dialog.allowDragGesture = false
        
        //enable rubber (bounce) effect
        dialog.rubberEnabled = true
        
        //enable/disable backgroud blur
        dialog.blurBackground = false
        
        //set the background blur style
        dialog.blurEffectStyle = .light
        
        
        
        dialog.addAction(AZDialogAction(title: self.Ktitle) { (dialog) -> (Void) in
            self.Etitle = "ئینگلیزی"
            self.Atitle = "عەرەبی"
            self.Ktitle = "کوردی"
            self.titlee = "گۆڕینی زمان"
            self.message = "زمان"
            self.LanguageLable.text = self.Ktitle
            self.LanguageLable.font =  UIFont(name: "PeshangDes2", size: 11)!
            
            self.loadingLableMessage = "تكایه‌ چاوه‌ڕێبه‌..."
            self.LoadingView()
            XLanguage.set(Language: .Kurdish)
            self.LanguageLable.text = self.Ktitle
            UserDefaults.standard.set(1, forKey: "language")
            self.LangChanged()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)
            self.alert.dismiss(animated: true, completion: nil)
            dialog.dismiss()
        })
        
        dialog.addAction(AZDialogAction(title: self.Etitle) { (dialog) -> (Void) in
            self.Etitle = "English"
            self.Atitle = "Arabic"
            self.Ktitle = "Kurdish"
            self.titlee = "Change Language"
            self.message = "Language"
            self.LanguageLable.text = self.Etitle
            self.LanguageLable.font =  UIFont(name: "ArialRoundedMTBold", size: 11)!
            
            self.loadingLableMessage = "Please wait..."
            self.LoadingView()
            XLanguage.set(Language: .English)
            self.LanguageLable.text = self.Etitle
            UserDefaults.standard.set(2, forKey: "language")
            self.LangChanged()
            self.alert.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)
            dialog.dismiss()
        })
        
        dialog.addAction(AZDialogAction(title: self.Atitle) { (dialog) -> (Void) in
            self.Etitle = "إنجليزي"
            self.Atitle = "العربة"
            self.Ktitle = "الکردیة"
            self.titlee = "تغيير اللغة"
            self.message = "لغة"
            self.LanguageLable.text = self.Atitle
            self.LanguageLable.font =  UIFont(name: "PeshangDes2", size: 11)!
            self.loadingLableMessage = "يرجى الانتظار..."
            self.LoadingView()
            XLanguage.set(Language: .Arabic)
            self.LanguageLable.text = self.Atitle
            UserDefaults.standard.set(3, forKey: "language")
            self.LangChanged()
            self.alert.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)
            dialog.dismiss()
        })
        
        self.present(dialog, animated: false, completion: nil)
    }
    
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Phone: UILabel!
    @IBOutlet weak var Image: UIImageView!
    
    
    
  
    
    @IBOutlet weak var NotificationLable: UILabel!
    
    @IBAction func Notification(_ sender: Any) {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                if XLanguage.get() == .English{
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "ON"
                        self.NotificationLable.font =  UIFont(name: "ArialRoundedMTBold", size: 11)!
                    }
                }else if XLanguage.get() == .Kurdish{
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "چالاک کراوە"
                        self.NotificationLable.font =  UIFont(name: "PeshangDes2", size: 11)!
                    }
                }else{
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "مفعلة"
                        self.NotificationLable.font =  UIFont(name: "PeshangDes2", size: 11)!
                    }
                }
            }
            else {
                if XLanguage.get() == .English{
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "OFF"
                        self.NotificationLable.font =  UIFont(name: "ArialRoundedMTBold", size: 11)!
                    }
                }else if XLanguage.get() == .Kurdish{
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "چالاک کراوە نیە"
                        self.NotificationLable.font =  UIFont(name: "PeshangDes2", size: 11)!
                    }
                }else{
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "غیر مفعلة"
                        self.NotificationLable.font =  UIFont(name: "PeshangDes2", size: 11)!
                    }
                }
            }
        }
        
    }
    
    
    
    
    
    
    
    
    
    @IBAction func Fav(_ sender: Any) {
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
        }
    }
    
    @IBAction func ViewdItem(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: "Login") == true {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let myVC = storyboard.instantiateViewController(withIdentifier: "ViewdItemsVc") as! ViewdVC

            self.navigationController?.pushViewController(myVC, animated: true)
        }
    }
    
    
    
    @IBAction func AboutUs(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myVC = storyboard.instantiateViewController(withIdentifier: "AboutUsVc") as! AboutrVC
        self.navigationController?.pushViewController(myVC, animated: true)
    }
    
    
    @IBAction func CntactUs(_ sender: Any) {
        self.dialNumber(phoneNumber: "+9647514505411")
    }
    
    func dialNumber(phoneNumber : String) {

     if let url = URL(string: "tel://\(phoneNumber)"),
       UIApplication.shared.canOpenURL(url) {
          if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler:nil)
           } else {print("ppp[p[][p][p][p][p][p00000")
               UIApplication.shared.openURL(url)
           }
       } else {print("ppp[p[][p][p][p][p][p")
                // add error message here
       }
    }
    
    @IBOutlet var FavoriteItemAction: UITapGestureRecognizer!
    @IBOutlet var MyPropertiesAction: UITapGestureRecognizer!
    @IBOutlet var AddPropetiesAction: UITapGestureRecognizer!
    @IBOutlet var ViewdItemAction: UITapGestureRecognizer!
    
    @IBOutlet weak var ViewditemView: UIView!
    
    @IBOutlet weak var ViewPropertyVicew: UIView!
    @IBOutlet weak var AddPropertyView: UIView!
    
    @IBOutlet weak var ProfileInfoStackViewLayout: NSLayoutConstraint!
    @IBOutlet weak var ProfileInfoStackView: UIStackView!
    
    @IBOutlet weak var VersionNumber: UILabel!
    @IBOutlet weak var LoginOrLogoutLable: UILabel!
    @IBOutlet weak var LoginImage: UIImageView!
    
    @IBOutlet weak var FavoriteItems: UILabel!
    @IBOutlet weak var ViewdItems: UILabel!
    
    
    
    @IBOutlet weak var SubscriptionView             : UIView!
    @IBOutlet weak var SubscriptionDays             : UILabel!
    @IBOutlet weak var SubscriptionPosts            : UILabel!
    @IBOutlet weak var StartDate                    : UILabel!
    @IBOutlet weak var EndDate                      : UILabel!
    @IBOutlet weak var SubscriptionViewHeightLyout  : NSLayoutConstraint!
    @IBOutlet weak var SubscriptionViewTopLyout     : NSLayoutConstraint!
    @IBOutlet weak var SubscriptionViewBottomLyout  : NSLayoutConstraint!
    
    
    
    
    @IBOutlet weak var NavTitle: LanguageBarItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.AddPropertyView.alpha = 0.5
        self.ViewPropertyVicew.alpha = 0.5
        self.MyPropertiesAction.isEnabled = false
        self.AddPropetiesAction.isEnabled = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)]

        let yourBackImage = UIImage(named: "left-chevron")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        
        
        if XLanguage.get() == .Kurdish{
            self.Etitle = "ئینگلیزی"
            self.Atitle = "عەرەبی"
            self.Ktitle = "کوردی"
            self.titlee = "گۆڕینی زمان"
            self.message = "زمان"
            self.LanguageLable.text = self.Ktitle
            self.LanguageLable.font =  UIFont(name: "PeshangDes2", size: 11)!
        }else if XLanguage.get() == .English{
            self.Etitle = "English"
            self.Atitle = "Arabic"
            self.Ktitle = "Kurdish"
            self.titlee = "Change Language"
            self.message = "Language"
            self.LanguageLable.text = self.Etitle
            self.LanguageLable.font =  UIFont(name: "ArialRoundedMTBold", size: 11)!
        }else{
            self.Etitle = "إنجليزي"
            self.Atitle = "العربة"
            self.Ktitle = "الکردیة"
            self.titlee = "تغيير اللغة"
            self.message = "لغة"
            self.LanguageLable.text = self.Atitle
            self.LanguageLable.font =  UIFont(name: "PeshangDes2", size: 11)!
        }
        
        
        
        
        if XLanguage.get() == .English{
            if let cityId = UserDefaults.standard.string(forKey: "CityId"){
            CityObjectAip.GetCities { cities in
                    for city in cities {
                        if city.id == cityId{
                            CountryObjectAip.GeCountryById(id: city.country_id ?? "") { country in
                                self.Location.text = "\(country.name ?? "")-\(city.name ?? "")".uppercased()
                                self.Location.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
                            }
                        }
                    }
                }
            }
        }else if XLanguage.get() == .Arabic{
            if let cityId = UserDefaults.standard.string(forKey: "CityId"){
            CityObjectAip.GetCities { cities in
                    for city in cities {
                        if city.id == cityId{
                            CountryObjectAip.GeCountryById(id: city.country_id ?? "") { country in
                                self.Location.text = "\(country.ar_name ?? "")-\(city.ar_name ?? "")".uppercased()
                                self.Location.font = UIFont(name: "PeshangDes2", size: 11)!
                            }
                        }
                    }
                }
            }
        }else{
            if let cityId = UserDefaults.standard.string(forKey: "CityId"){
            CityObjectAip.GetCities { cities in
                    for city in cities {
                        if city.id == cityId{
                            CountryObjectAip.GeCountryById(id: city.country_id ?? "") { country in
                                self.Location.text = "\(country.ku_name ?? "")-\(city.ku_name ?? "")".uppercased()
                                self.Location.font = UIFont(name: "PeshangDes2", size: 11)!
                            }
                        }
                    }
                }
            }
        }
        
        
        
        
        
        self.SubscriptionView.isHidden             = true
        self.SubscriptionViewHeightLyout.constant  = 0
        self.SubscriptionViewTopLyout.constant     = 0
        self.SubscriptionViewBottomLyout.constant  = 0
        
        
        
        self.EditProfile.isEnabled = true
        self.GetYATop.constant = 0
        self.GetYABottom.constant = 12
        self.GetYAHeight.constant = 0
        self.GetYAView.isHidden = true
        self.AddPropertyView.isHidden = false
        self.ViewPropertyVicew.isHidden = false
        self.ProfileRightImage.isHidden = false
        ProductAip.GetAllProducts { estate in
            self.AllEstate = estate
        }
        self.Image.layer.cornerRadius = self.Image.bounds.width / 2
     
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.LocationChanged), name: NSNotification.Name(rawValue: "LocationChanged"), object: nil)
    }
    
    
    

    
    
    var IsSubscriptionAlertShowed = false
    
    @IBAction func GetYAAction(_ sender: Any) {
        self.dialNumber(phoneNumber: "+9647514505411")
    }
    
    
    
    
    @IBOutlet weak var GetYATop   : NSLayoutConstraint!
    @IBOutlet weak var GetYABottom: NSLayoutConstraint!
    @IBOutlet weak var GetYAHeight: NSLayoutConstraint!
    @IBOutlet weak var GetYAView  : UIView!
    
    @IBOutlet var EditProfile: UITapGestureRecognizer!
    
    @IBOutlet weak var GetYA: UILabel!
    @IBOutlet weak var FavoriteItemsView: UIView!
    var ViewdItemCount = 0
    var FavoriteItemCount = 0
    var ViewdItemsEstate : [EstateObject] = []
    var FavoriteItemsEstate : [EstateObject] = []
    var label = ShimmerLabel()
    
    @IBOutlet weak var Profileimageheight: NSLayoutConstraint!
    var lang : Int = UserDefaults.standard.integer(forKey: "language")
    var AllEstate : [EstateObject] = []
    
    
    var MyEstates : [EstateObject] = []
    func GetMyEstates(){
        self.MyEstates.removeAll()
        if let FireId = UserDefaults.standard.string(forKey: "UserId"){
            OfficeAip.GetOfficeById(Id: FireId) { office in
                ProductAip.GetMyEstates(office_id: office.id ?? "") { estates in
                    self.MyEstates.append(estates)
                }
            }
        }
    }

    @IBOutlet weak var ProfileRightImage: UIImageView!
    
    
    let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"]!
    var days = 0
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
        
       
        
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                
                if XLanguage.get() == .English{
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "ON"
                        self.NotificationLable.font =  UIFont(name: "ArialRoundedMTBold", size: 11)!
                    }
                }else if XLanguage.get() == .Kurdish{
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "چالاک کراوە"
                        self.NotificationLable.font =  UIFont(name: "PeshangDes2", size: 11)!
                    }
                }else{
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "مفعّلة"
                        self.NotificationLable.font =  UIFont(name: "PeshangDes2", size: 11)!
                    }
                }
            }
            else {
                if XLanguage.get() == .English{
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "OFF"
                        self.NotificationLable.font =  UIFont(name: "ArialRoundedMTBold", size: 11)!
                    }
                }else if XLanguage.get() == .Kurdish{
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "چالاک کراوە نیە"
                        self.NotificationLable.font =  UIFont(name: "PeshangDes2", size: 11)!
                    }
                }else{
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "غیر مفعلة"
                        self.NotificationLable.font =  UIFont(name: "PeshangDes2", size: 11)!
                    }
                }
            }
        }
        
        
        

        
        self.VersionNumber.text = "V \(version)"
        self.VersionNumber.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
        self.ViewdItemsEstate.removeAll()
        self.FavoriteItemsEstate.removeAll()
        self.FavoriteItemCount = 0
        self.ViewdItemCount = 0
        
        
        if XLanguage.get() == .English{
            //self.Location.text = UserDefaults.standard.string(forKey: "CityName")?.uppercased() ?? ""
            self.Location.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
        }else if XLanguage.get() == .Kurdish{
            //self.Location.text = UserDefaults.standard.string(forKey: "CityName")?.uppercased() ?? ""
            self.Location.font = UIFont(name: "PeshangDes2", size: 11)!
        }else{
            //self.Location.text = UserDefaults.standard.string(forKey: "CityName")?.uppercased() ?? ""
            self.Location.font = UIFont(name: "PeshangDes2", size: 10)!
        }
        
        GetCity()
        if UserDefaults.standard.bool(forKey: "Login") == false {print("is not-----------------")
            if XLanguage.get() == .Kurdish{
                self.LoginOrLogoutLable.text = "چونه‌ ژووره‌وه‌"
                self.LoginOrLogoutLable.font = UIFont(name: "PeshangDes2", size: 14)!
            }else if XLanguage.get() == .English{
                self.LoginOrLogoutLable.text = "LOGIN"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            }else{
                self.LoginOrLogoutLable.text = "تسجيل الدخول"
                self.LoginOrLogoutLable.font = UIFont(name: "PeshangDes2", size: 14)!
            }
            self.LoginImage.image = UIImage(named: "vuesax-bold-login")
            self.ProfileInfoStackView.isHidden = true
            self.ProfileInfoStackViewLayout.constant = 0
            self.Profileimageheight.constant = 0
            self.AddPropertyView.alpha = 0.5
            self.ViewPropertyVicew.alpha = 0.5
            self.MyPropertiesAction.isEnabled = false
            self.AddPropetiesAction.isEnabled = false
            self.FavoriteItemsView.alpha = 0.5
            self.ViewdItemAction.isEnabled = false
            self.FavoriteItemAction.isEnabled = false
            self.ViewditemView.alpha = 0.5
            if XLanguage.get() == .Kurdish{
                self.ViewdItems.text = "0 بینراو"
                self.FavoriteItems.text = "0 خوازراو"
                self.ViewdItems.font =  UIFont(name: "PeshangDes2", size: 11)!
                self.FavoriteItems.font =  UIFont(name: "PeshangDes2", size: 11)!
            }else if XLanguage.get() == .English{
                self.ViewdItems.text = "0 ITEMS"
                self.FavoriteItems.text = "0 ITEMS"
                self.FavoriteItems.font =  UIFont(name: "ArialRoundedMTBold", size: 10)!
                self.ViewdItems.font =  UIFont(name: "ArialRoundedMTBold", size: 10)!
            }else{
                self.FavoriteItems.text = "0 عناصر"
                self.ViewdItems.text = "0 عناصر"
                self.ViewdItems.font =  UIFont(name: "PeshangDes2", size: 10)!
                self.FavoriteItems.font =  UIFont(name: "PeshangDes2", size: 10)!
            }
            self.GetYATop.constant = 0
            self.GetYABottom.constant = 0
            self.GetYAHeight.constant = 0
            self.GetYAView.isHidden = true
            
            self.SubscriptionView.isHidden             = true
            self.SubscriptionViewHeightLyout.constant  = 0
            self.SubscriptionViewTopLyout.constant     = 0
            self.SubscriptionViewBottomLyout.constant  = 0
            
            
            
        }else{print("is -----------------")
            if XLanguage.get() == .Kurdish{
                self.LoginOrLogoutLable.text = "چوونە دەرەوە"
                self.LoginOrLogoutLable.font = UIFont(name: "PeshangDes2", size: 14)!
            }else if XLanguage.get() == .English{
                self.LoginOrLogoutLable.text = "LOGOUT"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            }else{
                self.LoginOrLogoutLable.text = "تسجيل خروج"
                self.LoginOrLogoutLable.font = UIFont(name: "PeshangDes2", size: 14)!
            }
            
            
            self.Name.layer.cornerRadius = 5
            self.Phone.layer.cornerRadius = 3
            
            if let FireId = UserDefaults.standard.string(forKey: "UserId"){print("=-=-=-=-=-=-=-1111111")
                if let officeId = UserDefaults.standard.string(forKey: "OfficeId"){print("=-=-=-=-=-=-=-2222222")
                    OfficeAip.GetOffice(ID: officeId) { [self] office in
                        if office.type_id == "h9nFfUrHgSwIg17uRwTD"{print("is office-----------------1111")
                            self.ProfileRightImage.isHidden = false
                            self.Phone.isHidden = false
                            self.LoginImage.image = UIImage(named: "logout5")
                            self.ProfileInfoStackView.isHidden = false
                            self.ProfileInfoStackViewLayout.constant = 55
                            self.Profileimageheight.constant = 55
//                            self.AddPropertyView.alpha = 1
//                            self.ViewPropertyVicew.alpha = 1
                            self.ViewditemView.alpha = 1
                            self.FavoriteItemsView.alpha = 1
                            self.ViewdItemAction.isEnabled = true
//                            self.MyPropertiesAction.isEnabled = true
//                            self.AddPropetiesAction.isEnabled = true
                            self.FavoriteItemAction.isEnabled = true
                            
                            
                            SubscriptionAip.GetAllSubscriptionsType { subscription in
                                for sub in subscription{
                                    if sub.user_id == officeId{
                                        UIView.animate(withDuration:0.2, delay: 0.0) {
                                            UIView.animate(withDuration: 0.2, delay: 0.0) {
                                                self.SubscriptionView.isHidden  = false
                                                self.SubscriptionViewHeightLyout.constant  = 85
                                                self.SubscriptionViewTopLyout.constant  = 12
                                                self.SubscriptionViewBottomLyout.constant  = 12
                                                self.view.layoutIfNeeded()
                                            }
                                            let date = NSDate(timeIntervalSince1970: sub.start_date ?? 0.0)
                                            let dayTimePeriodFormatter = DateFormatter()
                                            dayTimePeriodFormatter.dateFormat = "dd-MM-YYYY  h:mm"
                                            let dateTimeString = dayTimePeriodFormatter.string(from: date as Date)
                                            let dateTime = dateTimeString.split(separator: ".")
                                            self.StartDate.text = "\(dateTime[0])".convertedDigitsToLocale(Locale(identifier: "EN"))
                                            
                                            
                                            let date1 = NSDate(timeIntervalSince1970: sub.end_date ?? 0.0)
                                            let dayTimePeriodFormatter1 = DateFormatter()
                                            dayTimePeriodFormatter1.dateFormat = "dd-MM-YYYY  h:mm"
                                            let dateTimeString1 = dayTimePeriodFormatter1.string(from: date1 as Date)
                                            let dateTime1 = dateTimeString1.split(separator: ".")
                                            self.EndDate.text = "\(dateTime1[0])".convertedDigitsToLocale(Locale(identifier: "EN"))
                                            
                                            
                                            
                                            print("dayyyssssss-----------------")
                                            self.days = (Date().days(sinceDate: date1 as Date) ?? 0) * -1
                                            if self.days < 0{
                                                self.days = 0
                                                self.SubscriptionDays.text = "0"
                                            }else{
                                                self.SubscriptionDays.text = "\(self.days)"
                                            }
                                            
                                            print((Date().days(sinceDate: date1 as Date) ?? 0) * -1)
                                            
                                            
                                            self.MyEstates.removeAll()
                                            if let FireId = UserDefaults.standard.string(forKey: "UserId"){
                                                OfficeAip.GetOfficeById(Id: FireId) { office in
                                                    ProductAip.GetAllMyEstates(office_id: office.id ?? "") { estates in
                                                        print("sub id -------: \(sub.subscription_type_id ?? "")")
                                                        
                                                        
                                                        
                                                        for estate in estates{
                                                            if Double(estate.Stamp ?? TimeInterval()) >= Double(sub.start_date ?? TimeInterval()) {
                                                                self.MyEstates.append(estate)
                                                            }
                                                        }
                                                
                                                        
                                                        
                                                        SubscriptionsTypeAip.GetSubscriptionsTypeByOfficeId(id: sub.subscription_type_id ?? "") { posts in
                                                            if XLanguage.get() == .Kurdish{
                                                                self.SubscriptionPosts.text = "\(posts.number_of_post ?? "") /پۆست \(self.MyEstates.count)"
                                                                self.SubscriptionPosts.font = UIFont(name: "PeshangDes2", size: 12)!
                                                            }else if XLanguage.get() == .English{
                                                                self.SubscriptionPosts.text = "\(self.MyEstates.count) Post /\(posts.number_of_post ?? "")"
                                                                self.SubscriptionPosts.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
                                                            }else{
                                                                self.SubscriptionPosts.text = "\(posts.number_of_post ?? "")/ منشور \(self.MyEstates.count)"
                                                                self.SubscriptionPosts.font = UIFont(name: "PeshangDes2", size: 12)!
                                                            }
                                                            
                                                            if self.days == 0 || Int(posts.number_of_post ?? "") == self.MyEstates.count{
                                                                self.AddPropertyView.alpha = 0.5
                                                                self.ViewPropertyVicew.alpha = 0.5
                                                                self.MyPropertiesAction.isEnabled = false
                                                                self.AddPropetiesAction.isEnabled = false
                                                            }else{
                                                                self.AddPropertyView.alpha = 1
                                                                self.ViewPropertyVicew.alpha = 1
                                                                self.MyPropertiesAction.isEnabled = true
                                                                self.AddPropetiesAction.isEnabled = true
                                                            }
                                                            
                                                            
                                                            if self.IsSubscriptionAlertShowed == false{
                                                                self.IsSubscriptionAlertShowed = true
                                                                if self.days == 0 || Int(posts.number_of_post ?? "") == self.MyEstates.count{
                                                                var message = ""
                                                                var action  = ""
                                                                var cancel  = ""
                                                                
                                                                if XLanguage.get() == .English{
                                                                    message = "Your subscription is expired, contact us to renew."
                                                                    action  = "Renew"
                                                                    cancel  = "Later"
                                                                    
                                                                }else if XLanguage.get() == .Arabic{
                                                                    message = "انتهى اشتراكك ، اتصل بنا للتجديد."
                                                                    action  = "تجديد"
                                                                    cancel  = "لاحقاً"
                                                                }else{
                                                                    message = "بەشداریکردنەکەت بەسەرچووە، پەیوەندیمان پێوە بکە بۆ نوێکردنەوە."
                                                                    action  = "نوێکردنەوە"
                                                                    cancel  = "دواتر"
                                                                }
                                                            
                                                                let myAlert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
                                                                myAlert.addAction(UIAlertAction(title: action, style: .default, handler: { (UIAlertAction) in
                                                                    self.dialNumber(phoneNumber: "+9647514505411")
                                                                }))
                                                                myAlert.addAction(UIAlertAction(title: cancel, style: .cancel, handler: nil))
                                                                self.present(myAlert, animated: true, completion: nil)
                                            
                                                            }
                                                        }
                                                        }
                                                        
                                                    }
                                                }
                                            }
                                            
                                        }
                                    }
                                }
                            }
                            
                            
                            
                            
                            
                            
                            self.EditProfile.isEnabled = true
                            self.GetYATop.constant = 0
                            self.GetYABottom.constant = 12
                            self.GetYAHeight.constant = 0
                            self.GetYAView.isHidden = true
                            self.AddPropertyView.isHidden = false
                            self.ViewPropertyVicew.isHidden = false
                            self.ProfileRightImage.isHidden = false
                            OfficeAip.GetOfficeById(Id: FireId) { office in
                                    self.Phone.isHidden = false
                                    let url = URL(string: office.ImageURL ?? "")
                                    self.Image.sd_setImage(with: url, completed: nil)
                                    self.Name.text = office.name?.description.uppercased()
                                    self.Phone.text = office.phone1
                            }
                        }else{print("is not office-----------------")
                            
                            
                            self.ProfileInfoStackView.isHidden = false
                            self.ProfileInfoStackViewLayout.constant = 55
                            self.Profileimageheight.constant = 55
                            
                            
                                self.Image.image = UIImage(named: "4811117-small")
                                self.Name.text = UserDefaults.standard.string(forKey: "PhoneNumber")
                                self.Phone.isHidden = true
                            
                            
                            
                            self.SubscriptionView.isHidden             = true
                            self.SubscriptionViewHeightLyout.constant  = 0
                            self.SubscriptionViewTopLyout.constant     = 0
                            self.SubscriptionViewBottomLyout.constant  = 0
                            self.ProfileRightImage.isHidden = true
                            
                            
                            
                            self.EditProfile.isEnabled = false
                            self.GetYATop.constant = 15
                            self.GetYABottom.constant = 12
                            self.GetYAHeight.constant = 40
                            self.GetYAView.isHidden = false
                            
                            
                            
                            self.GetYA.text = ""
                            if self.lang == 1{
                                label.text = "بۆ دروستکردنی ئەکاونتی ئۆفیسی خانووبەرە پەیوەندیمان پێوە بکەن."
                                label.font = UIFont(name: "PeshangDes2", size: 14)!
                            }else if self.lang == 2{
                                label.text = "Contact us for creating a real estate office account."
                                label.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
                            }else{
                                label.text = "اتصل بنا لإنشاء حساب مكتب عقارات."
                                label.font = UIFont(name: "PeshangDes2", size: 14)!
                            }
                            label.translatesAutoresizingMaskIntoConstraints = false
                            label.textColor = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
                            label.shimmerColor = .white
                            self.GetYA.addSubview(label)
                            self.label.startShimmering()
                            self.Image.image = UIImage(named: "4811117-small")
                            self.Phone.text = UserDefaults.standard.string(forKey: "PhoneNumber")
                            self.AddPropertyView.alpha = 0.5
                            self.ViewPropertyVicew.alpha = 0.5
                            self.MyPropertiesAction.isEnabled = false
                            self.AddPropetiesAction.isEnabled = false
                            self.ProfileRightImage.isHidden = true
                        }
                    }
                    
                    
                    
                    self.ViewdItemCount = 0
                    self.ViewdItemsEstate.removeAll()
                    self.FavoriteItemCount = 0
                    self.FavoriteItemsEstate.removeAll()
                    ///ViewdItemsCount
                    ///
                    
                    ProductAip.GetAllProducts { estate in
                        self.AllEstate = estate
                        
                        ViewdItemsObjectAip.GeViewdItemById(fire_id: FireId) { [self] Item in
                            print("]]]]]]]]]]]]]]]]]]]]]]\(self.AllEstate.count)")
                            for i in self.AllEstate{print("=====")
                                if i.id == Item.estate_id{
                                    ViewdItemCount = ViewdItemCount + 1
                                    self.ViewdItemsEstate.append(i)
                                }
                            }
                            
                            
                            print("=====")
                            print(ViewdItemCount)
                            if ViewdItemCount == 1{
                                if XLanguage.get() == .Kurdish{
                                    self.ViewdItems.text = "\(ViewdItemCount) بینراو"
                                    self.ViewdItems.font = UIFont(name: "PeshangDes2", size: 11)!
                                }else if XLanguage.get() == .English{
                                    self.ViewdItems.text = "\(ViewdItemCount) ITEM"
                                    self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                                }else{
                                    self.ViewdItems.text = "\(ViewdItemCount) عنصر"
                                    self.ViewdItems.font = UIFont(name: "PeshangDes2", size: 11)!
                                }
                                
                            }else{
                                if XLanguage.get() == .Kurdish{
                                    self.ViewdItems.text = "\(ViewdItemCount) بینراو"
                                    self.ViewdItems.font = UIFont(name: "PeshangDes2", size: 11)!
                                }else if XLanguage.get() == .English{
                                    self.ViewdItems.text = "\(ViewdItemCount) ITEMS"
                                    self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                                }else{
                                    self.ViewdItems.text = "\(ViewdItemCount) عناصر"
                                    self.ViewdItems.font = UIFont(name: "PeshangDes2", size: 11)!
                                }
                            }
                        }
                        
                        
                        ///FavoriteItemsCount
                        FavoriteItemsObjectAip.GetFavoriteItemsById(fire_id: FireId) { [self] Item in
                            for i in self.AllEstate{
                                if i.id == Item.estate_id{
                                    FavoriteItemCount = FavoriteItemCount + 1
                                    self.FavoriteItemsEstate.append(i)
                                }
                            }
                            //                        if Item.estate_id != ""{
                            //                            FavoriteItemCount = FavoriteItemCount + 1
                            //                        }
                            if FavoriteItemCount == 1{
                                if XLanguage.get() == .Kurdish{
                                    self.FavoriteItems.text = "\(FavoriteItemCount) خوازراو"
                                    self.FavoriteItems.font =  UIFont(name: "PeshangDes2", size: 11)!
                                }else if XLanguage.get() == .English{
                                    self.FavoriteItems.text = "\(FavoriteItemCount) ITEM"
                                    self.FavoriteItems.font =  UIFont(name: "ArialRoundedMTBold", size: 10)!
                                }else{
                                    self.FavoriteItems.text = "\(FavoriteItemCount) عنصر"
                                    self.FavoriteItems.font =  UIFont(name: "PeshangDes2", size: 11)!
                                }
                            }else{
                                if XLanguage.get() == .Kurdish{
                                    self.FavoriteItems.text = "\(FavoriteItemCount) خوازراو"
                                    self.FavoriteItems.font =  UIFont(name: "PeshangDes2", size: 11)!
                                }else if XLanguage.get() == .English{
                                    self.FavoriteItems.text = "\(FavoriteItemCount) ITEMS"
                                    self.FavoriteItems.font =  UIFont(name: "ArialRoundedMTBold", size: 10)!
                                }else{
                                    self.FavoriteItems.text = "\(FavoriteItemCount) عناصر"
                                    self.FavoriteItems.font =  UIFont(name: "PeshangDes2", size: 11)!
                                }
                                
                            }
                        }
                        
                    }
                    
                }
                
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.LocationChanged), name: NSNotification.Name(rawValue: "LocationChanged"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.LangChanged), name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)
    }
    
    @objc func LocationChanged(){
        if XLanguage.get() == .English{
            if let cityId = UserDefaults.standard.string(forKey: "CityId"){
            CityObjectAip.GetCities { cities in
                    for city in cities {
                        if city.id == cityId{
                            CountryObjectAip.GeCountryById(id: city.country_id ?? "") { country in
                                self.Location.text = "\(country.name ?? "")-\(city.name ?? "")".uppercased()
                                self.Location.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
                            }
                        }
                    }
                }
            }
        }else if XLanguage.get() == .Arabic{
            if let cityId = UserDefaults.standard.string(forKey: "CityId"){
            CityObjectAip.GetCities { cities in
                    for city in cities {
                        if city.id == cityId{
                            CountryObjectAip.GeCountryById(id: city.country_id ?? "") { country in
                                self.Location.text = "\(country.ar_name ?? "")-\(city.ar_name ?? "")".uppercased()
                                self.Location.font = UIFont(name: "PeshangDes2", size: 11)!
                            }
                        }
                    }
                }
            }
        }else{
            if let cityId = UserDefaults.standard.string(forKey: "CityId"){
            CityObjectAip.GetCities { cities in
                    for city in cities {
                        if city.id == cityId{
                            CountryObjectAip.GeCountryById(id: city.country_id ?? "") { country in
                                self.Location.text = "\(country.ku_name ?? "")-\(city.ku_name ?? "")".uppercased()
                                self.Location.font = UIFont(name: "PeshangDes2", size: 11)!
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    @IBAction func CheckVersion(_ sender: Any) {
        Drops.hideAll()
        var title = "Version \(self.version)"
        var message = "Is your current version."
        
        if XLanguage.get() == .English{
            title = "Version \(self.version)"
            message = "Is your current version."
        }else if XLanguage.get() == .Kurdish{
            title = "وەشانی \(self.version)"
            message = "وەشانی ئێستای تۆیە."
        }else{
            title = "الإصدار \(self.version)"
            message = "هو نسختك الحالية."
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
    
    
    func isUpdateAvailable() throws -> Bool {
        guard let info = Bundle.main.infoDictionary,
              let currentVersion = info["CFBundleShortVersionString"] as? String,
              let identifier = info["CFBundleIdentifier"] as? String,
              let url = URL(string: "https://itunes.apple.com/lookup?bundleId=\(identifier)") else {
            throw VersionError.invalidBundleInfo
        }
        let data = try Data(contentsOf: url)
        guard let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] else {
            throw VersionError.invalidResponse
        }
        if let result = (json["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String {
            return version != currentVersion
        }
        throw VersionError.invalidResponse
    }
    
    enum VersionError: Error {
        case invalidResponse, invalidBundleInfo
    }
    
    
    
    
    
    var logoutT = ""
    var logoutM = ""
    var Action = ""
    var cancel = ""
    @IBAction func LoginOrLogout(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: "Login") == true {
            if XLanguage.get() == .Kurdish{
                self.logoutT = "چوونە دەرەوە"
                self.logoutM = "ئایا دڵنیای کە دەتەوێت دەربچیت؟"
                self.Action = "بەڵێ"
                self.cancel = "نەخێر"
            }else if XLanguage.get() == .English{
                self.logoutT = "logout"
                self.logoutM = "Are you sure you want to logout?"
                self.Action = "Yes"
                self.cancel = "No"
            }else{
                self.logoutT = "تسجيل خروج"
                self.logoutM = "هل أنت متأكد أنك تريد تسجيل الخروج؟"
                self.Action = "نعم"
                self.cancel = "لا"
            }
            
   
            
            let myAlert = UIAlertController(title: logoutT, message: logoutM, preferredStyle: UIAlertController.Style.alert)
            myAlert.addAction(UIAlertAction(title: Action, style: .default, handler: { (UIAlertAction) in
                let firebaseAuth = Auth.auth()
                do {
                    try firebaseAuth.signOut()
                    UserDefaults.standard.set(false, forKey: "Login")
                    UserDefaults.standard.set("", forKey: "UserId")
                    UserDefaults.standard.set("", forKey: "PhoneNumber")
                    if XLanguage.get() == .English{
                        self.LoginOrLogoutLable.text = "LOGIN"
                    }else if XLanguage.get() == .Arabic{
                        self.LoginOrLogoutLable.text = "تسجيل الدخول"
                    }else{
                        self.LoginOrLogoutLable.text = "چونه‌ ژووره‌وه‌"
                    }
                    self.LoginImage.image = UIImage(named: "vuesax-bold-login")
                    self.ProfileInfoStackView.isHidden = true
                    self.ProfileInfoStackViewLayout.constant = 0
                    self.AddPropertyView.alpha = 0.5
                    self.ViewPropertyVicew.alpha = 0.5
                    self.ViewditemView.alpha = 0.5
                    self.FavoriteItemsView.alpha = 0.5
                    self.GetYATop.constant = 0
                    self.GetYABottom.constant = 12
                    self.GetYAHeight.constant = 0
                    self.GetYAView.isHidden = true
                    
                    self.SubscriptionView.isHidden             = true
                    self.SubscriptionViewHeightLyout.constant  = 0
                    self.SubscriptionViewTopLyout.constant     = 0
                    self.SubscriptionViewBottomLyout.constant  = 0
                    
                    if XLanguage.get() == .Kurdish{
                        self.ViewdItems.text = "0 بینراو"
                        self.FavoriteItems.text = "0 خوازراو"
                        self.ViewdItems.font =  UIFont(name: "PeshangDes2", size: 11)!
                        self.FavoriteItems.font =  UIFont(name: "PeshangDes2", size: 11)!
                    }else if XLanguage.get() == .English{
                        self.ViewdItems.text = "0 ITEMS"
                        self.FavoriteItems.text = "0 ITEMS"
                        self.FavoriteItems.font =  UIFont(name: "ArialRoundedMTBold", size: 10)!
                        self.ViewdItems.font =  UIFont(name: "ArialRoundedMTBold", size: 10)!
                    }else{
                        self.FavoriteItems.text = "0 عناصر"
                        self.ViewdItems.text = "0 عناصر"
                        self.ViewdItems.font =  UIFont(name: "PeshangDes2", size: 11)!
                        self.FavoriteItems.font =  UIFont(name: "PeshangDes2", size: 11)!
                    }
                    
                } catch let signOutError as NSError {
                    print ("Error signing out: %@", signOutError)
                }
            }))
            myAlert.addAction(UIAlertAction(title: cancel, style: .cancel, handler: nil))
            self.present(myAlert, animated: true, completion: nil)
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVCViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    
        
        
    }
    
    
    @IBAction func AddProperty(_ sender: Any) {
        
    }
    
    
    @IBAction func ViewMyPro(_ sender: Any) {
        
    }
    
    
    @IBAction func EditProfile(_ sender: Any) {
        
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
    
    
    
    
    @objc func LangChanged(){
        print(self.lang)
        
        if XLanguage.get() == .English{
            if let cityId = UserDefaults.standard.string(forKey: "CityId"){
            CityObjectAip.GetCities { cities in
                    for city in cities {
                        if city.id == cityId{
                            CountryObjectAip.GeCountryById(id: city.country_id ?? "") { country in
                                self.Location.text = "\(country.name ?? "")-\(city.name ?? "")".uppercased()
                                self.Location.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
                            }
                        }
                    }
                }
            }else{
                self.Location.text = "iraq-\(UserDefaults.standard.string(forKey: "CityName") ?? "".uppercased())"
            }
        }else if XLanguage.get() == .Arabic{
            if let cityId = UserDefaults.standard.string(forKey: "CityId"){
            CityObjectAip.GetCities { cities in
                    for city in cities {
                        if city.id == cityId{
                            CountryObjectAip.GeCountryById(id: city.country_id ?? "") { country in
                                self.Location.text = "\(country.ar_name ?? "")-\(city.ar_name ?? "")".uppercased()
                                self.Location.font = UIFont(name: "PeshangDes2", size: 11)!
                            }
                        }
                    }
                }
            }else{
                self.Location.text = "iraq-\(UserDefaults.standard.string(forKey: "CityName") ?? "".uppercased())"
            }
        }else{
            if let cityId = UserDefaults.standard.string(forKey: "CityId"){
            CityObjectAip.GetCities { cities in
                    for city in cities {
                        if city.id == cityId{
                            CountryObjectAip.GeCountryById(id: city.country_id ?? "") { country in
                                self.Location.text = "\(country.ku_name ?? "")-\(city.ku_name ?? "")".uppercased()
                                self.Location.font = UIFont(name: "PeshangDes2", size: 11)!
                            }
                        }
                    }
                }
            }else{
                self.Location.text = "iraq-\(UserDefaults.standard.string(forKey: "CityName") ?? "".uppercased())"
            }
        }
        
        
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                if XLanguage.get() == .English{
                    DispatchQueue.main.async {
                    self.NotificationLable.text = "ON"
                        self.NotificationLable.font =  UIFont(name: "ArialRoundedMTBold", size: 11)!
                    }
                }else if XLanguage.get() == .Kurdish{
                    DispatchQueue.main.async {
                    self.NotificationLable.text = "چالاک کراوە"
                        self.NotificationLable.font =  UIFont(name: "PeshangDes2", size: 11)!
                    }
                }else{
                    DispatchQueue.main.async {
                    self.NotificationLable.text = "مفعلة"
                        self.NotificationLable.font =  UIFont(name: "PeshangDes2", size: 11)!
                    }
                }
            }
            else {
                if XLanguage.get() == .English{
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "OFF"
                        self.NotificationLable.font =  UIFont(name: "ArialRoundedMTBold", size: 11)!
                    }
                }else if XLanguage.get() == .Kurdish{
                    DispatchQueue.main.async {
                    self.NotificationLable.text = "چالاک کراوە نیە"
                        self.NotificationLable.font =  UIFont(name: "PeshangDes2", size: 11)!
                    }
                }else{
                    DispatchQueue.main.async {
                    self.NotificationLable.text = "غیر مفعلة"
                        self.NotificationLable.font =  UIFont(name: "PeshangDes2", size: 11)!
                    }
                }
            }
        }
        if XLanguage.get() == .Kurdish{
            self.Etitle = "ئینگلیزی"
            self.Atitle = "عەرەبی"
            self.Ktitle = "کوردی"
            self.LanguageLable.text = self.Ktitle
            self.LanguageLable.font =  UIFont(name: "PeshangDes2", size: 11)!
            
            self.logoutT = "چوونە دەرەوە"
            self.logoutM = "ئایا دڵنیای کە دەتەوێت دەربچیت؟"
            self.Action = "بەڵێ"
            self.cancel = "نەخێر"
            
            self.titlee = "گۆڕینی زمان"
            self.message = "زمان"
            
            self.loadingLableMessage = "تكایه‌ چاوه‌ڕێبه‌..."
            
            self.cityTitle = "شارەکەت هەڵبژێرە"
            self.cityAction = "بەڵێ"
        }else if XLanguage.get() == .English{print("001111")
            self.Etitle = "English"
            self.Atitle = "Arabic"
            self.Ktitle = "Kurdish"
            self.LanguageLable.text = self.Etitle
            self.LanguageLable.font =  UIFont(name: "ArialRoundedMTBold", size: 11)!
            self.logoutT = "logout"
            self.logoutM = "Are you sure you want to logout?"
            self.Action = "Yes"
            self.cancel = "No"
            
            self.titlee = "Change Language"
            self.message = "Language"
            
            self.loadingLableMessage = "Please wait..."
            
            self.cityTitle = "Choose your city"
            self.cityAction = "Ok"
        }else{
            self.Etitle = "إنجليزي"
            self.Atitle = "العربة"
            self.Ktitle = "الکردیة"
            self.LanguageLable.text = self.Atitle
            self.LanguageLable.font =  UIFont(name: "PeshangDes2", size: 11)!
            self.logoutT = "تسجيل خروج"
            self.logoutM = "هل أنت متأكد أنك تريد تسجيل الخروج؟"
            self.Action = "نعم"
            self.cancel = "لا"
            
            self.titlee = "تغيير اللغة"
            self.message = "لغة"
            self.loadingLableMessage = "يرجى الانتظار..."
            
            
            self.cityTitle = "اختر مدينتك"
            
            self.cityAction = "نعم"
        }
        
        
        
        if let FireId = UserDefaults.standard.string(forKey: "UserId"){
            if let officeId = UserDefaults.standard.string(forKey: "OfficeId"){
                OfficeAip.GetOffice(ID: officeId) { [self] office in
                    if office.type_id == "h9nFfUrHgSwIg17uRwTD"{
                        SubscriptionAip.GetAllSubscriptionsType { subscription in
                            for sub in subscription{
                                if sub.user_id == officeId{
                                    self.MyEstates.removeAll()
                                    OfficeAip.GetOfficeById(Id: FireId) { office in
                                        ProductAip.GetAllMyEstates(office_id: office.id ?? "") { estates in
                                            self.MyEstates = estates
                                            SubscriptionsTypeAip.GetSubscriptionsTypeByOfficeId(id: sub.subscription_type_id ?? "") { posts in
                                                if XLanguage.get() == .Kurdish{
                                                    self.SubscriptionPosts.text = "\(posts.number_of_post ?? "") /پۆست \(self.MyEstates.count)"
                                                    self.SubscriptionPosts.font = UIFont(name: "PeshangDes2", size: 11)!
                                                }else if XLanguage.get() == .English{
                                                    self.SubscriptionPosts.text = "\(self.MyEstates.count) Post /\(posts.number_of_post ?? "")"
                                                    self.SubscriptionPosts.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
                                                }else{
                                                    self.SubscriptionPosts.text = "\(posts.number_of_post ?? "")/ منشور \(self.MyEstates.count)"
                                                    self.SubscriptionPosts.font = UIFont(name: "PeshangDes2", size: 11)!
                                                }
                                                
                                            }
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        
        
        if UserDefaults.standard.bool(forKey: "Login") == false {
            if XLanguage.get() == .Kurdish{
                self.LoginOrLogoutLable.text = "چونه‌ ژووره‌وه‌"
                self.LoginOrLogoutLable.font =  UIFont(name: "PeshangDes2", size: 14)!
            }else if XLanguage.get() == .English{
                self.LoginOrLogoutLable.text = "LOGIN"
                self.LoginOrLogoutLable.font =  UIFont(name: "ArialRoundedMTBold", size: 11)!
            }else{
                self.LoginOrLogoutLable.text = "تسجيل الدخول"
                self.LoginOrLogoutLable.font =  UIFont(name: "PeshangDes2", size: 14)!
            }
            if XLanguage.get() == .Kurdish{
                self.ViewdItems.text = "0 بینراو"
                self.FavoriteItems.text = "0 خوازراو"
                self.ViewdItems.font =     UIFont(name: "PeshangDes2", size: 11)!
                self.FavoriteItems.font =  UIFont(name: "PeshangDes2", size: 11)!
            }else if XLanguage.get() == .English{
                self.ViewdItems.text = "0 ITEMS"
                self.FavoriteItems.text = "0 ITEMS"
                self.ViewdItems.font =  UIFont(name: "ArialRoundedMTBold", size: 10)!
                self.FavoriteItems.font =  UIFont(name: "ArialRoundedMTBold", size: 10)!
            }else{
                self.FavoriteItems.text = "0 عناصر"
                self.ViewdItems.text = "0 عناصر"
                self.ViewdItems.font =  UIFont(name: "PeshangDes2", size: 11)!
                self.FavoriteItems.font =  UIFont(name: "PeshangDes2", size: 11)!
            }
        }else{
            
            
            
            
            
            
            
            
            
            if XLanguage.get() == .Kurdish{
                self.LoginOrLogoutLable.text = "چوونە دەرەوە"
                self.LoginOrLogoutLable.font =  UIFont(name: "PeshangDes2", size: 14)!
            }else if XLanguage.get() == .English{print("2222")
                self.LoginOrLogoutLable.text = "LOGOUT"
                self.LoginOrLogoutLable.font =  UIFont(name: "ArialRoundedMTBold", size: 11)!
            }else{
                self.LoginOrLogoutLable.text = "تسجيل خروج"
                self.LoginOrLogoutLable.font =  UIFont(name: "PeshangDes2", size: 14)!
            }
            
            if XLanguage.get() == .Kurdish{
                self.label.text = "بۆ دروستکردنی ئەکاونتی ئۆفیسی خانووبەرە پەیوەندیمان پێوە بکەن."
                self.label.font =  UIFont(name: "PeshangDes2", size: 11)!
            }else if XLanguage.get() == .English{
                self.label.text = "Contact us for creating a real estate office account."
                self.label.font =  UIFont(name: "ArialRoundedMTBold", size: 11)!
            }else{
                self.label.text = "اتصل بنا لإنشاء حساب مكتب عقارات."
                self.label.font =  UIFont(name: "PeshangDes2", size: 11)!
            }
            
            
            
            if let FireId = UserDefaults.standard.string(forKey: "UserId"){
                    
                    self.ViewdItemCount = 0
                    self.ViewdItemsEstate.removeAll()
                    self.FavoriteItemCount = 0
                    self.FavoriteItemsEstate.removeAll()
                    
                    ///ViewdItemsCount
                    ViewdItemsObjectAip.GeViewdItemById(fire_id: FireId) { [self] Item in
                        for i in self.AllEstate{
                            if i.id == Item.estate_id{
                                ViewdItemCount = ViewdItemCount + 1
                                self.ViewdItemsEstate.append(i)
                            }
                        }

                        if ViewdItemCount == 1{
                            if XLanguage.get() == .Kurdish{
                                self.ViewdItems.text = "\(ViewdItemCount) بینراو"
                                self.ViewdItems.font =  UIFont(name: "PeshangDes2", size: 11)!
                            }else if XLanguage.get() == .English{print("44444")
                                self.ViewdItems.text = "\(ViewdItemCount) ITEM"
                                self.ViewdItems.font =  UIFont(name: "ArialRoundedMTBold", size: 10)!
                            }else{
                                self.ViewdItems.text = "\(ViewdItemCount) عنصر"
                                self.ViewdItems.font =  UIFont(name: "PeshangDes2", size: 11)!
                            }
                            
                        }else{
                            if XLanguage.get() == .Kurdish{
                                self.ViewdItems.text = "\(ViewdItemCount) بینراو"
                                self.ViewdItems.font =  UIFont(name: "PeshangDes2", size: 11)!
                            }else if XLanguage.get() == .English{
                                self.ViewdItems.text = "\(ViewdItemCount) ITEMS"
                                self.ViewdItems.font =  UIFont(name: "ArialRoundedMTBold", size: 10)!
                            }else{
                                self.ViewdItems.text = "\(ViewdItemCount) عناصر"
                                self.ViewdItems.font =  UIFont(name: "PeshangDes2", size: 11)!
                            }
                        }
                    }
                    
                    
                    ///FavoriteItemsCount
                    FavoriteItemsObjectAip.GetFavoriteItemsById(fire_id: FireId) { [self] Item in
                        for i in self.AllEstate{
                            if i.id == Item.estate_id{
                                FavoriteItemCount = FavoriteItemCount + 1
                                self.FavoriteItemsEstate.append(i)
                            }
                        }
                        if FavoriteItemCount == 1{
                            if XLanguage.get() == .Kurdish{
                                self.FavoriteItems.text = "\(FavoriteItemCount) خوازراو"
                                self.FavoriteItems.font =  UIFont(name: "PeshangDes2", size: 11)!
                            }else if XLanguage.get() == .English{
                                self.FavoriteItems.text = "\(FavoriteItemCount) ITEM"
                                self.FavoriteItems.font =  UIFont(name: "ArialRoundedMTBold", size: 10)!
                            }else{
                                self.FavoriteItems.text = "\(FavoriteItemCount) عنصر"
                                self.FavoriteItems.font =  UIFont(name: "PeshangDes2", size: 11)!
                            }
                        }else{
                            if XLanguage.get() == .Kurdish{
                                self.FavoriteItems.text = "\(FavoriteItemCount) خوازراو"
                                self.FavoriteItems.font =  UIFont(name: "PeshangDes2", size: 11)!
                            }else if XLanguage.get() == .English{
                                self.FavoriteItems.text = "\(FavoriteItemCount) ITEMS"
                                self.FavoriteItems.font =  UIFont(name: "ArialRoundedMTBold", size: 10)!
                            }else{
                                self.FavoriteItems.text = "\(FavoriteItemCount) عناصر"
                                self.FavoriteItems.font =  UIFont(name: "PeshangDes2", size: 11)!
                            }
                            
                        }
                    }
                }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func ChangLocation(_ sender: Any) {
        setupCitySelectionAlert()
    }
    
    @IBOutlet weak var Location : UILabel!
    
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
        ac.addAction(UIAlertAction(title: cityAction , style: .default, handler: { _ in
            if self.CityArray.count != 0{
            let pickerValue = self.CityArray[self.pickerView.selectedRow(inComponent: 0)]
            if XLanguage.get() == .English{
                CountryObjectAip.GeCountryById(id: pickerValue.country_id ?? "") { country in
                    self.Location.text = "\(country.name ?? "")-\(pickerValue.name ?? "")".uppercased()
                    UserDefaults.standard.set("\(country.name ?? "")-\(pickerValue.name ?? "")".uppercased(), forKey: "CityName")
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LocationChangedS"), object: nil)
                }
            }else if XLanguage.get() == .Arabic{
                CountryObjectAip.GeCountryById(id: pickerValue.country_id ?? "") { country in
                    self.Location.text = "\(country.ar_name ?? "")-\(pickerValue.ar_name ?? "")".uppercased()
                    UserDefaults.standard.set("\(country.ar_name ?? "")-\(pickerValue.ar_name ?? "")".uppercased(), forKey: "CityName")
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LocationChangedS"), object: nil)
                }
            }else{
                CountryObjectAip.GeCountryById(id: pickerValue.country_id ?? "") { country in
                    self.Location.text = "\(country.ku_name ?? "")-\(pickerValue.ku_name ?? "")".uppercased()
                    UserDefaults.standard.set("\(country.ku_name ?? "")-\(pickerValue.ku_name ?? "")".uppercased(), forKey: "CityName")
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LocationChangedS"), object: nil)
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}



extension Bundle {
    
    var releaseVersionNumber: String? {
        return self.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var buildVersionNumber: String? {
        return self.infoDictionary?["CFBundleVersion"] as? String
    }
    
}
extension Date {
    func days(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.day], from: sinceDate, to: self).day
    }
}
