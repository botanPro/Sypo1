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
import MHLoadingButton




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
            if XLanguage.get() == .Arabic{
                pickerLabel?.font = UIFont(name: "PeshangDes2", size: 12)!
                pickerLabel?.text = self.NighborArray[row].name
            }else if XLanguage.get() == .Kurdish{
                pickerLabel?.font = UIFont(name: "PeshangDes2", size: 12)!
                pickerLabel?.text = self.NighborArray[row].name
            }else{
                pickerLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
                pickerLabel?.text = self.NighborArray[row].name
            }
            pickerLabel?.textAlignment = .center
        }
        

        return pickerLabel!
    }
    
    
    
    
    
    
    var Locations : [Place] = []
 
    
    @IBAction func ChooseEstateType(_ sender: Any) {
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
        setupEstateTypesAlert()
        }
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
        }else if XLanguage.get() == .Arabic{
            self.ProjectsTitle = "اختر نوع العقار"
            self.ProjectsAction  = "تحديد"
            self.ProjectsCancel  = "إلغاء"
        }else if XLanguage.get() == .Dutch {
            self.ProjectsTitle = "Kies Soort Eigendom"
            self.ProjectsAction = "Selecteren"
            self.ProjectsCancel = "Annuleren"
        } else if XLanguage.get() == .French {
            self.ProjectsTitle = "Choisir le Type de Bien"
            self.ProjectsAction = "Sélectionner"
            self.ProjectsCancel = "Annuler"
        } else if XLanguage.get() == .Spanish {
            self.ProjectsTitle = "Elegir Tipo de Propiedad"
            self.ProjectsAction = "Seleccionar"
            self.ProjectsCancel = "Cancelar"
        } else if XLanguage.get() == .German {
            self.ProjectsTitle = "Immobilientyp Wählen"
            self.ProjectsAction = "Auswählen"
            self.ProjectsCancel = "Abbrechen"
        } else if XLanguage.get() == .Hebrew {
            self.ProjectsTitle = "בחר סוג נכס"
            self.ProjectsAction = "בחר"
            self.ProjectsCancel = "בטל"
        } else if XLanguage.get() == .Chinese {
            self.ProjectsTitle = "选择房产类型"
            self.ProjectsAction = "选择"
            self.ProjectsCancel = "取消"
        } else if XLanguage.get() == .Hindi {
            self.ProjectsTitle = "एस्टेट प्रकार चुनें"
            self.ProjectsAction = "चुनें"
            self.ProjectsCancel = "रद्द करें"
        } else if XLanguage.get() == .Portuguese {
            self.ProjectsTitle = "Escolher Tipo de Propriedade"
            self.ProjectsAction = "Selecionar"
            self.ProjectsCancel = "Cancelar"
        } else if XLanguage.get() == .Swedish {
            self.ProjectsTitle = "Välj Fastighetstyp"
            self.ProjectsAction = "Välj"
            self.ProjectsCancel = "Avbryt"
        } else if XLanguage.get() == .Greek {
            self.ProjectsTitle = "Επιλέξτε Τύπο Ακινήτου"
            self.ProjectsAction = "Επιλογή"
            self.ProjectsCancel = "Ακύρωση"
        } else if XLanguage.get() == .Russian {
            self.ProjectsTitle = "Выберите Тип Недвижимости"
            self.ProjectsAction = "Выбрать"
            self.ProjectsCancel = "Отмена"
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
                       
                        if XLanguage.get() == .English {
                            title = "Empty"
                            message = "No Estates are found"
                        } else if XLanguage.get() == .Arabic {
                            title = "فارغة"
                            message = "لم يتم العثور على عقار"
                        } else if XLanguage.get() == .Kurdish {
                            title = "بەتاڵ"
                            message = "هیچ خانوبەرێک نەدۆزراوەتەوە"
                        } else if XLanguage.get() == .Hebrew {
                            title = "ריק"
                            message = "לא נמצאו נכסים"
                        } else if XLanguage.get() == .Chinese {
                            title = "空"
                            message = "未找到任何房产"
                        } else if XLanguage.get() == .Hindi {
                            title = "खाली"
                            message = "कोई भी बेस्तकी पाया नहीं गया"
                        } else if XLanguage.get() == .Portuguese {
                            title = "Vazio"
                            message = "Nenhum imóvel encontrado"
                        } else if XLanguage.get() == .Swedish {
                            title = "Tomt"
                            message = "Inga fastigheter hittades"
                        } else if XLanguage.get() == .Greek {
                            title = "Άδειο"
                            message = "Δεν βρέθηκαν ακίνητα"
                        } else if XLanguage.get() == .Russian {
                            title = "Пусто"
                            message = "Недвижимость не найдена"
                        } else if XLanguage.get() == .Dutch {
                            title = "Leeg"
                            message = "Geen vastgoed gevonden"
                        } else if XLanguage.get() == .French {
                            title = "Vide"
                            message = "Aucune propriété trouvée"
                        } else if XLanguage.get() == .Spanish {
                            title = "Vacío"
                            message = "No se encontraron propiedades"
                        } else if XLanguage.get() == .German {
                            title = "Leer"
                            message = "Keine Immobilien gefunden"
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
    
    @IBOutlet weak var CreateContruct: LoadingButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        if XLanguage.get() == .English {
            self.CreateContruct.setTitle("Create Contract")
        } else if XLanguage.get() == .Kurdish {
            self.CreateContruct.setTitle("دروستکردنی پەیمان")
        } else if XLanguage.get() == .Arabic {
            self.CreateContruct.setTitle("إنشاء عقد")
        } else if XLanguage.get() == .Hebrew {
            self.CreateContruct.setTitle("צור חוזה")
        } else if XLanguage.get() == .Chinese {
            self.CreateContruct.setTitle("创建合同")
        } else if XLanguage.get() == .Hindi {
            self.CreateContruct.setTitle("अनुबंध बनाएँ")
        } else if XLanguage.get() == .Portuguese {
            self.CreateContruct.setTitle("Criar Contrato")
        } else if XLanguage.get() == .Swedish {
            self.CreateContruct.setTitle("Skapa Kontrakt")
        } else if XLanguage.get() == .Greek {
            self.CreateContruct.setTitle("Δημιουργία Συμβολαίου")
        } else if XLanguage.get() == .Russian {
            self.CreateContruct.setTitle("Создать Контракт")
        } else if XLanguage.get() == .Dutch {
            self.CreateContruct.setTitle("Contract Aanmaken")
        } else if XLanguage.get() == .French {
            self.CreateContruct.setTitle("Créer un Contrat")
        } else if XLanguage.get() == .Spanish {
            self.CreateContruct.setTitle("Crear Contrato")
        } else if XLanguage.get() == .German {
            self.CreateContruct.setTitle("Vertrag Erstellen")
        } else {
            self.CreateContruct.setTitle("Create Contract")
        }

        
        
        
        
        
        
        self.Sold.isHidden = true
        self.SoldView.isHidden = true
        self.Description.isUserInteractionEnabled = false
        GetAllEstates()
        self.ProjectNameTop.constant = 0
        let deviceName = device.modelNamee
        print(UIDevice.current.modelNamee)
        if deviceName == "iPhone 8" ||  deviceName == "iPhone 7" ||  deviceName == "iPhone 6"{
            self.ImagesHeightLayout.constant = 360
        }
        
        
        
        if self.CommingEstate?.office_id == UserDefaults.standard.string(forKey: "OfficeId") ?? "" || self.CommingEstate?.sold == "1" || self.CommingEstate?.RentOrSell == "0" {
            self.CreateContract.isEnabled = false
            self.CreateContract.alpha = 0.5
        }
        
        
        
        print(self.CommingEstate?.bound_id ?? "")
        BoundTypeAip.GetBoundTypeByOfficeId(id: self.CommingEstate?.bound_id ?? "") { bound in
            self.BoundType = bound.en_title ?? ""
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
    @IBOutlet weak var Sold: LanguageLable!
    @IBOutlet weak var SoldView: UIView!
    
    func GetData(){
        if let data = CommingEstate{
            print("----------")
            print(data.office_id)
            print(UserDefaults.standard.string(forKey: "OfficeId") ?? "")
            if data.sold == "1"{
                self.Sold.isHidden = false
                self.SoldView.isHidden = false
            }else{
                self.Sold.isHidden = true
                self.SoldView.isHidden = true
            }
            
            self.BottomPrice.text = data.price?.description.currencyFormatting() ?? ""
            
            self.profileID = data.id ?? ""
            self.sliderImages = data.ImageURL ?? []
            
            self.PagerControl.pages = data.ImageURL?.count ?? 0
            self.ImageCollectionView.reloadData()
            self.GetRelated(type:data.estate_type_id ?? "")
            self.EstateName.text = data.name
            
            self.RoomNo.text = data.RoomNo
            let font:UIFont? = UIFont(name: "ArialRoundedMTBold", size: 23)!
            let fontSuper:UIFont? = UIFont(name: "ArialRoundedMTBold", size: 15)!

            
            
            if XLanguage.get() == .English {
                self.m2 = "m2"
            } else if XLanguage.get() == .Hebrew {
                self.m2 = "מ²"
            } else if XLanguage.get() == .Chinese {
                self.m2 = "平方米"
            } else if XLanguage.get() == .Hindi {
                self.m2 = "वर्ग मीटर"
            } else if XLanguage.get() == .Portuguese {
                self.m2 = "m²"
            } else if XLanguage.get() == .Swedish {
                self.m2 = "m²"
            } else if XLanguage.get() == .Greek {
                self.m2 = "τ.μ."
            } else if XLanguage.get() == .Russian {
                self.m2 = "м²"
            } else if XLanguage.get() == .Dutch {
                self.m2 = "m²"
            } else if XLanguage.get() == .French {
                self.m2 = "m²"
            } else if XLanguage.get() == .Spanish {
                self.m2 = "m²"
            } else if XLanguage.get() == .German {
                self.m2 = "m²"
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
            self.DescHight.constant = 10
            if data.desc == ""{
                self.DescLable.isHidden = true
                self.DescHight.constant = 0
                self.DescBottomLayout.constant = 0
            }else{
               
                self.DescLable.isHidden = false
                self.Description.text = data.desc
                print(self.Description.text!)
                DispatchQueue.main.asyncAfter(deadline: .now()  + 0.5, execute: {print("1")
                    UIView.animate(withDuration: 0.5) {print("2")
                        self.DescHight.constant = self.Description.contentSize.height
                        self.DescBottomLayout.constant = 16
                        self.view.layoutIfNeeded()
                    }
                })
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
            }else if XLanguage.get() == .Arabic{
                self.keys.append("تاريخ")
                self.keys.append("مفروشة")
                self.keys.append("نوع السند")
                self.keys.append("سنة البناء")
                self.keys.append("الاتجاه")
                self.keys.append("هذا العقار")
            }else if XLanguage.get() == .English {
                self.keys.append("Date")
                self.keys.append("Furnished")
                self.keys.append("Bond Type")
                self.keys.append("Constraction year")
                self.keys.append("Direction")
                self.keys.append("This estate is")
            } else if XLanguage.get() == .Hebrew {
                self.keys.append("תאריך")
                self.keys.append("ריהוט")
                self.keys.append("סוג ערבוב")
                self.keys.append("שנת בנייה")
                self.keys.append("כיוון")
                self.keys.append("הנכס הזה הוא")
            } else if XLanguage.get() == .Chinese {
                self.keys.append("日期")
                self.keys.append("家具")
                self.keys.append("债券类型")
                self.keys.append("建造年份")
                self.keys.append("方向")
                self.keys.append("此房产是")
            } else if XLanguage.get() == .Hindi {
                self.keys.append("तारीख")
                self.keys.append("सुसज्जित")
                self.keys.append("बॉन्ड प्रकार")
                self.keys.append("निर्माण वर्ष")
                self.keys.append("दिशा")
                self.keys.append("यह इस्टेट है")
            } else if XLanguage.get() == .Portuguese {
                self.keys.append("Data")
                self.keys.append("Mobiliado")
                self.keys.append("Tipo de Vínculo")
                self.keys.append("Ano de Construção")
                self.keys.append("Direção")
                self.keys.append("Este imóvel é")
            } else if XLanguage.get() == .Swedish {
                self.keys.append("Datum")
                self.keys.append("Möblerad")
                self.keys.append("Bindningstyp")
                self.keys.append("Byggår")
                self.keys.append("Riktning")
                self.keys.append("Denna fastighet är")
            } else if XLanguage.get() == .Greek {
                self.keys.append("Ημερομηνία")
                self.keys.append("Επιπλωμένο")
                self.keys.append("Τύπος Ομολόγου")
                self.keys.append("Έτος Κατασκευής")
                self.keys.append("Κατεύθυνση")
                self.keys.append("Αυτή η ιδιοκτησία είναι")
            } else if XLanguage.get() == .Russian {
                self.keys.append("Дата")
                self.keys.append("Меблированный")
                self.keys.append("Тип облигации")
                self.keys.append("Год постройки")
                self.keys.append("Направление")
                self.keys.append("Это имущество")
            } else if XLanguage.get() == .Dutch {
                self.keys.append("Datum")
                self.keys.append("Gemeubileerd")
                self.keys.append("Bindtype")
                self.keys.append("Bouwjaar")
                self.keys.append("Richting")
                self.keys.append("Dit vastgoed is")
            } else if XLanguage.get() == .French {
                self.keys.append("Date")
                self.keys.append("Meublé")
                self.keys.append("Type d'obligation")
                self.keys.append("Année de construction")
                self.keys.append("Direction")
                self.keys.append("Cette propriété est")
            } else if XLanguage.get() == .Spanish {
                self.keys.append("Fecha")
                self.keys.append("Amueblado")
                self.keys.append("Tipo de bono")
                self.keys.append("Año de construcción")
                self.keys.append("Dirección")
                self.keys.append("Esta propiedad es")
            } else if XLanguage.get() == .German {
                self.keys.append("Datum")
                self.keys.append("Möbliert")
                self.keys.append("Bindungstyp")
                self.keys.append("Baujahr")
                self.keys.append("Richtung")
                self.keys.append("Diese Imm")
            }
            self.value.append("\(dateTime[0])".convertedDigitsToLocale(Locale(identifier: "EN")))
            
            
            
            ///---------
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
            
            if data.Furnished == "0" && XLanguage.get() == .Hebrew{
                self.value.append("מרוהט")
            }else if data.Furnished == "1" && XLanguage.get() == .Hebrew{
                self.value.append("לא מרוהט")
            }
            if data.Furnished == "0" && XLanguage.get() == .Chinese{
                self.value.append("家具")
            }else if data.Furnished == "1" && XLanguage.get() == .Chinese{
                self.value.append("没有家具")
            }
            
            if data.Furnished == "0" && XLanguage.get() == .Hindi{
                self.value.append ("सुसज्जित")
            }else if data.Furnished == "1" && XLanguage.get() == .Hindi{
                self.value.append("असुसज्जित")
            }
            
            
            if data.Furnished == "0" && XLanguage.get() == .Portuguese{
                self.value.append("Mobiliado")
            }else if data.Furnished == "1" && XLanguage.get() == .Portuguese{
                self.value.append("Não Mobiliado")
            }
            
            if data.Furnished == "0" && XLanguage.get() == .Swedish{
                self.value.append("Möblerad")
            }else if data.Furnished == "1" && XLanguage.get() == .Swedish{
                self.value.append ("Omöblerad")
            }
            
            if data.Furnished == "0" && XLanguage.get() == .Greek{
                self.value.append("Επιπλωμένο")
            }else if data.Furnished == "1" && XLanguage.get() == .Greek{
                self.value.append("Μη επιπλωμένο")
            }
            
            if data.Furnished == "0" && XLanguage.get() == .Russian{
                self.value.append("Меблированная")
            }else if data.Furnished == "1" && XLanguage.get() == .Russian{
                self.value.append("Немеблированная")
            }
            
            if data.Furnished == "0" && XLanguage.get() == .Dutch{
                self.value.append("Gemeubileerd")
            }else if data.Furnished == "1" && XLanguage.get() == .Dutch{
                self.value.append ("Niet gemeubileerd")
            }
            
            if data.Furnished == "0" && XLanguage.get() == .French{
                self.value.append ("Meublé")
            }else if data.Furnished == "1" && XLanguage.get() == .French{
                self.value.append("Non meublé")
            }
            
            if data.Furnished == "0" && XLanguage.get() == .Spanish{
                self.value.append("Amueblado")
            }else if data.Furnished == "1" && XLanguage.get() == .Spanish{
                self.value.append("Sin amueblar")
            }
            
            if data.Furnished == "0" && XLanguage.get() == .German{
                self.value.append("Möbliert")
            }else if data.Furnished == "1" && XLanguage.get() == .German{
                self.value.append("Unmöbliert")
            }
   
            ///---------
            
            
            
            
            
            
            self.value.append(self.BoundType)
            
            self.value.append(data.Year ?? "")
            

            
            if data.Direction == "N"{
               if XLanguage.get() == .Arabic{
                    self.value.append("شمال")
                }else if XLanguage.get() == .Kurdish{
                    self.value.append("باکور")
                }else if XLanguage.get() == .English {
                    self.value.append("North")
                } else if XLanguage.get() == .Dutch {
                    self.value.append("Noord")
                } else if XLanguage.get() == .French {
                    self.value.append("Nord")
                } else if XLanguage.get() == .Spanish {
                    self.value.append("Norte")
                } else if XLanguage.get() == .German {
                    self.value.append("Norden")
                } else if XLanguage.get() == .Hebrew {
                    self.value.append("צפון")
                } else if XLanguage.get() == .Chinese {
                    self.value.append("北")
                } else if XLanguage.get() == .Hindi {
                    self.value.append("उत्तर")
                } else if XLanguage.get() == .Portuguese {
                    self.value.append("Norte")
                } else if XLanguage.get() == .Russian {
                    self.value.append("Север")
                } else if XLanguage.get() == .Swedish {
                    self.value.append("Norr")
                } else {
                    self.value.append("Βορράς")
                }
            }
            
            if data.Direction == "NE"{
                 if XLanguage.get() == .Arabic{
                    self.value.append("الشمال الشرقي")
                }else if XLanguage.get() == .Kurdish{
                    self.value.append("باکوورێ رۆژهەڵات")
                }else if XLanguage.get() == .English {
                    self.value.append("Northeast")
                } else if XLanguage.get() == .Dutch {
                    self.value.append("Noordoost")
                } else if XLanguage.get() == .French {
                    self.value.append("Nord-est")
                } else if XLanguage.get() == .Spanish {
                    self.value.append("Noreste")
                } else if XLanguage.get() == .German {
                    self.value.append("Nordosten")
                } else if XLanguage.get() == .Hebrew {
                    self.value.append("צפון מזרח")
                } else if XLanguage.get() == .Chinese {
                    self.value.append("东北")
                } else if XLanguage.get() == .Hindi {
                    self.value.append("उत्तर-पूर्व")
                } else if XLanguage.get() == .Portuguese {
                    self.value.append("Nordeste")
                } else if XLanguage.get() == .Russian {
                    self.value.append("Северо-восток")
                } else if XLanguage.get() == .Swedish {
                    self.value.append("Nordost")
                } else if XLanguage.get() == .Greek {
                    self.value.append("Βορειοανατολικά")
                }
            }
            
            if data.Direction == "E"{
                if XLanguage.get() == .Arabic{
                    self.value.append("شرق")
                }else if XLanguage.get() == .Kurdish{
                    self.value.append("رۆژهەڵات")
                }else if XLanguage.get() == .English {
                    self.value.append("East")
                } else if XLanguage.get() == .Dutch {
                    self.value.append("Oost")
                } else if XLanguage.get() == .French {
                    self.value.append("Est")
                } else if XLanguage.get() == .Spanish {
                    self.value.append("Este")
                } else if XLanguage.get() == .German {
                    self.value.append("Osten")
                } else if XLanguage.get() == .Hebrew {
                    self.value.append("מזרח")
                } else if XLanguage.get() == .Chinese {
                    self.value.append("东")
                } else if XLanguage.get() == .Hindi {
                    self.value.append("पूर्व")
                } else if XLanguage.get() == .Portuguese {
                    self.value.append("Leste")
                } else if XLanguage.get() == .Russian {
                    self.value.append("Восток")
                } else if XLanguage.get() == .Swedish {
                    self.value.append("Öst")
                } else if XLanguage.get() == .Greek {
                    self.value.append("Ανατολή")
                }
            }
            
            
            if data.Direction == "SE"{
                if XLanguage.get() == .Arabic{
                    self.value.append("الجنوب الشرقي")
                }else if XLanguage.get() == .Kurdish{
                    self.value.append("باشوورێ رۆژهەڵات")
                }else if XLanguage.get() == .English {
                    self.value.append("Southeast")
                } else if XLanguage.get() == .Dutch {
                    self.value.append("Zuidoost")
                } else if XLanguage.get() == .French {
                    self.value.append("Sud-est")
                } else if XLanguage.get() == .Spanish {
                    self.value.append("Sureste")
                } else if XLanguage.get() == .German {
                    self.value.append("Südosten")
                } else if XLanguage.get() == .Hebrew {
                    self.value.append("דרום מזרח")
                } else if XLanguage.get() == .Chinese {
                    self.value.append("东南")
                } else if XLanguage.get() == .Hindi {
                    self.value.append("दक्षिण-पूर्व")
                } else if XLanguage.get() == .Portuguese {
                    self.value.append("Sudeste")
                } else if XLanguage.get() == .Russian {
                    self.value.append("Юго-восток")
                } else if XLanguage.get() == .Swedish {
                    self.value.append("Sydost")
                } else if XLanguage.get() == .Greek {
                    self.value.append("Νοτιοανατολικά")
                }
            }
            
            
            if data.Direction == "S"{
                if XLanguage.get() == .Arabic{
                    self.value.append("الجنوب")
                }else if XLanguage.get() == .Kurdish{
                    self.value.append("باشور")
                }else if XLanguage.get() == .English {
                    self.value.append("South")
                } else if XLanguage.get() == .Dutch {
                    self.value.append("Zuid")
                } else if XLanguage.get() == .French {
                    self.value.append("Sud")
                } else if XLanguage.get() == .Spanish {
                    self.value.append("Sur")
                } else if XLanguage.get() == .German {
                    self.value.append("Süd")
                } else if XLanguage.get() == .Hebrew {
                    self.value.append("דרום")
                } else if XLanguage.get() == .Chinese {
                    self.value.append("南")
                } else if XLanguage.get() == .Hindi {
                    self.value.append("दक्षिण")
                } else if XLanguage.get() == .Portuguese {
                    self.value.append("Sul")
                } else if XLanguage.get() == .Russian {
                    self.value.append("Юг")
                } else if XLanguage.get() == .Swedish {
                    self.value.append("Söder")
                } else if XLanguage.get() == .Greek {
                    self.value.append("Νότος")
                }
            }
            
            if data.Direction == "SW"{
                if XLanguage.get() == .Arabic{
                    self.value.append("جنوب غرب")
                }else if XLanguage.get() == .Kurdish{
                    self.value.append("باشوورێ رۆژئاڤا")
                }else if XLanguage.get() == .English {
                    self.value.append("Southwest")
                } else if XLanguage.get() == .Dutch {
                    self.value.append("Zuidwest")
                } else if XLanguage.get() == .French {
                    self.value.append("Sud-ouest")
                } else if XLanguage.get() == .Spanish {
                    self.value.append("Suroeste")
                } else if XLanguage.get() == .German {
                    self.value.append("Südwesten")
                } else if XLanguage.get() == .Hebrew {
                    self.value.append("דרום מערב")
                } else if XLanguage.get() == .Chinese {
                    self.value.append("西南")
                } else if XLanguage.get() == .Hindi {
                    self.value.append("दक्षिण-पश्चिम")
                } else if XLanguage.get() == .Portuguese {
                    self.value.append("Sudoeste")
                } else if XLanguage.get() == .Russian {
                    self.value.append("Юго-запад")
                } else if XLanguage.get() == .Swedish {
                    self.value.append("Sydväst")
                } else if XLanguage.get() == .Greek {
                    self.value.append("Νοτιοδυτικά")
                }
            }
            
            if data.Direction == "W"{
                if XLanguage.get() == .Arabic{
                    self.value.append("الغرب")
                }else if XLanguage.get() == .Kurdish{
                    self.value.append("رۆژئاڤا")
                }else if XLanguage.get() == .English {
                    self.value.append("West")
                } else if XLanguage.get() == .Dutch {
                    self.value.append("West")
                } else if XLanguage.get() == .French {
                    self.value.append("Ouest")
                } else if XLanguage.get() == .Spanish {
                    self.value.append("Oeste")
                } else if XLanguage.get() == .German {
                    self.value.append("Westen")
                } else if XLanguage.get() == .Hebrew {
                    self.value.append("מערב")
                } else if XLanguage.get() == .Chinese {
                    self.value.append("西")
                } else if XLanguage.get() == .Hindi {
                    self.value.append("पश्चिम")
                } else if XLanguage.get() == .Portuguese {
                    self.value.append("Oeste")
                } else if XLanguage.get() == .Russian {
                    self.value.append("Запад")
                } else if XLanguage.get() == .Swedish {
                    self.value.append("Väst")
                } else if XLanguage.get() == .Greek {
                    self.value.append("Δύση")
                }
            }
            
            if data.Direction == "NW"{
                if XLanguage.get() == .Arabic{
                    self.value.append( "الشمال الغربي")
                }else if XLanguage.get() == .Kurdish{
                    self.value.append("باکوورێ رۆژئاڤا")
                }else if XLanguage.get() == .English {
                    self.value.append("Northwest")
                } else if XLanguage.get() == .Dutch {
                    self.value.append("Noordwest")
                } else if XLanguage.get() == .French {
                    self.value.append("Nord-ouest")
                } else if XLanguage.get() == .Spanish {
                    self.value.append("Noroeste")
                } else if XLanguage.get() == .German {
                    self.value.append("Nordwesten")
                } else if XLanguage.get() == .Hebrew {
                    self.value.append("צפון מערב")
                } else if XLanguage.get() == .Chinese {
                    self.value.append("西北")
                } else if XLanguage.get() == .Hindi {
                    self.value.append("उत्तर-पश्चिम")
                } else if XLanguage.get() == .Portuguese {
                    self.value.append("Noroeste")
                } else if XLanguage.get() == .Russian {
                    self.value.append("Северо-запад")
                } else if XLanguage.get() == .Swedish {
                    self.value.append("Nordväst")
                } else if XLanguage.get() == .Greek {
                    self.value.append("Βορειοδυτικά")
                }
            }
            
            
            
            
            EstateTypeAip.GeEstateTypeNameById(id: data.estate_type_id ?? "") { estatetype in
         
                if XLanguage.get() == .English {
                        self.keys.append("Estate Type")
                    } else if XLanguage.get() == .Arabic {
                        self.keys.append("نوع العقار")
                    } else if XLanguage.get() == .Kurdish {
                        self.keys.append("جۆری خانۆبەر")
                    } else if XLanguage.get() == .Hebrew {
                        self.keys.append("סוג הנכס")
                    } else if XLanguage.get() == .Chinese {
                        self.keys.append("房地产类型")
                    } else if XLanguage.get() == .Hindi {
                        self.keys.append("संपत्ति का प्रकार")
                    } else if XLanguage.get() == .Portuguese {
                        self.keys.append("Tipo de Propriedade")
                    } else if XLanguage.get() == .Swedish {
                        self.keys.append("Fastighetstyp")
                    } else if XLanguage.get() == .Greek {
                        self.keys.append("Τύπος Ακινήτου")
                    } else if XLanguage.get() == .Russian {
                        self.keys.append("Тип недвижимости")
                    } else if XLanguage.get() == .Dutch {
                        self.keys.append("Soort vastgoed")
                    } else if XLanguage.get() == .French {
                        self.keys.append("Type de Propriété")
                    } else if XLanguage.get() == .Spanish {
                        self.keys.append("Tipo de Propiedad")
                    } else if XLanguage.get() == .German {
                        self.keys.append("Immobilientyp")
                    }
                
                self.value.append(estatetype.name ?? "")
                self.DataCollectionView.reloadData()
            }
            
            TypesObjectAip.GetTypeById(id: data.type_id ?? "") { type in
                if XLanguage.get() == .Kurdish{
                    self.keys.append("جوری مولک")
                }else if XLanguage.get() == .Arabic{
                    self.keys.append("نوع الملک")
                }else if XLanguage.get() == .English {
                    self.keys.append("Property Type")
                } else if XLanguage.get() == .Dutch {
                    self.keys.append("Eigendomstype")
                } else if XLanguage.get() == .French {
                    self.keys.append("Type de propriété")
                } else if XLanguage.get() == .Spanish {
                    self.keys.append("Tipo de propiedad")
                } else if XLanguage.get() == .German {
                    self.keys.append("Immobilientyp")
                } else if XLanguage.get() == .Hebrew {
                    self.keys.append("סוג נכס")
                } else if XLanguage.get() == .Chinese {
                    self.keys.append("物业类型")
                } else if XLanguage.get() == .Hindi {
                    self.keys.append("संपत्ति का प्रकार")
                } else if XLanguage.get() == .Portuguese {
                    self.keys.append("Tipo de Propriedade")
                } else if XLanguage.get() == .Russian {
                    self.keys.append("Тип недвижимости")
                } else if XLanguage.get() == .Swedish {
                    self.keys.append("Fastighetstyp")
                } else if XLanguage.get() == .Greek {
                    self.keys.append("Τύπος Ακινήτου")
                }
                
                self.value.append(type.name ?? "")
                self.DataCollectionView.reloadData()
            }
            
            var longString = ""
            var longestWord = ""
            
            if data.RentOrSell == "0"{
                if XLanguage.get() == .Kurdish{
                    longString = "\(data.price?.description.currencyFormatting() ?? "")/ مانگانە"
                    longestWord = "مانگانە"
                    let longestWordRange = (longString as NSString).range(of: longestWord)

                    let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                    attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "PeshangDes2", size: 16)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                    
                    self.Price.attributedText = attributedString
                }else if XLanguage.get() == .Arabic{
                     longString = "\(data.price?.description.currencyFormatting() ?? "")/ شهريا"
                     longestWord  = "شهريا"
                    let longestWordRange = (longString as NSString).range(of: longestWord)

                    let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                    attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "PeshangDes2", size: 16)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                    
                    self.Price.attributedText = attributedString
                }else if XLanguage.get() == .English {
                    longestWord = "Monthly"
                    longString = "\(data.price?.description.currencyFormatting() ?? "")/ \(longestWord)"
                    let longestWordRange = (longString as NSString).range(of: longestWord)

                    let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                    attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 15)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                    
                    self.Price.attributedText = attributedString
                } else if XLanguage.get() == .Hebrew {
                    longestWord = "חודשי"
                    longString = "\(data.price?.description.currencyFormatting() ?? "")/ \(longestWord)"
                    let longestWordRange = (longString as NSString).range(of: longestWord)

                    let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                    attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 15)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                    
                    self.Price.attributedText = attributedString
                } else if XLanguage.get() == .Chinese {
                    longestWord = "每月"
                    longString = "\(data.price?.description.currencyFormatting() ?? "")/ \(longestWord)"
                    let longestWordRange = (longString as NSString).range(of: longestWord)

                    let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                    attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 15)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                    
                    self.Price.attributedText = attributedString
                } else if XLanguage.get() == .Hindi {
                    longestWord = "मासिक"
                    longString = "\(data.price?.description.currencyFormatting() ?? "")/ \(longestWord)"
                    let longestWordRange = (longString as NSString).range(of: longestWord)

                    let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                    attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 15)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                    
                    self.Price.attributedText = attributedString
                } else if XLanguage.get() == .Portuguese {
                    longestWord = "Mensal"
                    longString = "\(data.price?.description.currencyFormatting() ?? "")/ \(longestWord)"
                    let longestWordRange = (longString as NSString).range(of: longestWord)

                    let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                    attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 15)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                    
                    self.Price.attributedText = attributedString
                } else if XLanguage.get() == .Swedish {
                    longestWord = "Månadsvis"
                    longString = "\(data.price?.description.currencyFormatting() ?? "")/ \(longestWord)"
                    let longestWordRange = (longString as NSString).range(of: longestWord)

                    let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                    attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 15)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                    
                    self.Price.attributedText = attributedString
                } else if XLanguage.get() == .Greek {
                    longestWord = "Μηνιαίως"
                    longString = "\(data.price?.description.currencyFormatting() ?? "")/ \(longestWord)"
                    let longestWordRange = (longString as NSString).range(of: longestWord)

                    let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                    attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 15)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                    
                    self.Price.attributedText = attributedString
                } else if XLanguage.get() == .Russian {
                    longestWord = "Ежемесячно"
                    longString = "\(data.price?.description.currencyFormatting() ?? "")/ \(longestWord)"
                    let longestWordRange = (longString as NSString).range(of: longestWord)

                    let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                    attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 15)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                    
                    self.Price.attributedText = attributedString
                } else if XLanguage.get() == .Dutch {
                    longestWord = "Maandelijks"
                    longString = "\(data.price?.description.currencyFormatting() ?? "")/ \(longestWord)"
                    let longestWordRange = (longString as NSString).range(of: longestWord)

                    let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                    attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 15)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                    
                    self.Price.attributedText = attributedString
                } else if XLanguage.get() == .French {
                    longestWord = "Mensuel"
                    longString = "\(data.price?.description.currencyFormatting() ?? "")/ \(longestWord)"
                    let longestWordRange = (longString as NSString).range(of: longestWord)

                    let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                    attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 15)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                    
                    self.Price.attributedText = attributedString
                } else if XLanguage.get() == .Spanish {
                    longestWord = "Mensual"
                    longString = "\(data.price?.description.currencyFormatting() ?? "")/ \(longestWord)"
                    let longestWordRange = (longString as NSString).range(of: longestWord)

                    let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                    attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 15)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                    
                    self.Price.attributedText = attributedString
                } else if XLanguage.get() == .German {
                    longestWord = "Monatlich"
                    longString = "\(data.price?.description.currencyFormatting() ?? "")/ \(longestWord)"
                    let longestWordRange = (longString as NSString).range(of: longestWord)

                    let attributedString = NSMutableAttributedString(string: longString, attributes: [NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 24)!])

                    attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "ArialRoundedMTBold", size: 15)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)], range: longestWordRange)
                    
                    self.Price.attributedText = attributedString
                }
                
                
                
                
                
                if XLanguage.get() == .Kurdish{
                    self.value.append("بۆ کرێ")
                }else if XLanguage.get() == .Arabic{
                    self.value.append("للايجار")
                }else if XLanguage.get() == .English {
                    self.value.append("For Rent")
                } else if XLanguage.get() == .French {
                    self.value.append("À Louer")
                } else if XLanguage.get() == .Spanish {
                    self.value.append("En Alquiler")
                } else if XLanguage.get() == .German {
                    self.value.append("Zu Vermieten")
                } else if XLanguage.get() == .Dutch {
                    self.value.append("Te Huur")
                } else if XLanguage.get() == .Portuguese {
                    self.value.append("Para Alugar")
                } else if XLanguage.get() == .Russian {
                    self.value.append("Сдается в аренду")
                } else if XLanguage.get() == .Chinese {
                    self.value.append("出租")
                } else if XLanguage.get() == .Hebrew {
                    self.value.append("להשכרה")
                } else if XLanguage.get() == .Greek {
                    self.value.append("Προς Ενοικίαση")
                } else if XLanguage.get() == .Hindi {
                    self.value.append("किराए के लिए")
                } else if XLanguage.get() == .Swedish {
                    self.value.append("För Uthyrning")
                }
                    
            }else{
                if XLanguage.get() == .Kurdish{
                    self.value.append("بۆ فرۆشتن")
                }else if XLanguage.get() == .Arabic{
                    self.value.append("للبيع")
                } else if XLanguage.get() == .English {
                    self.value.append("For Sale")
                } else if XLanguage.get() == .French {
                    self.value.append("À Vendre")
                } else if XLanguage.get() == .Spanish {
                    self.value.append("En Venta")
                } else if XLanguage.get() == .German {
                    self.value.append("Zum Verkauf")
                } else if XLanguage.get() == .Dutch {
                    self.value.append("Te Koop")
                } else if XLanguage.get() == .Portuguese {
                    self.value.append("À Venda")
                } else if XLanguage.get() == .Russian {
                    self.value.append("На Продажу")
                } else if XLanguage.get() == .Chinese {
                    self.value.append("出售")
                } else if XLanguage.get() == .Hebrew {
                    self.value.append("למכירה")
                } else if XLanguage.get() == .Greek {
                    self.value.append("Προς Πώληση")
                } else if XLanguage.get() == .Hindi {
                    self.value.append("बिक्री के लिए")
                } else if XLanguage.get() == .Swedish {
                    self.value.append("Till Salu")
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
                    
                        self.ProjectName.text = project.project_name
                        self.ProjectName.font = UIFont(name: "ArialRoundedMTBold", size: 17)!
                  
                    
                    
                }
                
                
                if XLanguage.get() == .Kurdish{
                    self.keys.append("کرێی خزمەتگوزارییەکانی مانگانە")
                    self.keys.append("باڵەخانە")
                    self.keys.append("نهۆم")
                    self.keys.append("ژمارەی خانووبەر")
                }else if XLanguage.get() == .Arabic{
                    self.keys.append("رسوم الخدمات الشهرية")
                    self.keys.append("عمارة")
                    self.keys.append("الطابق")
                    self.keys.append("رقم العقار")
                }else if XLanguage.get() == .Hebrew {
                    self.keys.append("דמי שירות חודשיים")
                    self.keys.append("בניין")
                    self.keys.append("קומה")
                    self.keys.append("מס' נכס")
                } else if XLanguage.get() == .Chinese {
                    self.keys.append("每月服务费")
                    self.keys.append("建筑")
                    self.keys.append("楼层")
                    self.keys.append("物业编号")
                } else if XLanguage.get() == .Hindi {
                    self.keys.append("मासिक सेवा शुल्क")
                    self.keys.append("इमारत")
                    self.keys.append("मंजिल")
                    self.keys.append("संपत्ति संख्या")
                } else if XLanguage.get() == .Portuguese {
                    self.keys.append("Taxa de Serviços Mensais")
                    self.keys.append("Edifício")
                    self.keys.append("Andar")
                    self.keys.append("Número do Imóvel")
                } else if XLanguage.get() == .Swedish {
                    self.keys.append("Månadsavgift för tjänster")
                    self.keys.append("Byggnad")
                    self.keys.append("Våning")
                    self.keys.append("Fastighetsnummer")
                } else if XLanguage.get() == .Greek {
                    self.keys.append("Μηνιαία Τέλη Υπηρεσιών")
                    self.keys.append("Κτίριο")
                    self.keys.append("Όροφος")
                    self.keys.append("Αριθμός Ακινήτου")
                } else if XLanguage.get() == .Russian {
                    self.keys.append("Ежемесячная плата за услуги")
                    self.keys.append("Здание")
                    self.keys.append("Этаж")
                    self.keys.append("Номер имущества")
                } else if XLanguage.get() == .Dutch {
                    self.keys.append("Maandelijkse Servicekosten")
                    self.keys.append("Gebouw")
                    self.keys.append("Verdieping")
                    self.keys.append("Eigendomsnummer")
                } else if XLanguage.get() == .French {
                    self.keys.append("Frais de services mensuels")
                    self.keys.append("Bâtiment")
                    self.keys.append("Étage")
                    self.keys.append("Numéro de propriété")
                } else if XLanguage.get() == .Spanish {
                    self.keys.append("Cuota de servicios mensuales")
                    self.keys.append("Edificio")
                    self.keys.append("Piso")
                    self.keys.append("Número de propiedad")
                } else if XLanguage.get() == .German {
                    self.keys.append("Monatliche Dienstleistungsgebühr")
                    self.keys.append("Gebäude")
                    self.keys.append("Stockwerk")
                    self.keys.append("Objektnummer")
                }else if XLanguage.get() == .English {
                    self.keys.append("Monthly Services Fee")
                    self.keys.append("Building")
                    self.keys.append("Floor")
                    self.keys.append("Property No.")
                }
                    
                    
                    
                    
                    
                    
                
                self.value.append(data.MonthlyService?.description.currencyFormattingIQD() ?? "")
                
                self.value.append(data.Building ?? "")
                
                self.value.append(data.floor ?? "")
                
                self.value.append(data.propertyNo ?? "")
                
                self.DataCollectionView.reloadData()
            }
            
            
            
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let estate = sender as? EstateObject{
            if let next = segue.destination as? DealVC{
                next.Estate = estate
            }
        }
    }
    
    @IBOutlet weak var BottomPrice: UILabel!
     
    @IBOutlet weak var CreateContract: LoadingButton!
    
    @IBAction func CreateContract(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: "Login") == true{
            if UserDefaults.standard.string(forKey: "OfficeId") ?? "" != self.CommingEstate?.office_id{
                self.CreateContract.showLoader(userInteraction: true)
                self.CreateContract.hideLoader()
                self.performSegue(withIdentifier: "GoToCreateContract", sender: self.CommingEstate)
            }
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVCViewController
            vc.modalPresentationStyle = .fullScreen
            vc.IsFromAnotherVc = true
            self.present(vc, animated: true)
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
                cell.imagee.sd_setImage(with: url, placeholderImage: UIImage(named: "logoPlace"))
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
            
            cell.Typee.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            cell.Value.font = UIFont(name: "ArialRoundedMTBold", size: 10)!
         
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




