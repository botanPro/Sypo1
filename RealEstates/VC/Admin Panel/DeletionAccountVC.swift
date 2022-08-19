//
//  DeletionAccountVC.swift
//  RealEstates
//
//  Created by Botan Amedi on 15/08/2022.
//

import UIKit
import Firebase
import FirebaseAuth
class DeletionAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        GetMyEstates()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    var ProductArray : [EstateObject] = []
    func GetMyEstates(){
        if let FireId = UserDefaults.standard.string(forKey: "UserId"){
            OfficeAip.GetOfficeById(Id: FireId) { office in
                ProductAip.GetMyEstates(office_id: office.id ?? "") { estates in
                    if estates.archived != "1"{
                        self.ProductArray.append(estates)
                    }
                }
            }
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
    
    
    
    var count = 0
    @IBAction func DeleteAccount(_ sender: Any) {
        var title  = ""
        var mess   = ""
        var note    = ""
        var note_mess = ""
        var sure   = ""
        var delete = ""
        var cancel = ""
        var no     = ""
        
        if XLanguage.get() == .Kurdish{
            title  = "سڕینەوەی ئەکاونت"
            mess   = "ئایا دڵنیای کە دەتەوێت ئەکاونتەکەت بسڕیتەوە"
            sure   = "دڵنیام"
            note    = "تێبینی"
            note_mess = "دوای سڕینەوەی ئەکاونتەکەت، موڵکەکانت، و زانیارییەکان لە ئەپلیکەیشنەکەدا نیشان نادرێن، پەیوەندیمان پێوە بکە ئەگەر دەتەوێت ئەکاونتەکەت کاردانەوەی هەبێت."
            delete = "سڕینەوە"
            cancel = "هەڵوەشاندنەوە"
            no     = "نەخێر"
        }else if XLanguage.get() == .English{
            title  = "Delete Account"
            mess   = "Are you sure you want to delete your account?"
            sure   = "Sure"
            note    = "Note"
            note_mess = "After deleting your account, your estates, and information will not be shown in the application, Contact us if you want to reactive your account."
            delete = "Delete"
            cancel = "Cancel"
            no     = "No"
        }else{
            title  = "حذف الحساب"
            mess   = "هل انت متأكد انك تريد حذف حسابك؟"
            sure   = "بالتأكيد"
            note    = "ملاحظة"
            note_mess = "بعد حذف حسابك ، لن يتم عرض عقاراتك ومعلوماتك في التطبيق، اتصل بنا إذا كنت تريد إعادة تنشيط حسابك."
            delete = "حذف"
            cancel = "إلغاء"
            no     = "لا"
        }
        let myAlert = UIAlertController(title: title, message: mess, preferredStyle: UIAlertController.Style.alert)
        myAlert.addAction(UIAlertAction(title: sure, style: .default, handler: { (UIAlertActionn) in
            
            let myAlertin = UIAlertController(title: note, message: note_mess, preferredStyle: UIAlertController.Style.alert)
            myAlertin.addAction(UIAlertAction(title: delete, style: .default, handler: { (UIAlertActiokn) in
                if let officeId = UserDefaults.standard.string(forKey: "OfficeId"){
                    OfficeAip.Remov(id: officeId) { deleted in
                        print("-1-1-1-1-1-1-1-1-1-1-1-")
                        if self.ProductArray.count != 0{
                            for estate in self.ProductArray{
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
    }
    
    
    
}
