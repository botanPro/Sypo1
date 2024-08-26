//
//  VerifyingVC.swift
//  RealEstates
//
//  Created by botan pro on 3/8/22.
//

import UIKit
import OTPTextField
import MHLoadingButton
import Firebase
import FirebaseAuth
import Alamofire
import SwiftyJSON
class VerifyingVC: UIViewController {

    @IBOutlet weak var Verify: LoadingButton!
    @IBOutlet weak var OTPCode: OTPTextField!
    @IBOutlet weak var Dismiss: UIButton!
    
    var type_id = ""
    
    var IsFromAnotherVc = false
    @IBAction func Dismis(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var VerifingLable: LanguageLable!
    @IBOutlet weak var phonenumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Dismiss.isHidden = true
        
        if self.IsFromAnotherVc == true{
            self.Dismiss.isHidden = false
        }else{
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }
        
        self.OTPCode.becomeFirstResponder()
        self.Verify.layer.cornerRadius = 4
        Verify.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        Verify.layer.shadowOpacity = 1
        Verify.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        Verify.layer.shadowRadius = 2
        let phone = UserDefaults.standard.string(forKey: "PhoneNumber") ?? ""
        
        if XLanguage.get() == .Kurdish{
            self.VerifingLable.text = "کورتەنامەیەک نێردراوە بۆ "
            self.phonenumber.text = phone
            self.VerifingLable.textAlignment = .right
            self.phonenumber.textAlignment = .right
            self.VerifingLable.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.VerifingLable.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.phonenumber.font = UIFont(name: "PeshangDes2", size: 13)!
        }else if XLanguage.get() == .Arabic{
            let phone = UserDefaults.standard.string(forKey: "PhoneNumber") ?? ""
            self.VerifingLable.text = "تم إرسال SMS إلى "
            self.phonenumber.text = phone
            self.VerifingLable.textAlignment = .right
            self.phonenumber.textAlignment = .right
            self.VerifingLable.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.VerifingLable.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.phonenumber.font = UIFont(name: "PeshangDes2", size: 13)!
        } else if XLanguage.get() == .English {
            self.VerifingLable.text = "An SMS was sent to "
            self.phonenumber.text = phone
            self.VerifingLable.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.VerifingLable.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.phonenumber.font = UIFont(name: "PeshangDes2", size: 13)!
        } else if XLanguage.get() == .French {
            self.VerifingLable.text = "Un SMS a été envoyé à "
            self.phonenumber.text = phone
            self.VerifingLable.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.VerifingLable.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.phonenumber.font = UIFont(name: "PeshangDes2", size: 13)!
        } else if XLanguage.get() == .Spanish {
            self.VerifingLable.text = "Se envió un SMS a "
            self.phonenumber.text = phone
            self.VerifingLable.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.VerifingLable.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.phonenumber.font = UIFont(name: "PeshangDes2", size: 13)!
        } else if XLanguage.get() == .German {
            self.VerifingLable.text = "Eine SMS wurde gesendet an "
            self.phonenumber.text = phone
            self.VerifingLable.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.VerifingLable.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.phonenumber.font = UIFont(name: "PeshangDes2", size: 13)!
        } else if XLanguage.get() == .Dutch {
            self.VerifingLable.text = "Een sms is verzonden naar "
            self.phonenumber.text = phone
            self.VerifingLable.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.VerifingLable.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.phonenumber.font = UIFont(name: "PeshangDes2", size: 13)!
        } else if XLanguage.get() == .Portuguese {
            self.VerifingLable.text = "Um SMS foi enviado para "
            self.phonenumber.text = phone
            self.VerifingLable.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.VerifingLable.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.phonenumber.font = UIFont(name: "PeshangDes2", size: 13)!
        } else if XLanguage.get() == .Russian {
            self.VerifingLable.text = "SMS было отправлено на "
            self.phonenumber.text = phone
            self.VerifingLable.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.VerifingLable.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.phonenumber.font = UIFont(name: "PeshangDes2", size: 13)!
        } else if XLanguage.get() == .Chinese {
            self.VerifingLable.text = "已发送短信至 "
            self.phonenumber.text = phone
            self.VerifingLable.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.VerifingLable.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.phonenumber.font = UIFont(name: "PeshangDes2", size: 13)!
        } else if XLanguage.get() == .Hindi {
            self.VerifingLable.text = "एक एसएमएस भेजा गया था "
            self.phonenumber.text = phone
            self.VerifingLable.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.VerifingLable.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.phonenumber.font = UIFont(name: "PeshangDes2", size: 13)!
        } else if XLanguage.get() == .Swedish {
            self.VerifingLable.text = "Ett SMS skickades till "
            self.phonenumber.text = phone
            self.VerifingLable.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.VerifingLable.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.phonenumber.font = UIFont(name: "PeshangDes2", size: 13)!
        } else if XLanguage.get() == .Greek {
            self.VerifingLable.text = "Ένα SMS εστάλη στο "
            self.phonenumber.text = phone
            self.VerifingLable.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.VerifingLable.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.phonenumber.font = UIFont(name: "PeshangDes2", size: 13)!
        } else if XLanguage.get() == .Hebrew {
            self.VerifingLable.text = "נשלחה הודעת SMS אל "
            self.phonenumber.text = phone
            self.VerifingLable.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.VerifingLable.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.phonenumber.font = UIFont(name: "PeshangDes2", size: 13)!
        }
        
        Verify.indicator = MaterialLoadingIndicator(color: .gray)



        self.Verify.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
        if XLanguage.get() == .Kurdish{
            self.Verify.setTitle("پشتڕاستکردنەوە" , for: .normal)
            self.Verify.titleLabel?.font = UIFont(name: "PeshangDes2", size: 11)!
        }else if XLanguage.get() == .Arabic{
            self.Verify.setTitle("تحقق" , for: .normal)
            self.Verify.titleLabel?.font = UIFont(name: "PeshangDes2", size: 11)!
        } else if XLanguage.get() == .English {
            self.Verify.setTitle("Verify", for: .normal)
        } else if XLanguage.get() == .French {
            self.Verify.setTitle("Vérifier", for: .normal)
        } else if XLanguage.get() == .Spanish {
            self.Verify.setTitle("Verificar", for: .normal)
        } else if XLanguage.get() == .German {
            self.Verify.setTitle("Überprüfen", for: .normal)
        } else if XLanguage.get() == .Dutch {
            self.Verify.setTitle("Verifiëren", for: .normal)
        } else if XLanguage.get() == .Portuguese {
            self.Verify.setTitle("Verificar", for: .normal)
        } else if XLanguage.get() == .Russian {
            self.Verify.setTitle("Проверить", for: .normal)
        } else if XLanguage.get() == .Chinese {
            self.Verify.setTitle("验证", for: .normal)
        } else if XLanguage.get() == .Hindi {
            self.Verify.setTitle("सत्यापित करें", for: .normal)
        } else if XLanguage.get() == .Swedish {
            self.Verify.setTitle("Verifiera", for: .normal)
        } else if XLanguage.get() == .Greek {
            self.Verify.setTitle("Επαλήθευση", for: .normal)
        }else if XLanguage.get() == .Hebrew {
            self.Verify.setTitle("אימות", for: .normal)
        }
        
    }
    
    
    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }
    
    var IsSuccess = false
    var count = 0
    var UserTypeFound = false
    
    var UserId = ""
    @IBAction func Verify(_ sender: Any) {
        self.Verify.isEnabled = false
        if self.OTPCode.text! != ""{
            
            Verify.showLoader(userInteraction: true)
           
            
            let stringUrl = URL(string: API.URL);
            let param: [String: Any] = [
                "key":API.key,
                "username":API.UserName,
                "fun": "verify_otp",
                "phone": UserDefaults.standard.string(forKey: "PhoneNumber") ?? "",
                "otp": self.OTPCode.text!
            ]
            
            AF.request(stringUrl!, method: .post, parameters: param).responseData { (response) in
                switch response.result
                {
                case .success(_):
                    let jsonData = JSON(response.data ?? "")
                    
                    print(jsonData)
                        let token = jsonData["custom_token"].string ?? ""
                        print(token)
                        
                        Auth.auth().signIn(withCustomToken: token) { (authResult, error) in
                            if let error = error {
                                self.IsSuccess = false
                                UserDefaults.standard.set(false, forKey: "Login")
                                UserDefaults.standard.set("", forKey: "PhoneNumber")
                                self.Verify.hideLoader()
                                self.Verify.isEnabled = true
                                let myMessage = error.localizedDescription
                                let myAlert = UIAlertController(title: myMessage, message: nil, preferredStyle: UIAlertController.Style.alert)
                                myAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                self.present(myAlert, animated: true, completion: nil)
                                return
                            }
                            
                            
                            let status = jsonData["status"].string ?? ""
                            if status == "success"{
                                self.IsSuccess = true
                                print("---==============")
                                if let user = authResult?.user {
                                    print("---==============")
                                    self.UserId = user.uid
                                    print(user.uid)
                                    
                                
                                        print("---==============9999999900000")
                                        let UserId = self.UserId
                                            print("fire id is \(UserId)")
                                            print(UserId)
                                        
                                            OfficeAip.GetAllOffice{ office in
                                                for GetOffice in office{
                                                    self.count += 1
                                                    if GetOffice.fire_id == UserId{
                                                        if GetOffice.archived != "1"{
                                                            UserDefaults.standard.set(GetOffice.type_id, forKey: "UserType")
                                                            UserDefaults.standard.set(true, forKey: "Login")
                                                            UserDefaults.standard.set(UserId, forKey: "UserId")
                                                            UserDefaults.standard.set(GetOffice.id, forKey: "OfficeId")
                                                            self.Verify.hideLoader()
                                                            if self.IsFromAnotherVc == false{
                                                                self.navigationController?.popToViewController(ofClass: Settings.self, animated: true)
                                                            }else{
                                                                self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                                                            }
                                                        }else{
                                                            self.Verify.hideLoader()
                                                            var mss = ""
                                                            var action = ""
                                                            if XLanguage.get() == .Kurdish{
                                                                mss = "پێشتر ئەو ئەکاونتەی پەیوەندی بەم ژمارەیەوە هەیە سڕاوەتەوە."
                                                                action = "باشە"
                                                            }else if XLanguage.get() == .Arabic{
                                                                mss = "تم حذف الحساب المرتبط بهذا الرقم من قبل."
                                                                action = "حسنا"
                                                            } else if XLanguage.get() == .English {
                                                                mss = "The account associated with this number has been deleted before."
                                                                action = "Ok"
                                                            } else if XLanguage.get() == .French {
                                                                mss = "Le compte associé à ce numéro a été supprimé."
                                                                action = "D'accord"
                                                            } else if XLanguage.get() == .Spanish {
                                                                mss = "La cuenta asociada con este número ha sido eliminada anteriormente."
                                                                action = "Ok"
                                                            } else if XLanguage.get() == .German {
                                                                mss = "Das mit dieser Nummer verknüpfte Konto wurde bereits gelöscht."
                                                                action = "Ok"
                                                            } else if XLanguage.get() == .Dutch {
                                                                mss = "De account die bij dit nummer hoort, is eerder verwijderd."
                                                                action = "Ok"
                                                            } else if XLanguage.get() == .Portuguese {
                                                                mss = "A conta associada a este número foi deletada anteriormente."
                                                                action = "Ok"
                                                            } else if XLanguage.get() == .Russian {
                                                                mss = "Аккаунт, связанный с этим номером, был удален ранее."
                                                                action = "Ок"
                                                            } else if XLanguage.get() == .Chinese {
                                                                mss = "与此号码关联的账户之前已被删除。"
                                                                action = "确定"
                                                            } else if XLanguage.get() == .Hindi {
                                                                mss = "इस नंबर के साथ जुड़ा खाता पहले हटा दिया गया था"
                                                                action = "ठीक है"
                                                            } else if XLanguage.get() == .Swedish {
                                                                mss = "Kontot kopplat till detta nummer har tidigare tagits bort."
                                                                action = "Ok"
                                                            } else if XLanguage.get() == .Greek {
                                                                mss = "Ο λογαριασμός που σχετίζεται με αυτόν τον αριθμό έχει διαγραφεί προηγουμένως."
                                                                action = "Εντάξει"
                                                            }else if XLanguage.get() == .Hebrew {
                                                                mss = "צור קשר איתנו להפעלה מחדש של החשבון."
                                                                action = "אישור"
                                                            }
                                                            
                                                            let myAlertin = UIAlertController(title: "", message: mss, preferredStyle: UIAlertController.Style.alert)
                                                            myAlertin.addAction(UIAlertAction(title: action, style: .default, handler: { (UIAlertActiokn) in
                                                                UserDefaults.standard.set("", forKey: "UserType")
                                                                UserDefaults.standard.set(false, forKey: "Login")
                                                                UserDefaults.standard.set("", forKey: "UserId")
                                                                UserDefaults.standard.set("", forKey: "OfficeId")
                                                                if self.IsFromAnotherVc == false{
                                                                    self.popBack(3)
                                                                }else{
                                                                    self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                                                                }
                                                            }))
                                                            self.present(myAlertin, animated: true, completion: nil)
                                                            
                                                        }
                                                        return
                                                    }
                                                }
                                                
                                                if self.count == office.count{
                                                    self.Verify.hideLoader()
                                                    let office = OfficesObject.init(name: "", id:UUID().uuidString , fire_id: UserId, address: "",about: "", phone1: UserDefaults.standard.string(forKey: "PhoneNumber") ?? "", phone2: "", ImageURL:"", type_id: self.type_id, archived: "0", subscription_id: "",contract_image: "" ,arabic_name: "", one_signal_uuid: "")
                                                    UserDefaults.standard.set(office.id, forKey: "OfficeId")
                                                    office.Upload()
                                                    UserDefaults.standard.set(self.type_id, forKey: "UserType")
                                                    UserDefaults.standard.set(true, forKey: "Login")
                                                    UserDefaults.standard.set(UserId, forKey: "UserId")
                                                    if self.IsFromAnotherVc == false{
                                                        self.popBack(3)
                                                    }else{
                                                        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                                                    }
                                                }
                                            }
                                            
                                        
                                    }
                                
                            }else{print("---==============3333")
                                self.Verify.hideLoader()
                                let myAlert = UIAlertController(title: "Error", message: "Invalid OTP", preferredStyle: UIAlertController.Style.alert)
                                myAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
                                self.present(myAlert, animated: true, completion: nil)
                            }
                            
                        }
                    
                    
                    
                    
                    
                case .failure(let error):
                    print(error);
                }
            }
            
            
        }
    }
    
}


