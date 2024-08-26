//
//  LanguagesVCViewController.swift
//  RealEstates
//
//  Created by botan pro on 4/17/21.
//

import UIKit
///ava mn bkar na inaya
class LanguagesVCViewController: UIViewController {

    @IBOutlet weak var TableView: UITableView!{didSet{self.TableView.delegate = self; self.TableView.dataSource = self}}

    var LanguagesArray : [LanguagesObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.register(UINib(nibName: "CuntryAndCityTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        languageChanged()
    }

    func languageChanged(){
        self.LanguagesArray.append(LanguagesObject(name: "English"))
        self.LanguagesArray.append(LanguagesObject(name: "Kurdish"))
        self.LanguagesArray.append(LanguagesObject(name: "Arabic"))
        
        self.LanguagesArray.append(LanguagesObject(name: "Hebrew"))
        self.LanguagesArray.append(LanguagesObject(name: "Chinese"))
        
        self.LanguagesArray.append(LanguagesObject(name: "Hindi"))
        self.LanguagesArray.append(LanguagesObject(name: "Portuguese"))
        self.LanguagesArray.append(LanguagesObject(name: "Swedish"))
        
        self.LanguagesArray.append(LanguagesObject(name: "Greek"))
        self.LanguagesArray.append(LanguagesObject(name: "Russian"))
        self.LanguagesArray.append(LanguagesObject(name: "Dutch"))
        
        self.LanguagesArray.append(LanguagesObject(name: "French"))
        self.LanguagesArray.append(LanguagesObject(name: "Spanish"))
        self.LanguagesArray.append(LanguagesObject(name: "German"))
        
        self.TableView.reloadData()
    }
    
}

extension LanguagesVCViewController : UITableViewDelegate , UITableViewDataSource{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if LanguagesArray.count == 0{
            return 0
        }
        return LanguagesArray.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CuntryAndCityTableViewCell
        cell.Name.text = LanguagesArray[indexPath.row].name
        cell.Name.font =  UIFont(name: "ArialRoundedMTBold", size: 13)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            XLanguage.set(Language: .English)
            UserDefaults.standard.setValue(1, forKey: "language")
            let Data:[String: String] = ["Lang": "English"]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "languageChanged"), object: nil , userInfo: Data)
            dismiss(animated: true, completion: nil)
        }
        if indexPath.row == 1{
            XLanguage.set(Language: .Kurdish)
            UserDefaults.standard.setValue(2, forKey: "language")
            let Data:[String: String] = ["Lang": "Kurdish"]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "languageChanged"), object: nil , userInfo: Data)
            dismiss(animated: true, completion: nil)
        }
        if indexPath.row == 2{
            XLanguage.set(Language: .Arabic)
            UserDefaults.standard.setValue(3, forKey: "language")
            let Data:[String: String] = ["Lang": "Arabic"]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "languageChanged"), object: nil , userInfo: Data)
            dismiss(animated: true, completion: nil)
        }


        if indexPath.row == 3{
            XLanguage.set(Language: .Hebrew)
            UserDefaults.standard.setValue(4, forKey: "language")
            let Data:[String: String] = ["Lang": "Hebrew"]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "languageChanged"), object: nil , userInfo: Data)
            dismiss(animated: true, completion: nil)
        }
        if indexPath.row == 4{
            XLanguage.set(Language: .Chinese)
            UserDefaults.standard.setValue(5, forKey: "language")
            let Data:[String: String] = ["Lang": "Chinese"]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "languageChanged"), object: nil , userInfo: Data)
            dismiss(animated: true, completion: nil)
        }
        
        if indexPath.row == 5{
            XLanguage.set(Language: .Hindi)
            UserDefaults.standard.setValue(6, forKey: "language")
            let Data:[String: String] = ["Lang": "Hindi"]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "languageChanged"), object: nil , userInfo: Data)
            dismiss(animated: true, completion: nil)
        }
        if indexPath.row == 6{
            XLanguage.set(Language: .Portuguese)
            UserDefaults.standard.setValue(7, forKey: "language")
            let Data:[String: String] = ["Lang": "Portuguese"]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "languageChanged"), object: nil , userInfo: Data)
            dismiss(animated: true, completion: nil)
        }
        if indexPath.row == 7{
            XLanguage.set(Language: .Swedish)
            UserDefaults.standard.setValue(8, forKey: "language")
            let Data:[String: String] = ["Lang": "Swedish"]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "languageChanged"), object: nil , userInfo: Data)
            dismiss(animated: true, completion: nil)
        }
        
        if indexPath.row == 8{
            XLanguage.set(Language: .Greek)
            UserDefaults.standard.setValue(9, forKey: "language")
            let Data:[String: String] = ["Lang": "Greek"]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "languageChanged"), object: nil , userInfo: Data)
            dismiss(animated: true, completion: nil)
        }
        if indexPath.row == 9{
            XLanguage.set(Language: .Russian)
            UserDefaults.standard.setValue(10, forKey: "language")
            let Data:[String: String] = ["Lang": "Russian"]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "languageChanged"), object: nil , userInfo: Data)
            dismiss(animated: true, completion: nil)
        }
        if indexPath.row == 10{
            XLanguage.set(Language: .Dutch)
            UserDefaults.standard.setValue(11, forKey: "language")
            let Data:[String: String] = ["Lang": "Dutch"]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "languageChanged"), object: nil , userInfo: Data)
            dismiss(animated: true, completion: nil)
        }
        
        if indexPath.row == 11{
            XLanguage.set(Language: .French)
            UserDefaults.standard.setValue(12, forKey: "language")
            let Data:[String: String] = ["Lang": "French"]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "languageChanged"), object: nil , userInfo: Data)
            dismiss(animated: true, completion: nil)
        }
        if indexPath.row == 12{
            XLanguage.set(Language: .Spanish)
            UserDefaults.standard.setValue(13, forKey: "language")
            let Data:[String: String] = ["Lang": "Spanish"]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "languageChanged"), object: nil , userInfo: Data)
            dismiss(animated: true, completion: nil)
        }
        if indexPath.row == 13{
            XLanguage.set(Language: .German)
            UserDefaults.standard.setValue(14, forKey: "language")
            let Data:[String: String] = ["Lang": "German"]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "languageChanged"), object: nil , userInfo: Data)
            dismiss(animated: true, completion: nil)
        }
    }
}




class LanguagesObject{
    var name = ""
    
    init( name: String) {
        self.name = name
    }
}

