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
import FirebaseRemoteConfig
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
    
    
    
    var Etitle = ""
    var Atitle = ""
    var Ktitle = ""
    var titlee = ""
    var Htitle = ""
    var Ctitle = ""
    var HItitle = ""
    var Ptitle = ""
    var Stitle = ""
    var GRtitle = ""
    var Rtitle = ""
    var Dtitle = ""
    var Ftitle = ""
    var SPtitle = ""
    var GEtitle = ""
    var message = ""
    
    @IBOutlet weak var LanguageLable: UILabel!
    
    
    
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
                }else if XLanguage.get() == .Arabic{
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "مفعلة"
                        self.NotificationLable.font =  UIFont(name: "PeshangDes2", size: 11)!
                    }
                }else if XLanguage.get() == .English {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "ON"
                    }
                } else if XLanguage.get() == .Dutch {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "AAN" // Dutch for "ON"
                    }
                } else if XLanguage.get() == .French {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "ACTIVÉ" // French for "ON"
                    }
                } else if XLanguage.get() == .Spanish {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "ENCENDIDO" // Spanish for "ON"
                    }
                } else if XLanguage.get() == .German {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "EIN" // German for "ON"
                    }
                } else if XLanguage.get() == .Hebrew {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "פעיל" // Hebrew for "ON"
                    }
                } else if XLanguage.get() == .Chinese {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "开" // Simplified Chinese for "ON"
                    }
                } else if XLanguage.get() == .Hindi {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "चालू" // Hindi for "ON"
                    }
                } else if XLanguage.get() == .Portuguese {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "LIGADO" // Portuguese for "ON"
                    }
                } else if XLanguage.get() == .Swedish {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "PÅ" // Swedish for "ON"
                    }
                } else if XLanguage.get() == .Greek {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "ΕΝΕΡΓΟΠΟΙΗΜΈΝΟ" // Greek for "ON"
                    }
                } else if XLanguage.get() == .Russian {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "ВКЛ" // Russian for "ON"
                    }
                }
                
            }
            else {
                self.NotificationLable.font =  UIFont(name: "ArialRoundedMTBold", size: 11)!
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
                }else if XLanguage.get() == .Arabic{
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "غیر مفعلة"
                        self.NotificationLable.font =  UIFont(name: "PeshangDes2", size: 11)!
                    }
                }else if XLanguage.get() == .Dutch {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "UIT" // Dutch for "OFF"
                    }
                } else if XLanguage.get() == .French {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "DÉSACTIVÉ" // French for "OFF"
                    }
                } else if XLanguage.get() == .Spanish {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "APAGADO" // Spanish for "OFF"
                    }
                } else if XLanguage.get() == .German {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "AUS" // German for "OFF"
                    }
                } else if XLanguage.get() == .Hebrew {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "כבוי" // Hebrew for "OFF"
                    }
                } else if XLanguage.get() == .Chinese {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "关" // Simplified Chinese for "OFF"
                    }
                } else if XLanguage.get() == .Hindi {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "बंद" // Hindi for "OFF"
                    }
                } else if XLanguage.get() == .Portuguese {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "DESLIGADO" // Portuguese for "OFF"
                    }
                } else if XLanguage.get() == .Swedish {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "AV" // Swedish for "OFF"
                    }
                } else if XLanguage.get() == .Greek {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "ΑΠΕΝΕΡΓΟΠΟΙΗΜΈΝΟ" // Greek for "OFF"
                    }
                } else if XLanguage.get() == .Russian {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "ВЫКЛ" // Russian for "OFF"
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
            }else if XLanguage.get() == .English {
                myVC.title = "FAVORITE ITEMS"
            } else if XLanguage.get() == .Dutch {
                myVC.title = "FAVORIETE ITEMS"
            } else if XLanguage.get() == .French {
                myVC.title = "ARTICLES FAVORIS"
            } else if XLanguage.get() == .Spanish {
                myVC.title = "ÍTEMS FAVORITOS"
            } else if XLanguage.get() == .German {
                myVC.title = "LIEBLINGSARTIKEL"
            } else if XLanguage.get() == .Hebrew {
                myVC.title = "פריטים מועדפים"
            } else if XLanguage.get() == .Chinese {
                myVC.title = "收藏项目"
            } else if XLanguage.get() == .Hindi {
                myVC.title = "पसंदीदा आइटम"
            } else if XLanguage.get() == .Portuguese {
                myVC.title = "ITENS FAVORITOS"
            } else if XLanguage.get() == .Swedish {
                myVC.title = "FAVORITARTIKLAR"
            } else if XLanguage.get() == .Greek {
                myVC.title = "ΑΓΑΠΗΜΈΝΑ ΕΊΔΗ"
            } else if XLanguage.get() == .Russian {
                myVC.title = "ИЗБРАННЫЕ ТОВАРЫ"
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
        if !CheckInternet.Connection(){
            if XLanguage.get() == .English{
                let ac = UIAlertController(title: "Error", message: "Please check your internet connection.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            }else if XLanguage.get() == .Arabic{
                let ac = UIAlertController(title: "خطأ", message: "الرجاء التحقق من اتصال الانترنت الخاص بك.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "نعم", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            }else if XLanguage.get() == .Kurdish{
                let ac = UIAlertController(title: "هەڵە", message: "تکایە هێڵی ئینتەرنێتەکەت بپشکنە.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "باشە", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            }else if XLanguage.get() == .Dutch {
                let ac = UIAlertController(title: "Fout", message: "Controleer uw internetverbinding.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .French {
                let ac = UIAlertController(title: "Erreur", message: "Veuillez vérifier votre connexion internet.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Spanish {
                let ac = UIAlertController(title: "Error", message: "Por favor, verifica tu conexión a internet.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .German {
                let ac = UIAlertController(title: "Fehler", message: "Bitte überprüfen Sie Ihre Internetverbindung.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Hebrew {
                let ac = UIAlertController(title: "שגיאה", message: "אנא בדוק את חיבור האינטרנט שלך.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "אישור", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Chinese {
                let ac = UIAlertController(title: "错误", message: "请检查您的互联网连接。", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "确定", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Hindi {
                let ac = UIAlertController(title: "त्रुटि", message: "कृपया अपना इंटरनेट कनेक्शन जाँच लें।", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "ठीक है", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Portuguese {
                let ac = UIAlertController(title: "Erro", message: "Por favor, verifique sua conexão com a internet.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Swedish {
                let ac = UIAlertController(title: "Fel", message: "Vänligen kontrollera din internetanslutning.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Greek {
                let ac = UIAlertController(title: "Σφάλμα", message: "Παρακαλώ ελέγξτε τη σύνδεσή σας στο διαδίκτυο.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "ΟΚ", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Russian {
                let ac = UIAlertController(title: "Ошибка", message: "Пожалуйста, проверьте ваше интернет-соединение.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "ОК", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            }
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let myVC = storyboard.instantiateViewController(withIdentifier: "AboutUsVc") as! AboutrVC
            self.navigationController?.pushViewController(myVC, animated: true)
        }
    }
    
    
    @IBAction func CntactUs(_ sender: Any) {
        self.dialNumber(phoneNumber: "+9647513164239")
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
    
    
//
//    @IBOutlet weak var SubscriptionView             : UIView!
//    @IBOutlet weak var SubscriptionDays             : UILabel!
//    @IBOutlet weak var SubscriptionPosts            : UILabel!
//    @IBOutlet weak var StartDate                    : UILabel!
//    @IBOutlet weak var EndDate                      : UILabel!
//    @IBOutlet weak var SubscriptionViewHeightLyout  : NSLayoutConstraint!
//    @IBOutlet weak var SubscriptionViewTopLyout     : NSLayoutConstraint!
//    @IBOutlet weak var SubscriptionViewBottomLyout  : NSLayoutConstraint!
//
    
    
    
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
         
        
        
        
//        
//        
//        if XLanguage.get() == .English{
//            if let cityId = UserDefaults.standard.string(forKey: "CityId"){
//            CityObjectAip.GetCities { cities in
//                    for city in cities {
//                        if city.id == cityId{
//                            CountryObjectAip.GeCountryById(id: city.country_id ?? "") { country in
//                                self.Location.text = "\(country.name ?? "")-\(city.name ?? "")".uppercased()
//                                self.Location.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
//                            }
//                        }
//                    }
//                }
//            }
//        }else if XLanguage.get() == .Arabic{
//            if let cityId = UserDefaults.standard.string(forKey: "CityId"){
//            CityObjectAip.GetCities { cities in
//                    for city in cities {
//                        if city.id == cityId{
//                            CountryObjectAip.GeCountryById(id: city.country_id ?? "") { country in
//                                self.Location.text = "\(country.ar_name ?? "")-\(city.ar_name ?? "")".uppercased()
//                                self.Location.font = UIFont(name: "PeshangDes2", size: 11)!
//                            }
//                        }
//                    }
//                }
//            }
//        }else{
//            if let cityId = UserDefaults.standard.string(forKey: "CityId"){
//            CityObjectAip.GetCities { cities in
//                    for city in cities {
//                        if city.id == cityId{
//                            CountryObjectAip.GeCountryById(id: city.country_id ?? "") { country in
//                                self.Location.text = "\(country.ku_name ?? "")-\(city.ku_name ?? "")".uppercased()
//                                self.Location.font = UIFont(name: "PeshangDes2", size: 11)!
//                            }
//                        }
//                    }
//                }
//            }
//        }
        
        
        self.GetYATop.constant = 0
        self.GetYAHeight.constant = 0
        self.GetYAView.isHidden = true
        
  
        
        self.EditProfile.isEnabled = true
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
//    @IBOutlet weak var GetYABottom: NSLayoutConstraint!
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
    
    var ProductArrayForDeleteAccount : [EstateObject] = []
    func GetMyEstatesForDeleteAccount(){
        if let FireId = UserDefaults.standard.string(forKey: "UserId"){
            OfficeAip.GetOfficeById(Id: FireId) { office in
                ProductAip.GetMyEstates(office_id: office.id ?? "") { estates in
                    if estates.archived != "1"{
                        self.ProductArrayForDeleteAccount.append(estates)
                    }
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
    
    
    
    @IBOutlet weak var DeleteAccountView: UIView!
    @IBAction func DeleteAccount(_ sender: Any) {
        if CheckInternet.Connection(){
            UIView.animate(withDuration: 0.3) {
                self.InternetViewHeight.constant = 0
                self.InternetConnectionView.isHidden = true
                self.view.layoutIfNeeded()
            }
            
            var title  = ""
            var mess   = ""
            var note    = ""
            var note_mess = ""
            var sure   = ""
            var delete = ""
            var cancel = ""
            var no     = ""
            
            if XLanguage.get() == .English{
                title  = "Delete Account"
                mess   = "Are you sure you want to delete your account?"
                sure   = "Sure"
                note    = "Warning"
                note_mess = "After deleting your account, your estates and information will be Delete, this action cannot be undo."
                delete = "Delete"
                cancel = "Cancel"
                no     = "No"
            }else if XLanguage.get() == .Kurdish{
                title  = "سڕینەوەی ئەکاونت"
                mess   = "ئایا دڵنیای کە دەتەوێت ئەکاونتەکەت بسڕیتەوە؟"
                sure   = "دڵنیابە"
                note    = "ئاگادارکردنەوە"
                note_mess = "دوای سڕینەوەی ئەکاونتەکەت، ئیستێت و زانیارییەکانت دەبێتە سڕینەوە، ئەم کردارە ناتوانرێت پاشەکشە بکرێت."
                delete = "سڕینەوە"
                cancel = "هەڵوەشاندنەوە"
                no     = "نا"
            }else if XLanguage.get() == .Arabic {
                title  = "حذف الحساب"
                mess   = "هل أنت متأكد أنك تريد حذف حسابك؟"
                sure   = "متأكد"
                note   = "تحذير"
                note_mess = "بعد حذف حسابك، سيتم حذف ممتلكاتك ومعلوماتك، هذا الإجراء لا يمكن التراجع عنه."
                delete = "حذف"
                cancel = "إلغاء"
                no     = "لا"
            }else if XLanguage.get() == .Hebrew {
                title  = "מחק חשבון"
                mess   = "האם אתה בטוח שברצונך למחוק את החשבון שלך?"
                sure   = "בטוח"
                note   = "אזהרה"
                note_mess = "לאחר מחיקת החשבון שלך, הנכסים והמידע שלך ימחקו, לא ניתן לבטל פעולה זו."
                delete = "מחק"
                cancel = "בטל"
                no     = "לא"
            }else if XLanguage.get() == .Chinese {
                title  = "删除账户"
                mess   = "您确定要删除您的账户吗？"
                sure   = "确定"
                note   = "警告"
                note_mess = "删除账户后，您的财产和信息将被删除，此操作不能撤销。"
                delete = "删除"
                cancel = "取消"
                no     = "不"
            }else if XLanguage.get() == .Hindi {
                title  = "खाता हटाएं"
                mess   = "क्या आप वाकई अपना खाता हटाना चाहते हैं?"
                sure   = "निश्चित"
                note   = "चेतावनी"
                note_mess = "खाता हटाने के बाद, आपकी संपत्ति और जानकारी हटा दी जाएगी, इस क्रिया को उलटा नहीं किया जा सकता।"
                delete = "हटाएं"
                cancel = "रद्द करें"
                no     = "नहीं"
            }else if XLanguage.get() == .Portuguese {
                title  = "Excluir Conta"
                mess   = "Tem certeza de que deseja excluir sua conta?"
                sure   = "Certo"
                note   = "Aviso"
                note_mess = "Após excluir sua conta, seus bens e informações serão excluídos, esta ação não pode ser desfeita."
                delete = "Excluir"
                cancel = "Cancelar"
                no     = "Não"
            }else if XLanguage.get() == .Swedish {
                title  = "Radera konto"
                mess   = "Är du säker på att du vill radera ditt konto?"
                sure   = "Säker"
                note   = "Varning"
                note_mess = "Efter att ditt konto har raderats kommer dina tillgångar och information att raderas, denna åtgärd kan inte ångras."
                delete = "Radera"
                cancel = "Avbryt"
                no     = "Nej"
            }else if XLanguage.get() == .Greek {
                title  = "Διαγραφή Λογαριασμού"
                mess   = "Είστε σίγουροι ότι θέλετε να διαγράψετε τον λογαριασμό σας;"
                sure   = "Σίγουρος"
                note   = "Προειδοποίηση"
                note_mess = "Μετά τη διαγραφή του λογαριασμού σας, οι περιουσίες και οι πληροφορίες σας θα διαγραφούν, αυτή η ενέργεια δεν μπορεί να αναιρεθεί."
                delete = "Διαγραφή"
                cancel = "Ακύρωση"
                no     = "Όχι"
            }else if XLanguage.get() == .Russian {
                title  = "Удалить аккаунт"
                mess   = "Вы уверены, что хотите удалить свой аккаунт?"
                sure   = "Уверен"
                note   = "Внимание"
                note_mess = "После удаления вашего аккаунта, ваши состояния и информация будут удалены, это действие нельзя отменить."
                delete = "Удалить"
                cancel = "Отмена"
                no     = "Нет"
            }else if XLanguage.get() == .Dutch {
                title  = "Account Verwijderen"
                mess   = "Weet u zeker dat u uw account wilt verwijderen?"
                sure   = "Zeker"
                note   = "Waarschuwing"
                note_mess = "Na het verwijderen van uw account worden uw eigendommen en informatie Verwijderd, deze actie kan niet ongedaan worden gemaakt."
                delete = "Verwijderen"
                cancel = "Annuleren"
                no     = "Nee"
            }else if XLanguage.get() == .French {
                title  = "Supprimer le compte"
                mess   = "Êtes-vous sûr de vouloir supprimer votre compte ?"
                sure   = "Sûr"
                note   = "Attention"
                note_mess = "Après la suppression de votre compte, vos biens et informations seront Supprimés, cette action ne peut pas être annulée."
                delete = "Supprimer"
                cancel = "Annuler"
                no     = "Non"
            }else if XLanguage.get() == .Spanish {
                title  = "Eliminar Cuenta"
                mess   = "¿Estás seguro de que quieres eliminar tu cuenta?"
                sure   = "Seguro"
                note   = "Advertencia"
                note_mess = "Después de eliminar tu cuenta, tus estados e información serán Eliminados, esta acción no puede ser deshecha."
                delete = "Eliminar"
                cancel = "Cancelar"
                no     = "No"
            }else if XLanguage.get() == .German {
                title  = "Konto löschen"
                mess   = "Sind Sie sicher, dass Sie Ihr Konto löschen möchten?"
                sure   = "Sicher"
                note   = "Warnung"
                note_mess = "Nach dem Löschen Ihres Kontos werden Ihre Vermögenswerte und Informationen gelöscht, diese Aktion kann nicht rückgängig gemacht werden."
                delete = "Löschen"
                cancel = "Abbrechen"
                no     = "Nein"
            }
            
            
            let myAlert = UIAlertController(title: title, message: mess, preferredStyle: UIAlertController.Style.alert)
            myAlert.addAction(UIAlertAction(title: sure, style: .default, handler: { (UIAlertActionn) in
                
                let myAlertin = UIAlertController(title: note, message: note_mess, preferredStyle: UIAlertController.Style.alert)
                myAlertin.addAction(UIAlertAction(title: delete, style: .default, handler: { (UIAlertActiokn) in
                    if let officeId = UserDefaults.standard.string(forKey: "OfficeId"){
                        OfficeAip.Remov(id: officeId) { deleted in
                            if self.ProductArrayForDeleteAccount.count != 0{
                                for estate in self.ProductArrayForDeleteAccount{
                                    ProductAip.Remov(id: estate.id ?? "") { deleted in }
                                }
                            }
                        }
                        
                    }
                    UserDefaults.standard.set(false, forKey: "Login")
                    UserDefaults.standard.set("", forKey: "UserId")
                    UserDefaults.standard.set("", forKey: "PhoneNumber")
                    UserDefaults.standard.set("", forKey: "OfficeId")
                    UserDefaults.standard.set("", forKey: "UserType")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "GoToApp")
                    vc!.modalPresentationStyle = .overFullScreen
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true)
                }))
                myAlertin.addAction(UIAlertAction(title: cancel, style: .cancel, handler: nil))
                self.present(myAlertin, animated: true, completion: nil)
                
            }))
            myAlert.addAction(UIAlertAction(title: no, style: .cancel, handler: nil))
            self.present(myAlert, animated: true, completion: nil)
        }else{
            UIView.animate(withDuration: 0.3) {
                self.InternetViewHeight.constant = 20
                self.InternetConnectionView.isHidden = false
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    
    
    
    
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
                }else if XLanguage.get() == .Arabic{
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "مفعلة"
                        self.NotificationLable.font =  UIFont(name: "PeshangDes2", size: 11)!
                    }
                }else if XLanguage.get() == .English {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "ON"
                    }
                } else if XLanguage.get() == .Dutch {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "AAN" // Dutch for "ON"
                    }
                } else if XLanguage.get() == .French {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "ACTIVÉ" // French for "ON"
                    }
                } else if XLanguage.get() == .Spanish {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "ENCENDIDO" // Spanish for "ON"
                    }
                } else if XLanguage.get() == .German {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "EIN" // German for "ON"
                    }
                } else if XLanguage.get() == .Hebrew {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "פעיל" // Hebrew for "ON"
                    }
                } else if XLanguage.get() == .Chinese {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "开" // Simplified Chinese for "ON"
                    }
                } else if XLanguage.get() == .Hindi {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "चालू" // Hindi for "ON"
                    }
                } else if XLanguage.get() == .Portuguese {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "LIGADO" // Portuguese for "ON"
                    }
                } else if XLanguage.get() == .Swedish {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "PÅ" // Swedish for "ON"
                    }
                } else if XLanguage.get() == .Greek {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "ΕΝΕΡΓΟΠΟΙΗΜΈΝΟ" // Greek for "ON"
                    }
                } else if XLanguage.get() == .Russian {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "ВКЛ" // Russian for "ON"
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
                }else if XLanguage.get() == .Arabic{
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "غیر مفعلة"
                        self.NotificationLable.font =  UIFont(name: "PeshangDes2", size: 11)!
                    }
                }else if XLanguage.get() == .Dutch {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "UIT" // Dutch for "OFF"
                    }
                } else if XLanguage.get() == .French {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "DÉSACTIVÉ" // French for "OFF"
                    }
                } else if XLanguage.get() == .Spanish {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "APAGADO" // Spanish for "OFF"
                    }
                } else if XLanguage.get() == .German {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "AUS" // German for "OFF"
                    }
                } else if XLanguage.get() == .Hebrew {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "כבוי" // Hebrew for "OFF"
                    }
                } else if XLanguage.get() == .Chinese {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "关" // Simplified Chinese for "OFF"
                    }
                } else if XLanguage.get() == .Hindi {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "बंद" // Hindi for "OFF"
                    }
                } else if XLanguage.get() == .Portuguese {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "DESLIGADO" // Portuguese for "OFF"
                    }
                } else if XLanguage.get() == .Swedish {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "AV" // Swedish for "OFF"
                    }
                } else if XLanguage.get() == .Greek {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "ΑΠΕΝΕΡΓΟΠΟΙΗΜΈΝΟ" // Greek for "OFF"
                    }
                } else if XLanguage.get() == .Russian {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "ВЫКЛ" // Russian for "OFF"
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
        
//        
//        if XLanguage.get() == .English{
//            //self.Location.text = UserDefaults.standard.string(forKey: "CityName")?.uppercased() ?? ""
//            self.Location.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
//        }else if XLanguage.get() == .Kurdish{
//            //self.Location.text = UserDefaults.standard.string(forKey: "CityName")?.uppercased() ?? ""
//            self.Location.font = UIFont(name: "PeshangDes2", size: 11)!
//        }else{
//            //self.Location.text = UserDefaults.standard.string(forKey: "CityName")?.uppercased() ?? ""
//            self.Location.font = UIFont(name: "PeshangDes2", size: 10)!
//        }
        
        GetCity()
       
        if UserDefaults.standard.bool(forKey: "Login") == false {
            if XLanguage.get() == .Kurdish{
                self.LoginOrLogoutLable.text = "چونه‌ ژووره‌وه‌"
                self.LoginOrLogoutLable.font = UIFont(name: "PeshangDes2", size: 14)!
            }else if XLanguage.get() == .English{
                self.LoginOrLogoutLable.text = "LOGIN"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            }else if XLanguage.get() == .Arabic{
                self.LoginOrLogoutLable.text = "تسجيل الدخول"
                self.LoginOrLogoutLable.font = UIFont(name: "PeshangDes2", size: 14)!
            }else if XLanguage.get() == .Dutch {
                self.LoginOrLogoutLable.text = "INLOGGEN"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .French {
                self.LoginOrLogoutLable.text = "CONNEXION"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Spanish {
                self.LoginOrLogoutLable.text = "INICIAR SESIÓN"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .German {
                self.LoginOrLogoutLable.text = "ANMELDEN"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Hebrew {
                self.LoginOrLogoutLable.text = "התחברות"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Chinese {
                self.LoginOrLogoutLable.text = "登录"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Hindi {
                self.LoginOrLogoutLable.text = "लॉग इन करें"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Portuguese {
                self.LoginOrLogoutLable.text = "ENTRAR"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Swedish {
                self.LoginOrLogoutLable.text = "LOGGA IN"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Greek {
                self.LoginOrLogoutLable.text = "ΣΥΝΔΕΣΗ"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Russian {
                self.LoginOrLogoutLable.text = "ВХОД"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            }
            
            self.LoginImage.image = UIImage(named: "vuesax-bold-login")
            self.ProfileInfoStackView.isHidden = true
            self.DeleteAccountView.isHidden = true
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
            }else  if XLanguage.get() == .Arabic{
                self.FavoriteItems.text = "0 عناصر"
                self.ViewdItems.text = "0 عناصر"
                self.ViewdItems.font =  UIFont(name: "PeshangDes2", size: 10)!
                self.FavoriteItems.font =  UIFont(name: "PeshangDes2", size: 10)!
            }else if XLanguage.get() == .Dutch {
                self.ViewdItems.text = "0 ITEMS"
                self.FavoriteItems.text = "0 ITEMS"
                self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
            } else if XLanguage.get() == .French {
                self.ViewdItems.text = "0 ARTICLES"
                self.FavoriteItems.text = "0 ARTICLES"
                self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
            } else if XLanguage.get() == .Spanish {
                self.ViewdItems.text = "0 ARTÍCULOS"
                self.FavoriteItems.text = "0 ARTÍCULOS"
                self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
            } else if XLanguage.get() == .German {
                self.ViewdItems.text = "0 ARTIKEL"
                self.FavoriteItems.text = "0 ARTIKEL"
                self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
            } else if XLanguage.get() == .Hebrew {
                self.ViewdItems.text = "0 פריטים"
                self.FavoriteItems.text = "0 פריטים"
                self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
            } else if XLanguage.get() == .Chinese {
                self.ViewdItems.text = "0 项"
                self.FavoriteItems.text = "0 项"
                self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
            } else if XLanguage.get() == .Hindi {
                self.ViewdItems.text = "0 वस्तुएँ"
                self.FavoriteItems.text = "0 वस्तुएँ"
                self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
            } else if XLanguage.get() == .Portuguese {
                self.ViewdItems.text = "0 ITENS"
                self.FavoriteItems.text = "0 ITENS"
                self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
            } else if XLanguage.get() == .Swedish {
                self.ViewdItems.text = "0 FÖREMÅL"
                self.FavoriteItems.text = "0 FÖREMÅL"
                self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
            } else if XLanguage.get() == .Greek {
                self.ViewdItems.text = "0 ΑΝΤΙΚΕΊΜΕΝΑ"
                self.FavoriteItems.text = "0 ΑΝΤΙΚΕΊΜΕΝΑ"
                self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
            } else if XLanguage.get() == .Russian {
                self.ViewdItems.text = "0 ПРЕДМЕТОВ"
                self.FavoriteItems.text = "0 ПРЕДМЕТОВ"
                self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
            }

            
            
        }else{print("is logined-----------------")
            GetMyEstatesForDeleteAccount()
            if XLanguage.get() == .Kurdish{
                self.LoginOrLogoutLable.text = "چوونە دەرەوە"
                self.LoginOrLogoutLable.font = UIFont(name: "PeshangDes2", size: 14)!
            }else if XLanguage.get() == .English{
                self.LoginOrLogoutLable.text = "LOGOUT"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            }else if XLanguage.get() == .Arabic{
                self.LoginOrLogoutLable.text = "تسجيل خروج"
                self.LoginOrLogoutLable.font = UIFont(name: "PeshangDes2", size: 14)!
            }else if XLanguage.get() == .Dutch {
                self.LoginOrLogoutLable.text = "UITLOGGEN"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .French {
                self.LoginOrLogoutLable.text = "DÉCONNEXION"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Spanish {
                self.LoginOrLogoutLable.text = "CERRAR SESIÓN"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .German {
                self.LoginOrLogoutLable.text = "ABMELDEN"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Hebrew {
                self.LoginOrLogoutLable.text = "התנתקות"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Chinese {
                self.LoginOrLogoutLable.text = "登出"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Hindi {
                self.LoginOrLogoutLable.text = "लॉग आउट"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Portuguese {
                self.LoginOrLogoutLable.text = "SAIR"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Swedish {
                self.LoginOrLogoutLable.text = "LOGGA UT"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Greek {
                self.LoginOrLogoutLable.text = "ΑΠΟΣΥΝΔΕΣΗ"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Russian {
                self.LoginOrLogoutLable.text = "ВЫЙТИ"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            }
            
            self.EditProfile.isEnabled = false
            self.DeleteAccountView.isHidden = false
            self.GetYATop.constant = 15
            //self.GetYABottom.constant = 12
            self.GetYAHeight.constant = 40
            self.GetYAView.isHidden = false
            
            self.Name.layer.cornerRadius = 5
            self.Phone.layer.cornerRadius = 3
            
            if let FireId = UserDefaults.standard.string(forKey: "UserId"){print("=-=-=-=-=-=-=-1111111    \(FireId)")
                if let officeId = UserDefaults.standard.string(forKey: "OfficeId"){print("=-=-=-=-=-=-=-2222222    \(officeId)")
                    OfficeAip.GetOffice(ID: officeId) { [self] office in
                        if office.type_id == "h9nFfUrHgSwIg17uRwTD"{print("is office-----------------1111 \(office.type_id ?? "")")
                            self.ProfileRightImage.isHidden = false
                            self.Phone.isHidden = false
                            self.LoginImage.image = UIImage(named: "logout5")
                            self.ProfileInfoStackView.isHidden = false
                            self.ProfileInfoStackViewLayout.constant = 55
                            self.Profileimageheight.constant = 55
                            self.AddPropertyView.alpha = 1
                            self.ViewPropertyVicew.alpha = 1
                            self.ViewditemView.alpha = 1
                            self.FavoriteItemsView.alpha = 1
                            self.ViewdItemAction.isEnabled = true
                            self.MyPropertiesAction.isEnabled = true
                            self.AddPropetiesAction.isEnabled = true
                            self.FavoriteItemAction.isEnabled = true
                            
                            
                            if office.name == ""{
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
                            
                            

                            self.ProfileRightImage.isHidden = true
                            
                            
       
                            
                            
                            
                            self.EditProfile.isEnabled = true
                            self.AddPropertyView.isHidden = false
                            self.ViewPropertyVicew.isHidden = false
                            self.ProfileRightImage.isHidden = false
                            OfficeAip.GetOfficeById(Id: FireId) { office in
                                    self.Phone.isHidden = false
                                    let url = URL(string: office.ImageURL ?? "")
                                    self.Image.sd_setImage(with: url, placeholderImage: UIImage(named: "logoPlace"))
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

                            self.ProfileRightImage.isHidden = true
                            
                            
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
                            for i in self.AllEstate{print("=====")
                                if i.id == Item.estate_id{
                                    ViewdItemCount = ViewdItemCount + 1
                                    self.ViewdItemsEstate.append(i)
                                }
                            }
                            
                            
                            print("=====")
                
                                self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                                if XLanguage.get() == .Kurdish{
                                    self.ViewdItems.text = "\(ViewdItemCount) بینراو"
                                    self.ViewdItems.font = UIFont(name: "PeshangDes2", size: 11)!
                                } else if XLanguage.get() == .Arabic{
                                    let itemText = ViewdItemCount == 1 ? "عناصر" : "عنصر"
                                    self.ViewdItems.text = "\(ViewdItemCount) \(itemText)"
                                    self.ViewdItems.font = UIFont(name: "PeshangDes2", size: 11)!
                                }else if XLanguage.get() == .English {
                                    let itemText = ViewdItemCount == 1 ? "ITEM" : "ITEMS"
                                    self.ViewdItems.text = "\(ViewdItemCount) \(itemText)"
                                } else if XLanguage.get() == .Dutch {
                                    let itemText = ViewdItemCount == 1 ? "ITEM" : "ITEMS"
                                    self.ViewdItems.text = "\(ViewdItemCount) \(itemText)"
                                } else if XLanguage.get() == .French {
                                    let itemText = ViewdItemCount == 1 ? "ARTICLE" : "ARTICLES"
                                    self.ViewdItems.text = "\(ViewdItemCount) \(itemText)"
                                } else if XLanguage.get() == .Spanish {
                                    let itemText = ViewdItemCount == 1 ? "ARTÍCULO" : "ARTÍCULOS"
                                    self.ViewdItems.text = "\(ViewdItemCount) \(itemText)"
                                } else if XLanguage.get() == .German {
                                    let itemText = ViewdItemCount == 1 ? "ARTIKEL" : "ARTIKEL"
                                    self.ViewdItems.text = "\(ViewdItemCount) \(itemText)"
                                } else if XLanguage.get() == .Hebrew {
                                    let itemText = ViewdItemCount == 1 ? "פריט" : "פריטים"
                                    self.ViewdItems.text = "\(ViewdItemCount) \(itemText)"
                                } else if XLanguage.get() == .Chinese {
                                    self.ViewdItems.text = "\(ViewdItemCount) 项"
                                } else if XLanguage.get() == .Hindi {
                                    let itemText = ViewdItemCount == 1 ? "आइटम" : "आइटम्स"
                                    self.ViewdItems.text = "\(ViewdItemCount) \(itemText)"
                                } else if XLanguage.get() == .Portuguese {
                                    let itemText = ViewdItemCount == 1 ? "ITEM" : "ITENS"
                                    self.ViewdItems.text = "\(ViewdItemCount) \(itemText)"
                                } else if XLanguage.get() == .Swedish {
                                    let itemText = ViewdItemCount == 1 ? "FÖREMÅL" : "FÖREMÅL"
                                    self.ViewdItems.text = "\(ViewdItemCount) \(itemText)"
                                } else if XLanguage.get() == .Greek {
                                    let itemText = ViewdItemCount == 1 ? "ΑΝΤΙΚΕΊΜΕΝΟ" : "ΑΝΤΙΚΕΊΜΕΝΑ"
                                    self.ViewdItems.text = "\(ViewdItemCount) \(itemText)"
                                } else if XLanguage.get() == .Russian {
                                    let itemText = ViewdItemCount == 1 ? "ПРЕДМЕТ" : "ПРЕДМЕТЫ"
                                    self.ViewdItems.text = "\(ViewdItemCount) \(itemText)"
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
                            
                            self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                            if XLanguage.get() == .Kurdish{
                                self.FavoriteItems.text = "\(FavoriteItemCount) خوازراو"
                                self.FavoriteItems.font = UIFont(name: "PeshangDes2", size: 11)!
                            } else if XLanguage.get() == .Arabic{
                                let itemText = FavoriteItemCount == 1 ? "عناصر" : "عنصر"
                                self.FavoriteItems.text = "\(FavoriteItemCount) \(itemText)"
                                self.FavoriteItems.font = UIFont(name: "PeshangDes2", size: 11)!
                            }else if XLanguage.get() == .English {
                                let itemText = FavoriteItemCount == 1 ? "ITEM" : "ITEMS"
                                self.FavoriteItems.text = "\(FavoriteItemCount) \(itemText)"
                            } else if XLanguage.get() == .Dutch {
                                let itemText = FavoriteItemCount == 1 ? "ITEM" : "ITEMS"
                                self.FavoriteItems.text = "\(FavoriteItemCount) \(itemText)"
                            } else if XLanguage.get() == .French {
                                let itemText = FavoriteItemCount == 1 ? "ARTICLE" : "ARTICLES"
                                self.FavoriteItems.text = "\(FavoriteItemCount) \(itemText)"
                            } else if XLanguage.get() == .Spanish {
                                let itemText = FavoriteItemCount == 1 ? "ARTÍCULO" : "ARTÍCULOS"
                                self.FavoriteItems.text = "\(FavoriteItemCount) \(itemText)"
                            } else if XLanguage.get() == .German {
                                let itemText = FavoriteItemCount == 1 ? "ARTIKEL" : "ARTIKEL"
                                self.FavoriteItems.text = "\(FavoriteItemCount) \(itemText)"
                            } else if XLanguage.get() == .Hebrew {
                                let itemText = FavoriteItemCount == 1 ? "פריט" : "פריטים"
                                self.FavoriteItems.text = "\(FavoriteItemCount) \(itemText)"
                            } else if XLanguage.get() == .Chinese {
                                self.FavoriteItems.text = "\(FavoriteItemCount) 项"
                            } else if XLanguage.get() == .Hindi {
                                let itemText = FavoriteItemCount == 1 ? "आइटम" : "आइटम्स"
                                self.FavoriteItems.text = "\(FavoriteItemCount) \(itemText)"
                            } else if XLanguage.get() == .Portuguese {
                                let itemText = FavoriteItemCount == 1 ? "ITEM" : "ITENS"
                                self.FavoriteItems.text = "\(FavoriteItemCount) \(itemText)"
                            } else if XLanguage.get() == .Swedish {
                                let itemText = FavoriteItemCount == 1 ? "FÖREMÅL" : "FÖREMÅL"
                                self.FavoriteItems.text = "\(FavoriteItemCount) \(itemText)"
                            } else if XLanguage.get() == .Greek {
                                let itemText = FavoriteItemCount == 1 ? "ΑΝΤΙΚΕΊΜΕΝΟ" : "ΑΝΤΙΚΕΊΜΕΝΑ"
                                self.FavoriteItems.text = "\(FavoriteItemCount) \(itemText)"
                            } else if XLanguage.get() == .Russian {
                                let itemText = FavoriteItemCount == 1 ? "ПРЕДМЕТ" : "ПРЕДМЕТЫ"
                                self.FavoriteItems.text = "\(FavoriteItemCount) \(itemText)"
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
        //fetchRemoteConfig()
        
        if let url = URL(string: "https://apps.apple.com/us/app/sypo/id6479270481"),
          UIApplication.shared.canOpenURL(url) {
             if #available(iOS 10, *) {
               UIApplication.shared.open(url, options: [:], completionHandler:nil)
              } else {
                  UIApplication.shared.openURL(url)
              }
          } else { }
        
        
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
                    self.messagee = "New update is available"
                    self.Action = "Update"
                    self.cancel = "Not now"
                }else if XLanguage.get() == .Arabic{
                    self.titlee = "تنبيه"
                    self.messagee = "يتوفر تحديث جديد"
                    self.Action = "تحديث"
                    self.cancel = "ليس الان"
                }else if XLanguage.get() == .Dutch {
                    self.titlee = "Waarschuwing"
                    self.messagee = "Nieuwe update beschikbaar"
                    self.Action = "Bijwerken"
                    self.cancel = "Niet nu"
                } else if XLanguage.get() == .French {
                    self.titlee = "Avertissement"
                    self.messagee = "Nouvelle mise à jour disponible"
                    self.Action = "Mettre à jour"
                    self.cancel = "Pas maintenant"
                } else if XLanguage.get() == .Spanish {
                    self.titlee = "Advertencia"
                    self.messagee = "Nueva actualización disponible"
                    self.Action = "Actualizar"
                    self.cancel = "Ahora no"
                } else if XLanguage.get() == .German {
                    self.titlee = "Warnung"
                    self.messagee = "Neues Update verfügbar"
                    self.Action = "Aktualisieren"
                    self.cancel = "Nicht jetzt"
                } else if XLanguage.get() == .Hebrew {
                    self.titlee = "אזהרה"
                    self.messagee = "עדכון חדש זמין"
                    self.Action = "עדכון"
                    self.cancel = "לא עכשיו"
                } else if XLanguage.get() == .Chinese {
                    self.titlee = "警告"
                    self.messagee = "有新的更新可用"
                    self.Action = "更新"
                    self.cancel = "暂不"
                } else if XLanguage.get() == .Hindi {
                    self.titlee = "चेतावनी"
                    self.messagee = "नया अपडेट उपलब्ध है"
                    self.Action = "अपडेट करें"
                    self.cancel = "अभी नहीं"
                } else if XLanguage.get() == .Portuguese {
                    self.titlee = "Aviso"
                    self.messagee = "Nova atualização disponível"
                    self.Action = "Atualizar"
                    self.cancel = "Agora não"
                } else if XLanguage.get() == .Swedish {
                    self.titlee = "Varning"
                    self.messagee = "Ny uppdatering tillgänglig"
                    self.Action = "Uppdatera"
                    self.cancel = "Inte nu"
                } else if XLanguage.get() == .Greek {
                    self.titlee = "Προειδοποίηση"
                    self.messagee = "Διαθέσιμη νέα ενημέρωση"
                    self.Action = "Ενημέρωση"
                    self.cancel = "Όχι τώρα"
                } else if XLanguage.get() == .Russian {
                    self.titlee = "Предупреждение"
                    self.messagee = "Доступно новое обновление"
                    self.Action = "Обновить"
                    self.cancel = "Не сейчас"
                }
                let alertController = UIAlertController(title: "", message: self.messagee, preferredStyle: .alert)
                let okAction = UIAlertAction(title:  self.Action, style: UIAlertAction.Style.default) { _ in
                    if let url = URL(string: "https://apps.apple.com/us/app/sypo/id6479270481"),
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
        }else{
            DispatchQueue.main.async {
            if XLanguage.get() == .Kurdish{
                self.titlee = "نوێکردنەوە"
                self.messagee = "ئەپەکەت نوێ بووەتەوە"
                self.Action = "باشە"
            }else if XLanguage.get() == .English{
                self.titlee = "Update"
                self.messagee = "Your app is up to date"
                self.Action = "Ok"
            }else if XLanguage.get() == .Arabic{
                self.titlee = "تحديث"
                self.messagee = "التطبيق محدث"
                self.Action = "حسنًا"
            }else if XLanguage.get() == .Dutch {
                self.titlee = "Update"
                self.messagee = "Uw app is up-to-date"
                self.Action = "Oké"
            } else if XLanguage.get() == .French {
                self.titlee = "Mise à jour"
                self.messagee = "Votre application est à jour"
                self.Action = "Ok"
            } else if XLanguage.get() == .Spanish {
                self.titlee = "Actualizar"
                self.messagee = "Tu aplicación está actualizada"
                self.Action = "Ok"
            } else if XLanguage.get() == .German {
                self.titlee = "Aktualisieren"
                self.messagee = "Ihre App ist auf dem neuesten Stand"
                self.Action = "Ok"
            } else if XLanguage.get() == .Hebrew {
                self.titlee = "עדכון"
                self.messagee = "האפליקציה שלך מעודכנת"
                self.Action = "אוקיי"
            } else if XLanguage.get() == .Chinese {
                self.titlee = "更新"
                self.messagee = "您的应用程序是最新的"
                self.Action = "好的"
            } else if XLanguage.get() == .Hindi {
                self.titlee = "अपडेट"
                self.messagee = "आपका ऐप अपडेटेड है"
                self.Action = "ठीक है"
            } else if XLanguage.get() == .Portuguese {
                self.titlee = "Atualização"
                self.messagee = "Seu aplicativo está atualizado"
                self.Action = "Ok"
            } else if XLanguage.get() == .Swedish {
                self.titlee = "Uppdatera"
                self.messagee = "Din app är uppdaterad"
                self.Action = "Ok"
            } else if XLanguage.get() == .Greek {
                self.titlee = "Ενημέρωση"
                self.messagee = "Η εφαρμογή σας είναι ενημερωμένη"
                self.Action = "Οκ"
            } else if XLanguage.get() == .Russian {
                self.titlee = "Обновление"
                self.messagee = "Ваше приложение обновлено"
                self.Action = "Ок"
            }
            let alertController = UIAlertController(title: "", message: self.messagee, preferredStyle: .alert)
            let okAction = UIAlertAction(title:  self.Action, style: UIAlertAction.Style.default) { _ in
                alertController.dismiss(animated: true)
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        }
    }
    
    
    
    
    
   
    
    var logoutT = ""
    var logoutM = ""
    @IBAction func LoginOrLogout(_ sender: Any) {
        if !CheckInternet.Connection(){
            if XLanguage.get() == .English{
                let ac = UIAlertController(title: "Error", message: "Please check your internet connection.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            }else if XLanguage.get() == .Arabic{
                let ac = UIAlertController(title: "خطأ", message: "الرجاء التحقق من اتصال الانترنت الخاص بك.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "نعم", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            }else if XLanguage.get() == .Kurdish{
                let ac = UIAlertController(title: "هەڵە", message: "تکایە هێڵی ئینتەرنێتەکەت بپشکنە.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "باشە", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            }else if XLanguage.get() == .Dutch {
                let ac = UIAlertController(title: "Fout", message: "Controleer uw internetverbinding.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .French {
                let ac = UIAlertController(title: "Erreur", message: "Veuillez vérifier votre connexion internet.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Spanish {
                let ac = UIAlertController(title: "Error", message: "Por favor, verifica tu conexión a internet.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .German {
                let ac = UIAlertController(title: "Fehler", message: "Bitte überprüfen Sie Ihre Internetverbindung.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Hebrew {
                let ac = UIAlertController(title: "שגיאה", message: "אנא בדוק את חיבור האינטרנט שלך.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "אישור", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Chinese {
                let ac = UIAlertController(title: "错误", message: "请检查您的互联网连接。", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "确定", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Hindi {
                let ac = UIAlertController(title: "त्रुटि", message: "कृपया अपना इंटरनेट कनेक्शन जाँच लें।", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "ठीक है", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Portuguese {
                let ac = UIAlertController(title: "Erro", message: "Por favor, verifique sua conexão com a internet.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Swedish {
                let ac = UIAlertController(title: "Fel", message: "Vänligen kontrollera din internetanslutning.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Greek {
                let ac = UIAlertController(title: "Σφάλμα", message: "Παρακαλώ ελέγξτε τη σύνδεσή σας στο διαδίκτυο.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "ΟΚ", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Russian {
                let ac = UIAlertController(title: "Ошибка", message: "Пожалуйста, проверьте ваше интернет-соединение.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "ОК", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            }
        }else{
        
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
            }else if XLanguage.get() == .Arabic{
                self.logoutT = "تسجيل خروج"
                self.logoutM = "هل أنت متأكد أنك تريد تسجيل الخروج؟"
                self.Action = "نعم"
                self.cancel = "لا"
            }else if XLanguage.get() == .Dutch {
                self.logoutT = "Uitloggen"
                self.logoutM = "Weet je zeker dat je wilt uitloggen?"
                self.Action = "Ja"
                self.cancel = "Nee"
            } else if XLanguage.get() == .French {
                self.logoutT = "Déconnexion"
                self.logoutM = "Êtes-vous sûr de vouloir vous déconnecter ?"
                self.Action = "Oui"
                self.cancel = "Non"
            } else if XLanguage.get() == .Spanish {
                self.logoutT = "Cerrar sesión"
                self.logoutM = "¿Estás seguro de que quieres cerrar sesión?"
                self.Action = "Sí"
                self.cancel = "No"
            } else if XLanguage.get() == .German {
                self.logoutT = "Abmelden"
                self.logoutM = "Sind Sie sicher, dass Sie sich abmelden möchten?"
                self.Action = "Ja"
                self.cancel = "Nein"
            } else if XLanguage.get() == .Hebrew {
                self.logoutT = "התנתקות"
                self.logoutM = "האם אתה בטוח שברצונך להתנתק?"
                self.Action = "כן"
                self.cancel = "לא"
            } else if XLanguage.get() == .Chinese {
                self.logoutT = "登出"
                self.logoutM = "您确定要登出吗？"
                self.Action = "是"
                self.cancel = "否"
            } else if XLanguage.get() == .Hindi {
                self.logoutT = "लॉग आउट"
                self.logoutM = "क्या आप वाकई लॉग आउट करना चाहते हैं?"
                self.Action = "हाँ"
                self.cancel = "नहीं"
            } else if XLanguage.get() == .Portuguese {
                self.logoutT = "Sair"
                self.logoutM = "Tem certeza de que deseja sair?"
                self.Action = "Sim"
                self.cancel = "Não"
            } else if XLanguage.get() == .Swedish {
                self.logoutT = "Logga ut"
                self.logoutM = "Är du säker på att du vill logga ut?"
                self.Action = "Ja"
                self.cancel = "Nej"
            } else if XLanguage.get() == .Greek {
                self.logoutT = "Αποσύνδεση"
                self.logoutM = "Είστε σίγουροι ότι θέλετε να αποσυνδεθείτε;"
                self.Action = "Ναι"
                self.cancel = "Όχι"
            } else if XLanguage.get() == .Russian {
                self.logoutT = "Выход"
                self.logoutM = "Вы уверены, что хотите выйти?"
                self.Action = "Да"
                self.cancel = "Нет"
            }
            
   
            
            let myAlert = UIAlertController(title: logoutT, message: logoutM, preferredStyle: UIAlertController.Style.alert)
            myAlert.addAction(UIAlertAction(title: Action, style: .default, handler: { (UIAlertAction) in
                let firebaseAuth = Auth.auth()
                do {
                    try firebaseAuth.signOut()
                    UserDefaults.standard.set(false, forKey: "Login")
                    UserDefaults.standard.set("", forKey: "UserId")
                    UserDefaults.standard.set("", forKey: "OfficeId")
                    UserDefaults.standard.set("", forKey: "PhoneNumber")
                    UserDefaults.standard.setValue("", forKey: "CardNumner")
                    UserDefaults.standard.setValue("", forKey: "Expire")
                    UserDefaults.standard.setValue("", forKey: "CVV")
                    
                    
                    if XLanguage.get() == .Kurdish{
                        self.LoginOrLogoutLable.text = "چونه‌ ژووره‌وه‌"
                        self.LoginOrLogoutLable.font = UIFont(name: "PeshangDes2", size: 14)!
                    }else if XLanguage.get() == .English{
                        self.LoginOrLogoutLable.text = "LOGIN"
                        self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
                    }else if XLanguage.get() == .Arabic{
                        self.LoginOrLogoutLable.text = "تسجيل الدخول"
                        self.LoginOrLogoutLable.font = UIFont(name: "PeshangDes2", size: 14)!
                    }else if XLanguage.get() == .Dutch {
                        self.LoginOrLogoutLable.text = "INLOGGEN"
                        self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
                    } else if XLanguage.get() == .French {
                        self.LoginOrLogoutLable.text = "CONNEXION"
                        self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
                    } else if XLanguage.get() == .Spanish {
                        self.LoginOrLogoutLable.text = "INICIAR SESIÓN"
                        self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
                    } else if XLanguage.get() == .German {
                        self.LoginOrLogoutLable.text = "ANMELDEN"
                        self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
                    } else if XLanguage.get() == .Hebrew {
                        self.LoginOrLogoutLable.text = "התחברות"
                        self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
                    } else if XLanguage.get() == .Chinese {
                        self.LoginOrLogoutLable.text = "登录"
                        self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
                    } else if XLanguage.get() == .Hindi {
                        self.LoginOrLogoutLable.text = "लॉग इन करें"
                        self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
                    } else if XLanguage.get() == .Portuguese {
                        self.LoginOrLogoutLable.text = "ENTRAR"
                        self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
                    } else if XLanguage.get() == .Swedish {
                        self.LoginOrLogoutLable.text = "LOGGA IN"
                        self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
                    } else if XLanguage.get() == .Greek {
                        self.LoginOrLogoutLable.text = "ΣΥΝΔΕΣΗ"
                        self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
                    } else if XLanguage.get() == .Russian {
                        self.LoginOrLogoutLable.text = "ВХОД"
                        self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
                    }
                    self.LoginImage.image = UIImage(named: "vuesax-bold-login")
                    self.ProfileInfoStackView.isHidden = true
                    self.ProfileInfoStackViewLayout.constant = 0
                    self.AddPropertyView.alpha = 0.5
                    self.ViewPropertyVicew.alpha = 0.5
                    self.ViewditemView.alpha = 0.5
                    self.FavoriteItemsView.alpha = 0.5
                    self.DeleteAccountView.isHidden = true
                    
                    self.GetYATop.constant = 0
                    self.GetYAHeight.constant = 0
                    self.GetYAView.isHidden = true

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
                    }else  if XLanguage.get() == .Arabic{
                        self.FavoriteItems.text = "0 عناصر"
                        self.ViewdItems.text = "0 عناصر"
                        self.ViewdItems.font =  UIFont(name: "PeshangDes2", size: 10)!
                        self.FavoriteItems.font =  UIFont(name: "PeshangDes2", size: 10)!
                    }else if XLanguage.get() == .Dutch {
                        self.ViewdItems.text = "0 ITEMS"
                        self.FavoriteItems.text = "0 ITEMS"
                        self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                        self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                    } else if XLanguage.get() == .French {
                        self.ViewdItems.text = "0 ARTICLES"
                        self.FavoriteItems.text = "0 ARTICLES"
                        self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                        self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                    } else if XLanguage.get() == .Spanish {
                        self.ViewdItems.text = "0 ARTÍCULOS"
                        self.FavoriteItems.text = "0 ARTÍCULOS"
                        self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                        self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                    } else if XLanguage.get() == .German {
                        self.ViewdItems.text = "0 ARTIKEL"
                        self.FavoriteItems.text = "0 ARTIKEL"
                        self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                        self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                    } else if XLanguage.get() == .Hebrew {
                        self.ViewdItems.text = "0 פריטים"
                        self.FavoriteItems.text = "0 פריטים"
                        self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                        self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                    } else if XLanguage.get() == .Chinese {
                        self.ViewdItems.text = "0 项"
                        self.FavoriteItems.text = "0 项"
                        self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                        self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                    } else if XLanguage.get() == .Hindi {
                        self.ViewdItems.text = "0 वस्तुएँ"
                        self.FavoriteItems.text = "0 वस्तुएँ"
                        self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                        self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                    } else if XLanguage.get() == .Portuguese {
                        self.ViewdItems.text = "0 ITENS"
                        self.FavoriteItems.text = "0 ITENS"
                        self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                        self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                    } else if XLanguage.get() == .Swedish {
                        self.ViewdItems.text = "0 FÖREMÅL"
                        self.FavoriteItems.text = "0 FÖREMÅL"
                        self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                        self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                    } else if XLanguage.get() == .Greek {
                        self.ViewdItems.text = "0 ΑΝΤΙΚΕΊΜΕΝΑ"
                        self.FavoriteItems.text = "0 ΑΝΤΙΚΕΊΜΕΝΑ"
                        self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                        self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                    } else if XLanguage.get() == .Russian {
                        self.ViewdItems.text = "0 ПРЕДМЕТОВ"
                        self.FavoriteItems.text = "0 ПРЕДМЕТОВ"
                        self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                        self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
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
    
    @objc func LangChanged(notification: Notification){
        
        if let dict = notification.userInfo as NSDictionary? {
            if let lang = dict["Lang"]{
                self.LanguageLable.text = lang as? String
                self.LanguageLable.font =  UIFont(name: "ArialRoundedMTBold", size: 11)!
            }
        }

        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                self.NotificationLable.font =  UIFont(name: "ArialRoundedMTBold", size: 11)!
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
                }else if XLanguage.get() == .Arabic{
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "مفعلة"
                        self.NotificationLable.font =  UIFont(name: "PeshangDes2", size: 11)!
                    }
                }else if XLanguage.get() == .English {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "ON"
                    }
                } else if XLanguage.get() == .Dutch {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "AAN" // Dutch for "ON"
                    }
                } else if XLanguage.get() == .French {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "ACTIVÉ" // French for "ON"
                    }
                } else if XLanguage.get() == .Spanish {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "ENCENDIDO" // Spanish for "ON"
                    }
                } else if XLanguage.get() == .German {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "EIN" // German for "ON"
                    }
                } else if XLanguage.get() == .Hebrew {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "פעיל" // Hebrew for "ON"
                    }
                } else if XLanguage.get() == .Chinese {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "开" // Simplified Chinese for "ON"
                    }
                } else if XLanguage.get() == .Hindi {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "चालू" // Hindi for "ON"
                    }
                } else if XLanguage.get() == .Portuguese {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "LIGADO" // Portuguese for "ON"
                    }
                } else if XLanguage.get() == .Swedish {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "PÅ" // Swedish for "ON"
                    }
                } else if XLanguage.get() == .Greek {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "ΕΝΕΡΓΟΠΟΙΗΜΈΝΟ" // Greek for "ON"
                    }
                } else if XLanguage.get() == .Russian {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "ВКЛ" // Russian for "ON"
                    }
                }
                
            } else {
                self.NotificationLable.font =  UIFont(name: "ArialRoundedMTBold", size: 11)!
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
                }else if XLanguage.get() == .Arabic{
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "غیر مفعلة"
                        self.NotificationLable.font =  UIFont(name: "PeshangDes2", size: 11)!
                    }
                }else if XLanguage.get() == .Dutch {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "UIT" // Dutch for "OFF"
                    }
                } else if XLanguage.get() == .French {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "DÉSACTIVÉ" // French for "OFF"
                    }
                } else if XLanguage.get() == .Spanish {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "APAGADO" // Spanish for "OFF"
                    }
                } else if XLanguage.get() == .German {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "AUS" // German for "OFF"
                    }
                } else if XLanguage.get() == .Hebrew {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "כבוי" // Hebrew for "OFF"
                    }
                } else if XLanguage.get() == .Chinese {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "关" // Simplified Chinese for "OFF"
                    }
                } else if XLanguage.get() == .Hindi {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "बंद" // Hindi for "OFF"
                    }
                } else if XLanguage.get() == .Portuguese {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "DESLIGADO" // Portuguese for "OFF"
                    }
                } else if XLanguage.get() == .Swedish {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "AV" // Swedish for "OFF"
                    }
                } else if XLanguage.get() == .Greek {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "ΑΠΕΝΕΡΓΟΠΟΙΗΜΈΝΟ" // Greek for "OFF"
                    }
                } else if XLanguage.get() == .Russian {
                    DispatchQueue.main.async {
                        self.NotificationLable.text = "ВЫКЛ" // Russian for "OFF"
                    }
                }
            }
        }


        
        
        
        
        
        

        
        if XLanguage.get() == .Kurdish{
            self.logoutT = "چوونە دەرەوە"
            self.logoutM = "ئایا دڵنیای کە دەتەوێت دەربچیت؟"
            self.Action = "بەڵێ"
            self.cancel = "نەخێر"
            self.loadingLableMessage = "تكایه‌ چاوه‌ڕێبه‌..."
        }else if XLanguage.get() == .English{
            self.logoutT = "logout"
            self.logoutM = "Are you sure you want to logout?"
            self.Action = "Yes"
            self.cancel = "No"
            self.loadingLableMessage = "Please wait..."
        }else if XLanguage.get() == .Arabic{
            self.logoutT = "تسجيل خروج"
            self.logoutM = "هل أنت متأكد أنك تريد تسجيل الخروج؟"
            self.Action = "نعم"
            self.cancel = "لا"
            self.loadingLableMessage = "يرجى الانتظار..."
        }else if XLanguage.get() == .Dutch {
            self.logoutT = "Uitloggen"
            self.logoutM = "Weet je zeker dat je wilt uitloggen?"
            self.Action = "Ja"
            self.cancel = "Nee"
        } else if XLanguage.get() == .French {
            self.logoutT = "Déconnexion"
            self.logoutM = "Êtes-vous sûr de vouloir vous déconnecter ?"
            self.Action = "Oui"
            self.cancel = "Non"
        } else if XLanguage.get() == .Spanish {
            self.logoutT = "Cerrar sesión"
            self.logoutM = "¿Estás seguro de que quieres cerrar sesión?"
            self.Action = "Sí"
            self.cancel = "No"
        } else if XLanguage.get() == .German {
            self.logoutT = "Abmelden"
            self.logoutM = "Sind Sie sicher, dass Sie sich abmelden möchten?"
            self.Action = "Ja"
            self.cancel = "Nein"
        } else if XLanguage.get() == .Hebrew {
            self.logoutT = "התנתקות"
            self.logoutM = "האם אתה בטוח שברצונך להתנתק?"
            self.Action = "כן"
            self.cancel = "לא"
        } else if XLanguage.get() == .Chinese {
            self.logoutT = "登出"
            self.logoutM = "您确定要登出吗？"
            self.Action = "是"
            self.cancel = "否"
        } else if XLanguage.get() == .Hindi {
            self.logoutT = "लॉग आउट"
            self.logoutM = "क्या आप वाकई लॉग आउट करना चाहते हैं?"
            self.Action = "हाँ"
            self.cancel = "नहीं"
        } else if XLanguage.get() == .Portuguese {
            self.logoutT = "Sair"
            self.logoutM = "Tem certeza de que deseja sair?"
            self.Action = "Sim"
            self.cancel = "Não"
        } else if XLanguage.get() == .Swedish {
            self.logoutT = "Logga ut"
            self.logoutM = "Är du säker på att du vill logga ut?"
            self.Action = "Ja"
            self.cancel = "Nej"
        } else if XLanguage.get() == .Greek {
            self.logoutT = "Αποσύνδεση"
            self.logoutM = "Είστε σίγουροι ότι θέλετε να αποσυνδεθείτε;"
            self.Action = "Ναι"
            self.cancel = "Όχι"
        } else if XLanguage.get() == .Russian {
            self.logoutT = "Выход"
            self.logoutM = "Вы уверены, что хотите выйти?"
            self.Action = "Да"
            self.cancel = "Нет"
        }
        
        if XLanguage.get() == .English {
            self.loadingLableMessage = "Please wait..."
        } else if XLanguage.get() == .Dutch {
            self.loadingLableMessage = "Even wachten alstublieft..."
        } else if XLanguage.get() == .French {
            self.loadingLableMessage = "Veuillez patienter..."
        } else if XLanguage.get() == .Spanish {
            self.loadingLableMessage = "Por favor, espera..."
        } else if XLanguage.get() == .German {
            self.loadingLableMessage = "Bitte warten..."
        } else if XLanguage.get() == .Hebrew {
            self.loadingLableMessage = "אנא המתן..."
        } else if XLanguage.get() == .Chinese {
            self.loadingLableMessage = "请稍候..."
        } else if XLanguage.get() == .Hindi {
            self.loadingLableMessage = "कृपया प्रतीक्षा करें..."
        } else if XLanguage.get() == .Portuguese {
            self.loadingLableMessage = "Por favor, aguarde..."
        } else if XLanguage.get() == .Swedish {
            self.loadingLableMessage = "Var god vänta..."
        } else if XLanguage.get() == .Greek {
            self.loadingLableMessage = "Παρακαλώ περιμένετε..."
        } else if XLanguage.get() == .Russian {
            self.loadingLableMessage = "Пожалуйста, подождите..."
        }
        
        
        
        if UserDefaults.standard.bool(forKey: "Login") == false {
            if XLanguage.get() == .Kurdish{
                self.LoginOrLogoutLable.text = "چونه‌ ژووره‌وه‌"
                self.LoginOrLogoutLable.font = UIFont(name: "PeshangDes2", size: 14)!
            }else if XLanguage.get() == .English{
                self.LoginOrLogoutLable.text = "LOGIN"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            }else if XLanguage.get() == .Arabic{
                self.LoginOrLogoutLable.text = "تسجيل الدخول"
                self.LoginOrLogoutLable.font = UIFont(name: "PeshangDes2", size: 14)!
            }else if XLanguage.get() == .Dutch {
                self.LoginOrLogoutLable.text = "INLOGGEN"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .French {
                self.LoginOrLogoutLable.text = "CONNEXION"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Spanish {
                self.LoginOrLogoutLable.text = "INICIAR SESIÓN"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .German {
                self.LoginOrLogoutLable.text = "ANMELDEN"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Hebrew {
                self.LoginOrLogoutLable.text = "התחברות"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Chinese {
                self.LoginOrLogoutLable.text = "登录"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Hindi {
                self.LoginOrLogoutLable.text = "लॉग इन करें"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Portuguese {
                self.LoginOrLogoutLable.text = "ENTRAR"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Swedish {
                self.LoginOrLogoutLable.text = "LOGGA IN"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Greek {
                self.LoginOrLogoutLable.text = "ΣΥΝΔΕΣΗ"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Russian {
                self.LoginOrLogoutLable.text = "ВХОД"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            }
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
            }else  if XLanguage.get() == .Arabic{
                self.FavoriteItems.text = "0 عناصر"
                self.ViewdItems.text = "0 عناصر"
                self.ViewdItems.font =  UIFont(name: "PeshangDes2", size: 10)!
                self.FavoriteItems.font =  UIFont(name: "PeshangDes2", size: 10)!
            }else if XLanguage.get() == .Dutch {
                self.ViewdItems.text = "0 ITEMS"
                self.FavoriteItems.text = "0 ITEMS"
                self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
            } else if XLanguage.get() == .French {
                self.ViewdItems.text = "0 ARTICLES"
                self.FavoriteItems.text = "0 ARTICLES"
                self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
            } else if XLanguage.get() == .Spanish {
                self.ViewdItems.text = "0 ARTÍCULOS"
                self.FavoriteItems.text = "0 ARTÍCULOS"
                self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
            } else if XLanguage.get() == .German {
                self.ViewdItems.text = "0 ARTIKEL"
                self.FavoriteItems.text = "0 ARTIKEL"
                self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
            } else if XLanguage.get() == .Hebrew {
                self.ViewdItems.text = "0 פריטים"
                self.FavoriteItems.text = "0 פריטים"
                self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
            } else if XLanguage.get() == .Chinese {
                self.ViewdItems.text = "0 项"
                self.FavoriteItems.text = "0 项"
                self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
            } else if XLanguage.get() == .Hindi {
                self.ViewdItems.text = "0 वस्तुएँ"
                self.FavoriteItems.text = "0 वस्तुएँ"
                self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
            } else if XLanguage.get() == .Portuguese {
                self.ViewdItems.text = "0 ITENS"
                self.FavoriteItems.text = "0 ITENS"
                self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
            } else if XLanguage.get() == .Swedish {
                self.ViewdItems.text = "0 FÖREMÅL"
                self.FavoriteItems.text = "0 FÖREMÅL"
                self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
            } else if XLanguage.get() == .Greek {
                self.ViewdItems.text = "0 ΑΝΤΙΚΕΊΜΕΝΑ"
                self.FavoriteItems.text = "0 ΑΝΤΙΚΕΊΜΕΝΑ"
                self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
            } else if XLanguage.get() == .Russian {
                self.ViewdItems.text = "0 ПРЕДМЕТОВ"
                self.FavoriteItems.text = "0 ПРЕДМЕТОВ"
                self.FavoriteItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
            }
        }else{
            
            
            
            
            
            
            
            
            if XLanguage.get() == .Kurdish{
                self.LoginOrLogoutLable.text = "چوونە دەرەوە"
                self.LoginOrLogoutLable.font = UIFont(name: "PeshangDes2", size: 14)!
            }else if XLanguage.get() == .English{
                self.LoginOrLogoutLable.text = "LOGOUT"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            }else if XLanguage.get() == .Arabic{
                self.LoginOrLogoutLable.text = "تسجيل خروج"
                self.LoginOrLogoutLable.font = UIFont(name: "PeshangDes2", size: 14)!
            }else if XLanguage.get() == .Dutch {
                self.LoginOrLogoutLable.text = "UITLOGGEN"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .French {
                self.LoginOrLogoutLable.text = "DÉCONNEXION"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Spanish {
                self.LoginOrLogoutLable.text = "CERRAR SESIÓN"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .German {
                self.LoginOrLogoutLable.text = "ABMELDEN"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Hebrew {
                self.LoginOrLogoutLable.text = "התנתקות"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Chinese {
                self.LoginOrLogoutLable.text = "登出"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Hindi {
                self.LoginOrLogoutLable.text = "लॉग आउट"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Portuguese {
                self.LoginOrLogoutLable.text = "SAIR"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Swedish {
                self.LoginOrLogoutLable.text = "LOGGA UT"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Greek {
                self.LoginOrLogoutLable.text = "ΑΠΟΣΥΝΔΕΣΗ"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            } else if XLanguage.get() == .Russian {
                self.LoginOrLogoutLable.text = "ВЫЙТИ"
                self.LoginOrLogoutLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
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

                        self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                        if XLanguage.get() == .Kurdish{
                            self.ViewdItems.text = "\(ViewdItemCount) بینراو"
                            self.ViewdItems.font = UIFont(name: "PeshangDes2", size: 11)!
                        } else if XLanguage.get() == .Arabic{
                            let itemText = ViewdItemCount == 1 ? "عناصر" : "عنصر"
                            self.ViewdItems.text = "\(ViewdItemCount) \(itemText)"
                            self.ViewdItems.font = UIFont(name: "PeshangDes2", size: 11)!
                        }else if XLanguage.get() == .English {
                            let itemText = ViewdItemCount == 1 ? "ITEM" : "ITEMS"
                            self.ViewdItems.text = "\(ViewdItemCount) \(itemText)"
                        } else if XLanguage.get() == .Dutch {
                            let itemText = ViewdItemCount == 1 ? "ITEM" : "ITEMS"
                            self.ViewdItems.text = "\(ViewdItemCount) \(itemText)"
                        } else if XLanguage.get() == .French {
                            let itemText = ViewdItemCount == 1 ? "ARTICLE" : "ARTICLES"
                            self.ViewdItems.text = "\(ViewdItemCount) \(itemText)"
                        } else if XLanguage.get() == .Spanish {
                            let itemText = ViewdItemCount == 1 ? "ARTÍCULO" : "ARTÍCULOS"
                            self.ViewdItems.text = "\(ViewdItemCount) \(itemText)"
                        } else if XLanguage.get() == .German {
                            let itemText = ViewdItemCount == 1 ? "ARTIKEL" : "ARTIKEL"
                            self.ViewdItems.text = "\(ViewdItemCount) \(itemText)"
                        } else if XLanguage.get() == .Hebrew {
                            let itemText = ViewdItemCount == 1 ? "פריט" : "פריטים"
                            self.ViewdItems.text = "\(ViewdItemCount) \(itemText)"
                        } else if XLanguage.get() == .Chinese {
                            self.ViewdItems.text = "\(ViewdItemCount) 项"
                        } else if XLanguage.get() == .Hindi {
                            let itemText = ViewdItemCount == 1 ? "आइटम" : "आइटम्स"
                            self.ViewdItems.text = "\(ViewdItemCount) \(itemText)"
                        } else if XLanguage.get() == .Portuguese {
                            let itemText = ViewdItemCount == 1 ? "ITEM" : "ITENS"
                            self.ViewdItems.text = "\(ViewdItemCount) \(itemText)"
                        } else if XLanguage.get() == .Swedish {
                            let itemText = ViewdItemCount == 1 ? "FÖREMÅL" : "FÖREMÅL"
                            self.ViewdItems.text = "\(ViewdItemCount) \(itemText)"
                        } else if XLanguage.get() == .Greek {
                            let itemText = ViewdItemCount == 1 ? "ΑΝΤΙΚΕΊΜΕΝΟ" : "ΑΝΤΙΚΕΊΜΕΝΑ"
                            self.ViewdItems.text = "\(ViewdItemCount) \(itemText)"
                        } else if XLanguage.get() == .Russian {
                            let itemText = ViewdItemCount == 1 ? "ПРЕДМЕТ" : "ПРЕДМЕТЫ"
                            self.ViewdItems.text = "\(ViewdItemCount) \(itemText)"
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
                        
                        self.ViewdItems.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
                        if XLanguage.get() == .Kurdish{
                            self.FavoriteItems.text = "\(FavoriteItemCount) خوازراو"
                            self.FavoriteItems.font = UIFont(name: "PeshangDes2", size: 11)!
                        } else if XLanguage.get() == .Arabic{
                            let itemText = FavoriteItemCount == 1 ? "عناصر" : "عنصر"
                            self.FavoriteItems.text = "\(FavoriteItemCount) \(itemText)"
                            self.FavoriteItems.font = UIFont(name: "PeshangDes2", size: 11)!
                        }else if XLanguage.get() == .English {
                            let itemText = FavoriteItemCount == 1 ? "ITEM" : "ITEMS"
                            self.FavoriteItems.text = "\(FavoriteItemCount) \(itemText)"
                        } else if XLanguage.get() == .Dutch {
                            let itemText = FavoriteItemCount == 1 ? "ITEM" : "ITEMS"
                            self.FavoriteItems.text = "\(FavoriteItemCount) \(itemText)"
                        } else if XLanguage.get() == .French {
                            let itemText = FavoriteItemCount == 1 ? "ARTICLE" : "ARTICLES"
                            self.FavoriteItems.text = "\(FavoriteItemCount) \(itemText)"
                        } else if XLanguage.get() == .Spanish {
                            let itemText = FavoriteItemCount == 1 ? "ARTÍCULO" : "ARTÍCULOS"
                            self.FavoriteItems.text = "\(FavoriteItemCount) \(itemText)"
                        } else if XLanguage.get() == .German {
                            let itemText = FavoriteItemCount == 1 ? "ARTIKEL" : "ARTIKEL"
                            self.FavoriteItems.text = "\(FavoriteItemCount) \(itemText)"
                        } else if XLanguage.get() == .Hebrew {
                            let itemText = FavoriteItemCount == 1 ? "פריט" : "פריטים"
                            self.FavoriteItems.text = "\(FavoriteItemCount) \(itemText)"
                        } else if XLanguage.get() == .Chinese {
                            self.FavoriteItems.text = "\(FavoriteItemCount) 项"
                        } else if XLanguage.get() == .Hindi {
                            let itemText = FavoriteItemCount == 1 ? "आइटम" : "आइटम्स"
                            self.FavoriteItems.text = "\(FavoriteItemCount) \(itemText)"
                        } else if XLanguage.get() == .Portuguese {
                            let itemText = FavoriteItemCount == 1 ? "ITEM" : "ITENS"
                            self.FavoriteItems.text = "\(FavoriteItemCount) \(itemText)"
                        } else if XLanguage.get() == .Swedish {
                            let itemText = FavoriteItemCount == 1 ? "FÖREMÅL" : "FÖREMÅL"
                            self.FavoriteItems.text = "\(FavoriteItemCount) \(itemText)"
                        } else if XLanguage.get() == .Greek {
                            let itemText = FavoriteItemCount == 1 ? "ΑΝΤΙΚΕΊΜΕΝΟ" : "ΑΝΤΙΚΕΊΜΕΝΑ"
                            self.FavoriteItems.text = "\(FavoriteItemCount) \(itemText)"
                        } else if XLanguage.get() == .Russian {
                            let itemText = FavoriteItemCount == 1 ? "ПРЕДМЕТ" : "ПРЕДМЕТЫ"
                            self.FavoriteItems.text = "\(FavoriteItemCount) \(itemText)"
                        }
                        
                        
                    }
                }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func ChangLocation(_ sender: Any) {
        if !CheckInternet.Connection(){
            if XLanguage.get() == .English{
                let ac = UIAlertController(title: "Error", message: "Please check your internet connection.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            }else if XLanguage.get() == .Arabic{
                let ac = UIAlertController(title: "خطأ", message: "الرجاء التحقق من اتصال الانترنت الخاص بك.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "نعم", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            }else if XLanguage.get() == .Kurdish{
                let ac = UIAlertController(title: "هەڵە", message: "تکایە هێڵی ئینتەرنێتەکەت بپشکنە.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "باشە", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            }else if XLanguage.get() == .Dutch {
                let ac = UIAlertController(title: "Fout", message: "Controleer uw internetverbinding.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .French {
                let ac = UIAlertController(title: "Erreur", message: "Veuillez vérifier votre connexion internet.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Spanish {
                let ac = UIAlertController(title: "Error", message: "Por favor, verifica tu conexión a internet.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .German {
                let ac = UIAlertController(title: "Fehler", message: "Bitte überprüfen Sie Ihre Internetverbindung.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Hebrew {
                let ac = UIAlertController(title: "שגיאה", message: "אנא בדוק את חיבור האינטרנט שלך.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "אישור", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Chinese {
                let ac = UIAlertController(title: "错误", message: "请检查您的互联网连接。", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "确定", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Hindi {
                let ac = UIAlertController(title: "त्रुटि", message: "कृपया अपना इंटरनेट कनेक्शन जाँच लें।", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "ठीक है", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Portuguese {
                let ac = UIAlertController(title: "Erro", message: "Por favor, verifique sua conexão com a internet.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Swedish {
                let ac = UIAlertController(title: "Fel", message: "Vänligen kontrollera din internetanslutning.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Greek {
                let ac = UIAlertController(title: "Σφάλμα", message: "Παρακαλώ ελέγξτε τη σύνδεσή σας στο διαδίκτυο.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "ΟΚ", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Russian {
                let ac = UIAlertController(title: "Ошибка", message: "Пожалуйста, проверьте ваше интернет-соединение.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "ОК", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            }
        }else{
            self.setupCitySelectionAlert()
        }
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
