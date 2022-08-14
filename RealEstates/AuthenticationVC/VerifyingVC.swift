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
    
    
    @IBAction func Dismis(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.OTPCode.delegate = self
        self.OTPCode.becomeFirstResponder()
        self.Verify.layer.cornerRadius = 8
        Verify.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        Verify.layer.shadowOpacity = 1
        Verify.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        Verify.layer.shadowRadius = 2
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
            self.Verify.titleLabel?.font = UIFont(name: "PeshangDes2", size: 16)!
        }else if XLanguage.get() == .English{
            self.Verify.setTitle("Verify" , for: .normal)
            self.Verify.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 15)!
        }else{
            self.Verify.setTitle("تحقق" , for: .normal)
            self.Verify.titleLabel?.font = UIFont(name: "PeshangDes2", size: 16)!
        }
    }
    var ver : String = ""
    var credential : PhoneAuthCredential!
    
var count = 0
    var UserTypeFound = false
    @IBAction func Verify(_ sender: Any) {
        if self.OTPCode.text! != ""{
            Verify.showLoader(userInteraction: true)
            credential = PhoneAuthProvider.provider().credential(
                withVerificationID: self.ver ,
                verificationCode: self.OTPCode.text!)
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
                            if GetOffice.fire_id == UserId{print("22222222")
                                UserDefaults.standard.set(GetOffice.type_id, forKey: "UserType")
                                UserDefaults.standard.set(true, forKey: "Login")
                                UserDefaults.standard.set(UserId, forKey: "UserId")
                                UserDefaults.standard.set(GetOffice.id, forKey: "OfficeId")
                                self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                                return
                            }
                        }
                        
                        if self.count == office.count{print("111111111")
                            let office = OfficesObject.init(name: "", id:UUID().uuidString , fire_id: UserId, address: "",about: "", phone1: UserDefaults.standard.string(forKey: "PhoneNumber") ?? "", phone2: "", ImageURL:"", type_id: "1kMcAwX8d1WMUhBanY4F")
                            UserDefaults.standard.set(office.id, forKey: "OfficeId")
                            office.Upload()
                            UserDefaults.standard.set("1kMcAwX8d1WMUhBanY4F", forKey: "UserType")
                            UserDefaults.standard.set(true, forKey: "Login")
                            UserDefaults.standard.set(UserId, forKey: "UserId")
                            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                        }
                    }
                    
                }
            }
        }
    }
    
}


extension VerifyingVC: UITextFieldDelegate{
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        print("fdl,lvk,dflv,ldkf,vlkd,")
//        do {
//            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z0-9 ].*", options: [])
//            if regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil {
//                return false
//            }
//        }
//        catch {
//            print("ERROR")
//        }
//        return true
//    }
}

