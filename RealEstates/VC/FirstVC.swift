//
//  FirstVC.swift
//  RealEstates
//
//  Created by botan pro on 4/16/21.
//

import UIKit

class FirstVC: UIViewController ,UIPickerViewDelegate , UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CityArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = self.CityArray[row].name

        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserDefaults.standard.set(self.CityArray[row].name, forKey: "CityName")
    }
    
    
    

    @IBOutlet weak var Next: UIButton!
    
    private var alertController = UIAlertController()
    private var tblView = UITableView()
    var pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 150))
    var CityArray : [CityObject] = []
    
    private func setupCitySelectionAlert() {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 150)
        pickerView.delegate = self
        pickerView.dataSource = self
        vc.view.addSubview(pickerView)
        let editRadiusAlert = UIAlertController(title: "Cities", message: "", preferredStyle: UIAlertController.Style.alert)
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        self.alertController = UIAlertController(title: "Choose your city", message: nil, preferredStyle: .alert)
        alertController.setValue(editRadiusAlert, forKey: "contentViewController")
        let cancelAction = UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
            UserDefaults.standard.set("false", forKey: "IsFirst")
            self.performSegue(withIdentifier: "GoToApp", sender: nil)
        })
        
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func GetCity(){
        self.CityArray.removeAll()
        CityObjectAip.GetCities { city in
            self.CityArray = city
            self.pickerView.reloadAllComponents()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetCity()
        self.Next.backgroundColor = .clear
        self.Next.layer.borderWidth = 2
        self.Next.layer.borderColor = UIColor.white.cgColor
        self.Next.layer.cornerRadius = 19
    }
    
    
    
    @IBAction func Next(_ sender: Any) {
        setupCitySelectionAlert()
    }
    
    @IBAction func SharkTeam(_ sender: Any) {
        if let url = NSURL(string: "http://www.shark-team.com"){
            UIApplication.shared.open(url as URL)
        }
    }
}
