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
            if XLanguage.get() == .English{
                pickerLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            }else if XLanguage.get() == .Kurdish || XLanguage.get() == .Arabic{
                pickerLabel?.font = UIFont(name: "PeshangDes2", size: 12)!
            }
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = self.CityArray[row].name

        return pickerLabel!
    }
    



    @IBOutlet weak var Next: UIButton!
    
    var pickerView = UIPickerView(frame: CGRect(x: 10, y: 50, width: 250, height: 150))
    var CityArray : [CityObject] = []
    
    private func setupCitySelectionAlert() {
        GetCity()
        let ac = UIAlertController(title: "Cities", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        ac.view.addSubview(pickerView)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            let pickerValue = self.CityArray[self.pickerView.selectedRow(inComponent: 0)]
            
            CountryObjectAip.GeCountryById(id: pickerValue.country_id ?? "") { country in
                print("-=-=-=-=-=-=-=-")
                UserDefaults.standard.set("\(country.name ?? "")-\(pickerValue.name ?? "")".uppercased(), forKey: "CityName")
                UserDefaults.standard.set("false", forKey: "IsFirst")
                self.performSegue(withIdentifier: "GoToApp", sender: nil)
            }
            
            UserDefaults.standard.set(pickerValue.id, forKey: "CityId")
            UserDefaults.standard.set(pickerValue.country_id, forKey: "CountryId")
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(ac, animated: true)
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
        pickerView.delegate = self
        pickerView.dataSource = self
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
