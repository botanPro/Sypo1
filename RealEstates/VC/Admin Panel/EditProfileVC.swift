//
//  EditProfileVC.swift
//  RealEstates
//
//  Created by botan pro on 2/7/22.
//

import UIKit
import BSImagePicker
import Photos
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
class EditProfileVC: UIViewController ,UITextFieldDelegate, UITextViewDelegate{

    
    @IBOutlet weak var ScrollViewLayout: NSLayoutConstraint!
    @IBOutlet weak var EditImage: UIButton!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var Number1: UITextField!
    @IBOutlet weak var Number2: UITextField!
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Location: UITextField!
    @IBOutlet weak var AboutMe: UITextView!
    
    var userTypeId = ""
    var Offiecid = ""
    var OfficeImage = ""
    var subscription_id = ""
    var contract_image = ""
    var arabic_name = ""
    var one_signal_uuid = ""
    
    @IBOutlet weak var Save: UIBarButtonItem!
    var IsInternetChecked = false
    
    @IBOutlet weak var InternetViewHeight: NSLayoutConstraint!
    @IBOutlet weak var InternetConnectionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.InternetViewHeight.constant = 0
        self.InternetConnectionView.isHidden = true

    
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        
        
        if XLanguage.get() == .Arabic{
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "PeshangDes2", size: 16)!,.foregroundColor: #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)]
        }else if XLanguage.get() == .Kurdish{
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "PeshangDes2", size: 16)!,.foregroundColor: #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)]
        }else {
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 16)!,.foregroundColor: #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)]
        }
        
        
        
        self.Image.layer.cornerRadius = self.Image.bounds.width / 2
        if let FireId = UserDefaults.standard.string(forKey: "UserId"){
            OfficeAip.GetOfficeById(Id: FireId) { office in
                self.Offiecid = office.id ?? ""
                self.Number1.text = office.phone1
                self.Number2.text = office.phone2
                self.Location.text = office.address
                self.OfficeImage = office.ImageURL ?? ""
                let url = URL(string: office.ImageURL ?? "")
                self.Image.sd_setImage(with: url,  placeholderImage: UIImage(named: "logoPlace"))
                self.Name.text = office.name ?? ""
                self.AboutMe.text = office.about ?? ""
                self.userTypeId = office.type_id ?? ""
                self.subscription_id = office.subscription_id ?? ""
                
                self.contract_image = office.contract_image  ?? ""
                self.arabic_name = office.arabic_name ?? ""
                
                self.one_signal_uuid = office.one_signal_uuid ?? ""
            }
        }
        
        
       
        
        self.EditImage.layer.cornerRadius = 5
        self.EditImage.layer.borderColor = #colorLiteral(red: 0.4430069923, green: 0.4869378209, blue: 0.5339931846, alpha: 1)
        self.EditImage.layer.borderWidth = 1.1
        self.Number1.isUserInteractionEnabled = false
        self.Name.delegate = self
        self.Location.delegate = self
        self.AboutMe.delegate = self
        self.Number2.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasHiden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    var count = 1
    @objc func keyboardWasShown(notification: NSNotification) {
        if count == 1{
           count += 1
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        self.ScrollViewLayout.constant += keyboardFrame.height - 100
        }
    }
    
    @objc func keyboardWasHiden(notification: NSNotification) {
        self.ScrollViewLayout.constant = 0
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    

    
    func EmptyTextField(_ textfield : UITextField){
        AudioServicesPlaySystemSound(1519);
        textfield.layer.borderColor = UIColor.red.cgColor;
        textfield.layer.borderWidth = 1.5 ;
        textfield.layer.cornerRadius = 5 ;
        textfield.clipsToBounds = false
        textfield.layer.shadowOpacity=0.4
        textfield.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    
    var titlee = ""
    var message = ""
    var Action = ""
    var cancel = ""
    @IBAction func Save(_ sender: Any){
        if CheckInternet.Connection(){
            UIView.animate(withDuration: 0.3) {
                self.InternetViewHeight.constant = 0
                self.InternetConnectionView.isHidden = true
                self.view.layoutIfNeeded()
            }
        if XLanguage.get() == .Kurdish{
            self.titlee = "بەرزکردنەوەی زانیاریەکان"
            self.message = "ئایا دڵنیای لە نەرزکردنەوەی زانیاریەکان؟"
            self.Action = "بەڵێ"
            self.cancel = "نەخێر"
        }else if XLanguage.get() == .Arabic{
            self.titlee = "رفع المعلومات"
            self.message = "هل أنت متأكد من رفع المعلومات؟"
            self.Action = "نعم"
            self.cancel = "لا"
        }else if XLanguage.get() == .English {
            self.titlee = "Upload Information"
            self.message = "Are you sure to upload?"
            self.Action = "Yes"
            self.cancel = "No"
        } else if XLanguage.get() == .Dutch {
            self.titlee = "Informatie Uploaden"
            self.message = "Weet je zeker dat je wilt uploaden?"
            self.Action = "Ja"
            self.cancel = "Nee"
        } else if XLanguage.get() == .French {
            self.titlee = "Téléverser des Informations"
            self.message = "Êtes-vous sûr de vouloir téléverser ?"
            self.Action = "Oui"
            self.cancel = "Non"
        } else if XLanguage.get() == .Spanish {
            self.titlee = "Subir Información"
            self.message = "¿Estás seguro de que quieres subirlo?"
            self.Action = "Sí"
            self.cancel = "No"
        } else if XLanguage.get() == .German {
            self.titlee = "Informationen Hochladen"
            self.message = "Sind Sie sicher, dass Sie hochladen möchten?"
            self.Action = "Ja"
            self.cancel = "Nein"
        } else if XLanguage.get() == .Hebrew {
            self.titlee = "העלאת מידע"
            self.message = "האם אתה בטוח שברצונך להעלות?"
            self.Action = "כן"
            self.cancel = "לא"
        } else if XLanguage.get() == .Chinese {
            self.titlee = "上传信息"
            self.message = "您确定要上传吗？"
            self.Action = "是"
            self.cancel = "否"
        } else if XLanguage.get() == .Hindi {
            self.titlee = "जानकारी अपलोड करें"
            self.message = "क्या आप सुनिश्चित हैं कि अपलोड करना चाहते हैं?"
            self.Action = "हाँ"
            self.cancel = "नहीं"
        } else if XLanguage.get() == .Portuguese {
            self.titlee = "Carregar Informação"
            self.message = "Tem certeza de que deseja carregar?"
            self.Action = "Sim"
            self.cancel = "Não"
        } else if XLanguage.get() == .Swedish {
            self.titlee = "Ladda upp Information"
            self.message = "Är du säker på att du vill ladda upp?"
            self.Action = "Ja"
            self.cancel = "Nej"
        } else if XLanguage.get() == .Greek {
            self.titlee = "Ανέβασμα Πληροφοριών"
            self.message = "Είστε σίγουροι ότι θέλετε να ανεβάσετε;"
            self.Action = "Ναι"
            self.cancel = "Όχι"
        } else if XLanguage.get() == .Russian {
            self.titlee = "Загрузка Информации"
            self.message = "Вы уверены, что хотите загрузить?"
            self.Action = "Да"
            self.cancel = "Нет"
        }
        
        
        self.Name.layer.borderWidth = 0
        self.Name.layer.shadowOpacity = 0
        self.Name.layer.shadowColor = UIColor.clear.cgColor
        self.Location.layer.borderWidth = 0
        self.Location.layer.shadowOpacity = 0
        self.Location.layer.shadowColor = UIColor.clear.cgColor
        guard self.Name.text!.isEmpty == false else{EmptyTextField(self.Name); return }
       
        guard self.Location.text!.isEmpty == false else{EmptyTextField(self.Location);return}
        
    
            if self.Name.text!.trimmingCharacters(in: .whitespaces).isEmpty == false{
                let alertController = UIAlertController(title: self.titlee, message: self.message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: self.Action, style: UIAlertAction.Style.default){  UIAlertAction in
                   
                    if let FireId = UserDefaults.standard.string(forKey: "UserId"){
                            if self.Images.count == 0{
                                OfficesObject.init(name: self.Name.text!, id:self.Offiecid , fire_id: FireId, address: self.Location.text!,about: self.AboutMe.text!, phone1: self.Number1.text!, phone2: self.Number2.text!, ImageURL:self.OfficeImage, type_id: self.userTypeId, archived: "0",subscription_id: self.subscription_id,contract_image: self.contract_image ,arabic_name: self.arabic_name, one_signal_uuid: self.one_signal_uuid).Update()
                            }else{
                                print(self.OfficeImage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
                                let imageUrl = self.OfficeImage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                                if let range = imageUrl.range(of: "?") {
                                    let ImageId = imageUrl.substring(to: range.lowerBound)
                                    Task{
                                        do{
                                            try await Storage.storage().reference().child("Pictures").child(String(ImageId.suffix(36))).delete()
                                        }catch {
                                            print(error)
                                        }
                                    }
                                }
                                
                                self.uploadManyImage { URLs in
                                    OfficesObject.init(name: self.Name.text!, id:self.Offiecid , fire_id: FireId, address: self.Location.text!,about: self.AboutMe.text!, phone1: self.Number1.text!, phone2: self.Number2.text!, ImageURL:URLs[0], type_id: self.userTypeId, archived: "0",subscription_id: self.subscription_id,contract_image: self.contract_image ,arabic_name: self.arabic_name, one_signal_uuid: self.one_signal_uuid).Update()
                                }
                        }
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                let cancelAction = UIAlertAction(title: self.cancel, style: UIAlertAction.Style.cancel) { UIAlertAction in }
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            }else{
                
                let language = XLanguage.get()
                switch language {
                case .English:
                    let title = "Please write your name"
                    let action = "Cancel"
                    let alertController = UIAlertController(title: "", message: title, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: action, style: UIAlertAction.Style.cancel) { UIAlertAction in }
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                case .Dutch:
                    let title = "Vul alstublieft uw naam in"
                    let action = "Annuleren"
                    let alertController = UIAlertController(title: "", message: title, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: action, style: UIAlertAction.Style.cancel) { UIAlertAction in }
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                case .French:
                    let title = "Veuillez écrire votre nom"
                    let action = "Annuler"
                    let alertController = UIAlertController(title: "", message: title, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: action, style: UIAlertAction.Style.cancel) { UIAlertAction in }
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                case .Spanish:
                    let title = "Por favor, escriba su nombre"
                    let action = "Cancelar"
                    let alertController = UIAlertController(title: "", message: title, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: action, style: UIAlertAction.Style.cancel) { UIAlertAction in }
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                case .German:
                    let title = "Bitte geben Sie Ihren Namen ein"
                    let action = "Abbrechen"
                    let alertController = UIAlertController(title: "", message: title, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: action, style: UIAlertAction.Style.cancel) { UIAlertAction in }
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                case .Hebrew:
                    let title = "אנא כתוב את שמך"
                    let action = "ביטול"
                    let alertController = UIAlertController(title: "", message: title, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: action, style: UIAlertAction.Style.cancel) { UIAlertAction in }
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                case .Chinese:
                    let title = "请写下你的名字"
                    let action = "取消"
                    let alertController = UIAlertController(title: "", message: title, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: action, style: UIAlertAction.Style.cancel) { UIAlertAction in }
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                case .Hindi:
                    let title = "कृपया अपना नाम लिखें"
                    let action = "रद्द करें"
                    let alertController = UIAlertController(title: "", message: title, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: action, style: UIAlertAction.Style.cancel) { UIAlertAction in }
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                case .Portuguese:
                    let title = "Por favor, escreva seu nome"
                    let action = "Cancelar"
                    let alertController = UIAlertController(title: "", message: title, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: action, style: UIAlertAction.Style.cancel) { UIAlertAction in }
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                case .Swedish:
                    let title = "Vänligen skriv ditt namn"
                    let action = "Avbryt"
                    let alertController = UIAlertController(title: "", message: title, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: action, style: UIAlertAction.Style.cancel) { UIAlertAction in }
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                case .Greek:
                    let title = "Παρακαλώ γράψτε το όνομά σας"
                    let action = "Ακύρωση"
                    let alertController = UIAlertController(title: "", message: title, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: action, style: UIAlertAction.Style.cancel) { UIAlertAction in }
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                case .Russian:
                    let title = "Пожалуйста, напишите ваше имя"
                    let action = "Отмена"
                    let alertController = UIAlertController(title: "", message: title, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: action, style: UIAlertAction.Style.cancel) { UIAlertAction in }
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                case .Arabic:
                    let titl = "رجاءا اكتب اسمك"
                    let action = "إلغاء"
                    let alertController = UIAlertController(title: "", message: titl, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: action, style: UIAlertAction.Style.cancel) { UIAlertAction in }
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                case .Kurdish:
                    let titl = "تکایە ناوی خۆت بنووسە"
                    let action = "بەڵێ"
                    let alertController = UIAlertController(title: "", message: titl, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: action, style: UIAlertAction.Style.cancel) { UIAlertAction in }
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                default:
                    let title = "Please write your name"
                    let action = "Cancel"
                    let alertController = UIAlertController(title: "", message: title, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: action, style: UIAlertAction.Style.cancel) { UIAlertAction in }
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                
                
                
                
            }
        }else{
            UIView.animate(withDuration: 0.3) {
                self.InternetViewHeight.constant = 20
                self.InternetConnectionView.isHidden = false
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    
    
    var SelectedAssets = [PHAsset]()
    var Images : [UIImage] = []
    @IBAction func EditImage(_ sender: Any) {
            self.SelectedAssets.removeAll()
            let vc = BSImagePickerViewController()
            bs_presentImagePickerController(vc, animated: true,
                                            select: { (asset: PHAsset) -> Void in
            }, deselect: { (asset: PHAsset) -> Void in
            }, cancel: { (assets: [PHAsset]) -> Void in
            }, finish: { (assets: [PHAsset]) -> Void in
                for i in 0..<assets.count{
                    self.SelectedAssets.append(assets[i])
                    print(self.SelectedAssets)
                }
                self.getAllImages()
            }, completion: nil)
    }
    
    
    func getAllImages() -> Void {
        if SelectedAssets.count != 0{
            for i in 0..<SelectedAssets.count{
                let manager = PHImageManager.default()
                let option = PHImageRequestOptions()
                var thumbnail = UIImage()
                option.isSynchronous = true
                manager.requestImage(for: SelectedAssets[i], targetSize: CGSize(width: 512, height: 512), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
                    thumbnail = result!
                })
                self.Images.append(thumbnail)
                self.Image.image = thumbnail
            }
        }
    }
    
    func uploadManyImage(complition : @escaping (_ URLs: [String])->()){
        var uploadedImages : [String] = []
        for one in self.Images{
            one.upload { (url) in
                uploadedImages.append(url)
                if self.Images.count == uploadedImages.count{
                    complition(uploadedImages)
                }
            }
        }
    }
    
}
