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

    
    
    @IBOutlet weak var InternetViewHeight: NSLayoutConstraint!
    @IBOutlet weak var InternetConnectionView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        GetMyEstates()
        self.InternetViewHeight.constant = 0
        self.InternetConnectionView.isHidden = true
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
        

            title  = "Delete Account"
            mess   = "Are you sure you want to delete your account?"
            sure   = "Sure"
            note    = "Warning"
            note_mess = "After deleting your account, your estates and information will be Delete, this action cannot be undo."
            delete = "Delete"
            cancel = "Cancel"
            no     = "No"

        let myAlert = UIAlertController(title: title, message: mess, preferredStyle: UIAlertController.Style.alert)
        myAlert.addAction(UIAlertAction(title: sure, style: .default, handler: { (UIAlertActionn) in
            
            let myAlertin = UIAlertController(title: note, message: note_mess, preferredStyle: UIAlertController.Style.alert)
            myAlertin.addAction(UIAlertAction(title: delete, style: .default, handler: { (UIAlertActiokn) in
                if let officeId = UserDefaults.standard.string(forKey: "OfficeId"){
                    OfficeAip.Remov(id: officeId) { deleted in
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
        }else{
            UIView.animate(withDuration: 0.3) {
                self.InternetViewHeight.constant = 20
                self.InternetConnectionView.isHidden = false
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    
}
