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
    @IBOutlet weak var Vieww: UIView!
    @IBOutlet weak var Cancel: UIButton!
    var LanguagesArray : [LanguagesObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Vieww.layer.cornerRadius = 20
        self.Cancel.layer.cornerRadius = 20
        self.TableView.layer.cornerRadius = 20
        TableView.register(UINib(nibName: "SettingsTableViewTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        style()
        
        languageChanged()
    }
    
    
    
    func languageChanged(){
        if XLanguage.get() == .Arabic {
            self.LanguagesArray.append(LanguagesObject(image: UIImage(named: "EN")!, name: "الانجليزية"))
            self.LanguagesArray.append(LanguagesObject(image: UIImage(named: "KU")!, name: "الكردية"))
            self.LanguagesArray.append(LanguagesObject(image: UIImage(named: "AR")!, name: "العربية"))
        }
        if  XLanguage.get() == .Kurdish{
            self.LanguagesArray.append(LanguagesObject(image: UIImage(named: "EN")!, name: "ئنگلیزی"))
            self.LanguagesArray.append(LanguagesObject(image: UIImage(named: "KU")!, name: "کوردی"))
            self.LanguagesArray.append(LanguagesObject(image: UIImage(named: "AR")!, name: "عەرەبی"))
        }
        if XLanguage.get() == .English{
            self.LanguagesArray.append(LanguagesObject(image: UIImage(named: "EN")!, name: "English"))
            self.LanguagesArray.append(LanguagesObject(image: UIImage(named: "KU")!, name: "Kurdish"))
            self.LanguagesArray.append(LanguagesObject(image: UIImage(named: "AR")!, name: "Arabic"))
        }
        
    }
    func style(){
        self.Vieww.layer.shadowColor = UIColor.darkGray.cgColor
        self.Vieww.layer.shadowOffset = .zero
        self.Vieww.layer.shadowRadius = 6.0
        self.Vieww.layer.shadowOpacity = 0.2
        self.Vieww.layer.masksToBounds = false
        self.Cancel.layer.shadowColor = UIColor.darkGray.cgColor
        self.Cancel.layer.shadowOffset = .zero
        self.Cancel.layer.shadowRadius = 6.0
        self.Cancel.layer.shadowOpacity = 0.2
        self.Cancel.layer.masksToBounds = false
    }
    @IBAction func Cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
        let cell  = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SettingsTableViewTableViewCell
        cell.Name.text = LanguagesArray[indexPath.row].name
        cell.Imagee.image = LanguagesArray[indexPath.row].image
        return cell
    }

   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            XLanguage.set(Language: .English)
            UserDefaults.standard.setValue(1, forKey: "language")
            let Data:[String: Int] = ["Lang": 1]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "languageChanged"), object: nil , userInfo: Data)
            dismiss(animated: true, completion: nil)
        }
        if indexPath.row == 1{
            XLanguage.set(Language: .Kurdish)
            UserDefaults.standard.setValue(3, forKey: "language")
            let Data:[String: Int] = ["Lang": 3]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "languageChanged"), object: nil , userInfo: Data)
            dismiss(animated: true, completion: nil)
        }
        if indexPath.row == 2{
            XLanguage.set(Language: .Arabic)
            UserDefaults.standard.setValue(2, forKey: "language")
            let Data:[String: Int] = ["Lang": 2]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "languageChanged"), object: nil , userInfo: Data)
            dismiss(animated: true, completion: nil)
        }
    }
}




class LanguagesObject{
    var image : UIImage!
    var name = ""
    
    init(image : UIImage , name: String) {
        self.image = image
        self.name = name
    }
}

