//
//  LoginVCViewController.swift
//  RealEstates
//
//  Created by botan pro on 3/8/22.
//

import UIKit
import PhoneNumberKit
import MHLoadingButton
import Firebase
import FirebaseAuth
import Alamofire
import SwiftyJSON
class LoginVCViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var Login: LoadingButton!
    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var Dismiss: UIButton!
    @IBOutlet weak var PhoneNumber: PhoneNumberTextField!
    
    @IBAction func Dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    var IsFromAnotherVc = false
    
    var TextLength = 0
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        TextLength = textField.text?.count ?? 0
        return false
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
        self.Dismiss.isHidden = true
        
        
        if self.IsFromAnotherVc == true{
            self.Dismiss.isHidden = false
        }else{
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }
        self.PhoneNumber.becomeFirstResponder()
        self.Login.layer.cornerRadius = 4
        self.View1.layer.cornerRadius = 4
        
        self.PhoneNumber.keyboardType = .asciiCapable
        self.PhoneNumber.withPrefix = true
        self.PhoneNumber.withFlag = true
        self.PhoneNumber.withExamplePlaceholder = true
        
        Login.indicator = MaterialLoadingIndicator(color: .gray)

        
        if XLanguage.get() == .Kurdish{
            self.Login.setTitle("بەردەوام بوون" , for: .normal)
            self.Login.titleLabel?.font = UIFont(name: "PeshangDes2", size: 11)!
        }else if XLanguage.get() == .Arabic{
            self.Login.setTitle("استمرار" , for: .normal)
            self.Login.titleLabel?.font = UIFont(name: "PeshangDes2", size: 11)!
        }else if XLanguage.get() == .English {
            self.Login.setTitle("Next", for: .normal)
            self.Login.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 11)!

        } else if XLanguage.get() == .French {
            self.Login.setTitle("Suivant", for: .normal)
            self.Login.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 11)!

        } else if XLanguage.get() == .Spanish {
            self.Login.setTitle("Siguiente", for: .normal)
            self.Login.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 11)!

        } else if XLanguage.get() == .German {
            self.Login.setTitle("Weiter", for: .normal)
            self.Login.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 11)!

        } else if XLanguage.get() == .Dutch {
            self.Login.setTitle("Volgende", for: .normal)
            self.Login.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 11)!

        } else if XLanguage.get() == .Portuguese {
            self.Login.setTitle("Próximo", for: .normal)
            self.Login.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 11)!

        } else if XLanguage.get() == .Russian {
            self.Login.setTitle("Далее", for: .normal)
            self.Login.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 11)!

        } else if XLanguage.get() == .Chinese {
            self.Login.setTitle("下一步", for: .normal)
            self.Login.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 11)!

        } else if XLanguage.get() == .Hindi {
            self.Login.setTitle("अगला", for: .normal)
            self.Login.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 11)!

        } else if XLanguage.get() == .Swedish {
            self.Login.setTitle("Nästa", for: .normal)
            self.Login.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 11)!

        } else if XLanguage.get() == .Greek {
            self.Login.setTitle("Επόμενο", for: .normal)
            self.Login.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
        } else if XLanguage.get() == .Hebrew {
            self.Login.setTitle("הבא", for: .normal)
            self.Login.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
        }

        
        
        
    }
    
    
    var IsSuccess = false
    var phone = ""
    @IBAction func Login(_ sender: Any) {
        print(self.PhoneNumber.text!)
        if self.PhoneNumber.text != ""{
            let str = self.PhoneNumber.text!
            if str.count > 5{
                let index = str.index(str.startIndex, offsetBy: 5)
                if str[index] == "0" && self.PhoneNumber.currentRegion == "IQ"{
                    self.phone = self.PhoneNumber.text!
                    self.phone.remove(at: index)
                }else{
                    self.phone = self.PhoneNumber.text!
                }
            }
            
            
        
            print(self.PhoneNumber.text?.replace(string: " ", replacement: "") ?? "")
            Login.showLoader(userInteraction: true)
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let myVC = storyboard.instantiateViewController(withIdentifier: "VeryingVC") as! VerifyingVC
            OfficeAip.GetOfficeByPhone(phone: self.PhoneNumber.text!, completion: { office in
                
                if office.type_id == ""{
                        myVC.type_id = "h9nFfUrHgSwIg17uRwTD"
    
                    
                    let stringUrl = URL(string: API.URL);
                    let param: [String: Any] = [
                        "key":API.key,
                        "username":API.UserName,
                        "fun": "send_otp",
                        "phone": self.PhoneNumber.text?.replace(string: " ", replacement: "") ?? ""
                    ]
                    
                    AF.request(stringUrl!, method: .post, parameters: param).responseData { (response) in
                        switch response.result
                        {
                        case .success(_):
                            let jsonData = JSON(response.data ?? "")
                            for (_, val) in jsonData{
                                if let error = val["error"].string{
                                    self.IsSuccess = false
                                    let myAlert = UIAlertController(title: nil, message: error, preferredStyle: UIAlertController.Style.alert)
                                    myAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
                                    self.present(myAlert, animated: true, completion: nil)
                                }else{
                                    print("Success")
                                    self.IsSuccess = true
                                    UserDefaults.standard.set(self.PhoneNumber.text?.replace(string: " ", replacement: "") ?? "", forKey: "PhoneNumber")
                                   
                                    
                                    print(jsonData)
                                }
                            }
                            
                            if self.IsSuccess == true {
                                if self.IsFromAnotherVc == false{
                                    self.navigationController?.pushViewController(myVC, animated: true)
                                }else{
                                    myVC.modalPresentationStyle = .fullScreen
                                    myVC.IsFromAnotherVc = true
                                    self.present(myVC, animated: true)
                                }
                                
                                
                                self.Login.hideLoader()
                            }
                            
                        case .failure(let error):
                            print(error);
                        }
                    }
                    

                }else{
                    
                    let stringUrl = URL(string: API.URL);
                    let param: [String: Any] = [
                        "key":API.key,
                        "username":API.UserName,
                        "fun": "send_otp",
                        "phone": self.PhoneNumber.text?.replace(string: " ", replacement: "") ?? ""
                    ]
                    
                    AF.request(stringUrl!, method: .post, parameters: param).responseData { (response) in
                        switch response.result
                        {
                        case .success(_):
                            let jsonData = JSON(response.data ?? "")
                            print("------88")
                            print(jsonData)
                            
                            for (_, val) in jsonData{
                                if let error = val["error"].string{
                                    self.IsSuccess = false
                                    print(error)
                                    let myAlert = UIAlertController(title: nil, message: error, preferredStyle: UIAlertController.Style.alert)
                                    myAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
                                    self.present(myAlert, animated: true, completion: nil)
                                }else{
                                    print("Success")
                                    self.IsSuccess = true
                                    UserDefaults.standard.set(self.PhoneNumber.text?.replace(string: " ", replacement: "") ?? "", forKey: "PhoneNumber")
                                    
                                    myVC.type_id = office.type_id ?? ""
                                   
                                }
                            }
                            
                            if self.IsSuccess == true{
                                if self.IsFromAnotherVc == false{
                                    self.navigationController?.pushViewController(myVC, animated: true)
                                }else{
                                    myVC.modalPresentationStyle = .fullScreen
                                    myVC.IsFromAnotherVc = true
                                    self.present(myVC, animated: true)
                                }
                                self.Login.hideLoader()
                            }
                           
                            
                        case .failure(let error):
                            print(error);
                        }
                    }
                    
                }
            })
                                    
                                    
        }else{
            self.Login.hideLoader()
            if self.PhoneNumber.text == ""{
                var mss = ""
                var action = ""
                if XLanguage.get() == .Kurdish{
                    mss = "تکایە ژمارەی تەلەفۆن بنووسە"
                    action = "باشە"
                }else   if XLanguage.get() == .Arabic{
                    mss = "الرجاء إدخال رقم الهاتف"
                    action = "حسنا"
                } else if XLanguage.get() == .English {
                    mss = "Please enter phone number"
                    action = "Ok"
                } else if XLanguage.get() == .French {
                    mss = "Veuillez entrer le numéro de téléphone"
                    action = "D'accord"
                } else if XLanguage.get() == .Spanish {
                    mss = "Por favor, ingrese el número de teléfono"
                    action = "Ok"
                } else if XLanguage.get() == .German {
                    mss = "Bitte Telefonnummer eingeben"
                    action = "Ok"
                } else if XLanguage.get() == .Dutch {
                    mss = "Voer alstublieft het telefoonnummer in"
                    action = "Ok"
                } else if XLanguage.get() == .Portuguese {
                    mss = "Por favor, insira o número de telefone"
                    action = "Ok"
                } else if XLanguage.get() == .Russian {
                    mss = "Пожалуйста, введите номер телефона"
                    action = "Ок"
                } else if XLanguage.get() == .Chinese {
                    mss = "请输入电话号码"
                    action = "确定"
                } else if XLanguage.get() == .Hindi {
                    mss = "कृपया फ़ोन नंबर दर्ज करें"
                    action = "ठीक है"
                } else if XLanguage.get() == .Swedish {
                    mss = "Vänligen ange telefonnummer"
                    action = "Ok"
                } else if XLanguage.get() == .Greek {
                    mss = "Παρακαλώ εισάγετε τον αριθμό τηλεφώνου"
                    action = "Εντάξει"
                } else if XLanguage.get() == .Hebrew {
                    mss = "אנא הכנס מספר טלפון"
                    action = "אישור"
                }

                let myAlert = UIAlertController(title: nil, message: mss, preferredStyle: UIAlertController.Style.alert)
                myAlert.addAction(UIAlertAction(title: action, style: UIAlertAction.Style.default, handler: nil))
                self.present(myAlert, animated: true, completion: nil)
            }
        }
    }
    
   
    
    
    
}
class MyGBTextField: PhoneNumberTextField {
    override var defaultRegion: String {
        get {
            return "IQ"
        }
        set {}
    }
}



