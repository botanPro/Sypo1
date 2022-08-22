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
        }else if XLanguage.get() == .English{
            self.Login.setTitle("Next" , for: .normal)
            self.Login.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
        }else{
            self.Login.setTitle("استمرار" , for: .normal)
            self.Login.titleLabel?.font = UIFont(name: "PeshangDes2", size: 11)!
        }
        
        
        
    }
    
    var phone = ""
    @IBAction func Login(_ sender: Any) {
        self.Login.isEnabled = false
        print(self.PhoneNumber.text!)
        if self.PhoneNumber.text != ""{
            let str = self.PhoneNumber.text!
            if str.count > 5{
                let index = str.index(str.startIndex, offsetBy: 5)
                if str[index] == "0" && self.PhoneNumber.currentRegion == "IRQ"{
                    self.phone = self.PhoneNumber.text!
                    self.phone.remove(at: index)
                }else{
                    self.phone = self.PhoneNumber.text!
                }
            }
            
            print(self.phone)
            Login.showLoader(userInteraction: true)
            PhoneAuthProvider.provider().verifyPhoneNumber(self.phone.convertedDigitsToLocale(Locale(identifier: "EN")), uiDelegate: nil) { (verificationID, error) in
                if let error = error {
                    print(error)
                    self.Login.hideLoader()
                    self.Login.isEnabled = true
                    let myMessage = error.localizedDescription
                    let myAlert = UIAlertController(title: myMessage, message: nil, preferredStyle: UIAlertController.Style.alert)
                    myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(myAlert, animated: true, completion: nil)
                    return
                }
                UserDefaults.standard.set(self.PhoneNumber.text!, forKey: "PhoneNumber")
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let myVC = storyboard.instantiateViewController(withIdentifier: "VeryingVC") as! VerifyingVC
                self.Login.hideLoader()
                if self.IsFromAnotherVc == false{
                   self.navigationController?.pushViewController(myVC, animated: true)
                }else{
                    myVC.modalPresentationStyle = .fullScreen
                    myVC.IsFromAnotherVc = true
                    self.present(myVC, animated: true)
                }
            }
        }else{
            self.Login.hideLoader()
            if self.PhoneNumber.text == ""{
                var mss = ""
                var action = ""
                if XLanguage.get() == .English{
                    mss = "Please enter phone number"
                    action = "Ok"
                }else if XLanguage.get() == .Kurdish{
                    mss = "تکایە ژمارەی تەلەفۆن بنووسە"
                    action = "باشە"
                }else{
                    mss = "الرجاء إدخال رقم الهاتف"
                    action = "حسنا"
                }
                self.Login.isEnabled = true
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
            return "IRQ"
        }
        set {} // exists for backward compatibility
    }
}
//extension String {
//    subscript(idx: Int) -> String {
//        String(self[index(startIndex, offsetBy: idx)])
//    }
//}
