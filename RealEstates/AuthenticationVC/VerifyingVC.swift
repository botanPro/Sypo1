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
class VerifyingVC: UIViewController {

    @IBOutlet weak var Verify: LoadingButton!
    @IBOutlet weak var OTPCode: OTPTextField!
    @IBOutlet weak var Dismiss: UIButton!
    
    
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
        
        if XLanguage.get() == .Kurdish{
            let phone = UserDefaults.standard.string(forKey: "PhoneNumber") ?? ""

            self.phonenumber.text = " کورتەنامەیەک نێردراوە بۆ"
            self.VerifingLable.text = phone
            self.VerifingLable.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.VerifingLable.font = UIFont(name: "PeshangDes2", size: 12)!
            self.phonenumber.font = UIFont(name: "PeshangDes2", size: 12)!
        }else if XLanguage.get() == .English{
            self.VerifingLable.text = "An SMS was sent to "
            self.phonenumber.text = UserDefaults.standard.string(forKey: "PhoneNumber") ?? ""
            self.VerifingLable.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.phonenumber.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.phonenumber.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }else{
            let phone = UserDefaults.standard.string(forKey: "PhoneNumber") ?? ""
            self.phonenumber.text = " تم إرسال SMS إلى"
            self.VerifingLable.text = phone
            self.VerifingLable.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.VerifingLable.font = UIFont(name: "PeshangDes2", size: 12)!
            self.phonenumber.font = UIFont(name: "PeshangDes2", size: 12)!
        }
        
        
        Verify.indicator = MaterialLoadingIndicator(color: .gray)
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else {
            let myMessage = "no virification code"
            let myAlert = UIAlertController(title: myMessage, message: nil, preferredStyle: UIAlertController.Style.alert)
            myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(myAlert, animated: true, completion: nil)
            return
        }
        self.ver = verificationID
        
        if XLanguage.get() == .Kurdish{
            self.Verify.setTitle("پشتڕاستکردنەوە" , for: .normal)
            self.Verify.titleLabel?.font = UIFont(name: "PeshangDes2", size: 11)!
        }else if XLanguage.get() == .English{
            self.Verify.setTitle("Verify" , for: .normal)
            self.Verify.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
        }else{
            self.Verify.setTitle("تحقق" , for: .normal)
            self.Verify.titleLabel?.font = UIFont(name: "PeshangDes2", size: 11)!
        }
    }
    var ver : String = ""
    var credential : PhoneAuthCredential!
    
    
    
    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }
    
    
var count = 0
    var UserTypeFound = false
    @IBAction func Verify(_ sender: Any) {
        if self.OTPCode.text! != ""{
            Verify.showLoader(userInteraction: true)
            credential = PhoneAuthProvider.provider().credential(
                withVerificationID: self.ver ,
                verificationCode: self.OTPCode.text!.convertedDigitsToLocale(Locale(identifier: "EN")))
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    UserDefaults.standard.set(false, forKey: "Login")
                    UserDefaults.standard.set("", forKey: "PhoneNumber")
                    self.Verify.hideLoader()
                    let myMessage = error.localizedDescription
                    let myAlert = UIAlertController(title: myMessage, message: nil, preferredStyle: UIAlertController.Style.alert)
                    myAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(myAlert, animated: true, completion: nil)
                    return
                }
                
                self.Verify.hideLoader()
                
                if ((authResult?.user) != nil){
                    guard let UserId = authResult?.user.uid else { return }
                    print("fire id is \(UserId)")
                    OfficeAip.GetAllOffice{ office in
                        
                        for GetOffice in office{
                            self.count += 1
                            if GetOffice.fire_id == UserId{
                                if GetOffice.archived != "1"{
                                    UserDefaults.standard.set(GetOffice.type_id, forKey: "UserType")
                                    UserDefaults.standard.set(true, forKey: "Login")
                                    UserDefaults.standard.set(UserId, forKey: "UserId")
                                    UserDefaults.standard.set(GetOffice.id, forKey: "OfficeId")
                                    if self.IsFromAnotherVc == false{
                                        self.navigationController?.popToViewController(ofClass: Settings.self, animated: true)
                                    }else{
                                        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                                    }
                                }else{
                                    var mss = ""
                                    var action = ""
                                    if XLanguage.get() == .English{
                                        mss = "The account associated with this number has been deleted before, contact us to reactive your account."
                                        action = "Ok"
                                    }else if XLanguage.get() == .Kurdish{
                                        mss = "پێشتر ئەو ئەکاونتەی پەیوەندی بەم ژمارەیەوە هەیە سڕاوەتەوە، پەیوەندیمان پێوە بکە بۆ کاردانەوەی ئەکاونتەکەت."
                                        action = "باشە"
                                    }else{
                                        mss = "تم حذف الحساب المرتبط بهذا الرقم من قبل ، اتصل بنا لإعادة تنشيط حسابك."
                                        action = "حسنا"
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
                            let office = OfficesObject.init(name: "", id:UUID().uuidString , fire_id: UserId, address: "",about: "", phone1: UserDefaults.standard.string(forKey: "PhoneNumber") ?? "", phone2: "", ImageURL:"", type_id: "1kMcAwX8d1WMUhBanY4F", archived: "0")
                            UserDefaults.standard.set(office.id, forKey: "OfficeId")
                            office.Upload()
                            UserDefaults.standard.set("1kMcAwX8d1WMUhBanY4F", forKey: "UserType")
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
            }
        }
    }
    
}


