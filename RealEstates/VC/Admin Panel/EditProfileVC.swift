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
    @IBOutlet weak var Save: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        Save.setTitleTextAttributes(
//            [
//                NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 15)!,
//                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
//            ], for: .normal)
        
        if XLanguage.get() == .English{
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 16)!]

        }else if XLanguage.get() == .Arabic{
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "PeshangDes2", size: 17)!]

        }else if XLanguage.get() == .Kurdish{
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "PeshangDes2", size: 17)!]

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
                self.Image.sd_setImage(with: url, completed: nil)
                self.Name.text = office.name ?? ""
                self.AboutMe.text = office.about ?? ""
                self.userTypeId = office.type_id ?? ""
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
    @IBAction func Save(_ sender: Any) {
        
        if XLanguage.get() == .Kurdish{
            self.titlee = "بەرزکردنەوەی زانیاریەکان"
            self.message = "ئایا دڵنیای لە نەرزکردنەوەی زانیاریەکان؟"
            self.Action = "بەڵێ"
            self.cancel = "نەخێر"
        }else if XLanguage.get() == . English{
            self.titlee = "Upload Information"
            self.message = "Are you sure to upload?"
            self.Action = "Yes"
            self.cancel = "No"
        }else{
            self.titlee = "رفع المعلومات"
            self.message = "هل أنت متأكد من رفع المعلومات؟"
            self.Action = "نعم"
            self.cancel = "لا"
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
                let okAction = UIAlertAction(title: self.Action, style: UIAlertAction.Style.default) {
                    UIAlertAction in
                   
                    if let FireId = UserDefaults.standard.string(forKey: "UserId"){
                            if self.Images.count == 0{
                                OfficesObject.init(name: self.Name.text!, id:self.Offiecid , fire_id: FireId, address: self.Location.text!,about: self.AboutMe.text!, phone1: self.Number1.text!, phone2: self.Number2.text!, ImageURL:self.OfficeImage, type_id: self.userTypeId, archived: "0").Update()
                            }else{
                                print(self.OfficeImage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
                                let imageUrl = self.OfficeImage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                                if let range = imageUrl.range(of: "?") {
                                    let ImageId = imageUrl.substring(to: range.lowerBound)
                                    Storage.storage().reference().child("Pictures").child(String(ImageId.suffix(36))).delete()
                                }
                                
                                self.uploadManyImage { URLs in
                                    OfficesObject.init(name: self.Name.text!, id:self.Offiecid , fire_id: FireId, address: self.Location.text!,about: self.AboutMe.text!, phone1: self.Number1.text!, phone2: self.Number2.text!, ImageURL:URLs[0], type_id: self.userTypeId, archived: "0").Update()
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
                if XLanguage.get() == .Kurdish{
                    let titl = "تکایە ناوی خۆت بنووسە"
                    let action = "بەڵێ"
                    let alertController = UIAlertController(title: "", message: titl, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: action, style: UIAlertAction.Style.cancel) { UIAlertAction in }
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                }else if XLanguage.get() == . English{
                    let titl = "Please write your name"
                    let action = "Cancel"
                    let alertController = UIAlertController(title: "", message: titl, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: action, style: UIAlertAction.Style.cancel) { UIAlertAction in }
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                }else{
                    let titl = "رجاءا اكتب اسمك"
                    let action = "إلغاء"
                    let alertController = UIAlertController(title: "", message: titl, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: action, style: UIAlertAction.Style.cancel) { UIAlertAction in }
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
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