//
//
//var title = ""
//var mssg = ""
//var office = ""
//var user = ""
//
// if XLanguage.get() == .Arabic{
//    title = "نوع المستخدم"
//    mssg = "هل انت مستخدم ام مكتب؟؟"
//    office = "المكتب"
//    user = "المستخدم"
// }else  if XLanguage.get() == .Kurdish{
//    title = "جۆری بەکارهێنەر"
//    mssg = "ئایا تۆ بەکارهێنەریت یان نووسینگە؟؟"
//    office = "نووسینگە"
//    user = "بەکارهێنەر"
//} else if XLanguage.get() == .English {
//    title = "User Type"
//    mssg = "Are you a User or an Office?"
//    office = "Office"
//    user = "User"
//} else if XLanguage.get() == .French {
//    title = "Type d'utilisateur"
//    mssg = "Êtes-vous un utilisateur ou un bureau ?"
//    office = "Bureau"
//    user = "Utilisateur"
//} else if XLanguage.get() == .Spanish {
//    title = "Tipo de Usuario"
//    mssg = "¿Eres un Usuario o una Oficina?"
//    office = "Oficina"
//    user = "Usuario"
//} else if XLanguage.get() == .German {
//    title = "Benutzertyp"
//    mssg = "Bist du ein Benutzer oder ein Büro?"
//    office = "Büro"
//    user = "Benutzer"
//} else if XLanguage.get() == .Dutch {
//    title = "Gebruikerstype"
//    mssg = "Bent u een gebruiker of een kantoor?"
//    office = "Kantoor"
//    user = "Gebruiker"
//} else if XLanguage.get() == .Portuguese {
//    title = "Tipo de Usuário"
//    mssg = "Você é um Usuário ou um Escritório?"
//    office = "Escritório"
//    user = "Usuário"
//} else if XLanguage.get() == .Russian {
//    title = "Тип пользователя"
//    mssg = "Вы пользователь или офис?"
//    office = "Офис"
//    user = "Пользователь"
//} else if XLanguage.get() == .Chinese {
//    title = "用户类型"
//    mssg = "您是用户还是办公室？"
//    office = "办公室"
//    user = "用户"
//} else if XLanguage.get() == .Hindi {
//    title = "उपयोगकर्ता प्रकार"
//    mssg = "क्या आप एक उपयोगकर्ता हैं या एक कार्यालय?"
//    office = "कार्यालय"
//    user = "उपयोगकर्ता"
//} else if XLanguage.get() == .Hebrew {
//    title = "סוג משתמש"
//    mssg = "האם אתה משתמש או משרד?"
//    office = "משרד"
//    user = "משתמש"
//}
//
//
//let myAlert = UIAlertController(title: title, message: mssg, preferredStyle: UIAlertController.Style.alert)
//myAlert.addAction(UIAlertAction(title: office, style: .default, handler: { (UIAlertActionn) in
//    myVC.type_id = "h9nFfUrHgSwIg17uRwTD"
//    PhoneAuthProvider.provider().verifyPhoneNumber(self.phone.convertedDigitsToLocale(Locale(identifier: "EN")), uiDelegate: nil) { (verificationID, error) in
//        if let error = error {
//            print(error)
//            self.Login.hideLoader()
//            let myMessage = error.localizedDescription
//            let myAlert = UIAlertController(title: myMessage, message: nil, preferredStyle: UIAlertController.Style.alert)
//            myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//            self.present(myAlert, animated: true, completion: nil)
//            return
//        }
//        
//        
//        UserDefaults.standard.set(self.PhoneNumber.text!, forKey: "PhoneNumber")
//        UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
//       
//        if self.IsFromAnotherVc == false{
//            self.navigationController?.pushViewController(myVC, animated: true)
//        }else{
//            myVC.modalPresentationStyle = .fullScreen
//            myVC.IsFromAnotherVc = true
//            self.present(myVC, animated: true)
//        }
//        
//        
//        self.Login.hideLoader()
//    }
//}))
//
//myAlert.addAction(UIAlertAction(title: user, style: .default, handler: { (UIAlertActionn) in
//    myVC.type_id = "1kMcAwX8d1WMUhBanY4F"
//    PhoneAuthProvider.provider().verifyPhoneNumber(self.phone.convertedDigitsToLocale(Locale(identifier: "EN")), uiDelegate: nil) { (verificationID, error) in
//        if let error = error {
//            print(error)
//            self.Login.hideLoader()
//            let myMessage = error.localizedDescription
//            let myAlert = UIAlertController(title: myMessage, message: nil, preferredStyle: UIAlertController.Style.alert)
//            myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//            self.present(myAlert, animated: true, completion: nil)
//            return
//        }
//        
//        
//        UserDefaults.standard.set(self.PhoneNumber.text!, forKey: "PhoneNumber")
//        UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
//       
//        if self.IsFromAnotherVc == false{
//            self.navigationController?.pushViewController(myVC, animated: true)
//        }else{
//            myVC.modalPresentationStyle = .fullScreen
//            myVC.IsFromAnotherVc = true
//            self.present(myVC, animated: true)
//        }
//        
//        
//        self.Login.hideLoader()
//    }
//}))
//self.present(myAlert, animated: true, completion: nil)
