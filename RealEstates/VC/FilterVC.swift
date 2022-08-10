//
//  FilterVC.swift
//  RealEstates
//
//  Created by botan pro on 4/18/21.
//

import UIKit
import MBRadioCheckboxButton
import Slider2

protocol FilterDataDelegate {
    func AllData(dis_type:Int , price_min : Int , price_max:Int , rooms : Int , space_max : Int, space_min : Int, CityId : Int , estatetype_id : Int)
}



class FilterVC: UIViewController ,UITextFieldDelegate, RadioButtonDelegate{
    

    var RentOrSell = "1"
    func radioButtonDidSelect(_ button: RadioButton) {
        print("select  : \(button.tag)")
        if button.tag == 1{
            self.RentOrSell = "1"
        }else{
            self.RentOrSell = "0"
        }
    }
    
    func radioButtonDidDeselect(_ button: RadioButton) {
        print("Dselect  : \(button.tag)")
    }
    
    
    var selecteEstatedcell : EstateTypeObject?
    var selecteNumbercell = 0
    var NumberOfRoom = 0
    var EstateTypy = "Apartment"
    var EstatesType : [EstateTypeObject] = []
    var NumberOfRooms = [1,2,3,4,5,6,7,8,9,10]
    @IBOutlet weak var EstateTypeCollectionView: UICollectionView!
    @IBOutlet weak var NumberOfRoomsCollectionView: UICollectionView!
    

    var IsFirstRoom = false
    var IsFirstType = false
    
    
    var Delegate : FilterDataDelegate!
    

    
    @IBOutlet weak var PriceMin: LanguagePlaceHolder!
    @IBOutlet weak var PriceMax: LanguagePlaceHolder!

    
    
    
    @IBOutlet weak var Apply: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.PriceMin.delegate = self
        self.PriceMax.delegate = self

        if XLanguage.get() == .English{
            self.RentRadioButton.setTitle("RENT", for: .normal)
            self.SellRadioButton.setTitle("SELL", for: .normal)
            self.RentRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.SellRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        }else if XLanguage.get() == .Arabic{
            self.RentRadioButton.setTitle("بیع", for: .normal)
            self.SellRadioButton.setTitle("ايجار", for: .normal)
            self.RentRadioButton.titleLabel?.font = UIFont(name: "PeshangDes2", size: 14)!
            self.SellRadioButton.titleLabel?.font = UIFont(name: "PeshangDes2", size: 14)!
        }else if XLanguage.get() == .Kurdish{
            self.RentRadioButton.setTitle("کرێ", for: .normal)
            self.SellRadioButton.setTitle("فروشتن", for: .normal)
            self.RentRadioButton.titleLabel?.font = UIFont(name: "PeshangDes2", size: 14)!
            self.SellRadioButton.titleLabel?.font = UIFont(name: "PeshangDes2", size: 14)!
        }
        setupGroup2()
        
        NumberOfRoomsCollectionView.register(UINib(nibName: "EstateTypeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NCell")
        EstateTypeCollectionView.register(UINib(nibName: "EstateTypeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EstateCell")
        GetEstateType()
        GetAllEstates()
    }
    
    var AllEstateArray : [EstateObject] = []
    func GetAllEstates(){
        ProductAip.GetAllProducts { Product in
            for UnArchived in Product{
                if UnArchived.archived != "1"{
                    self.AllEstateArray.append(UnArchived)
                }
            }
        }
    }
    
    
    
    func GetEstateType(){
        self.EstatesType.removeAll()
        EstateTypeAip.GetEstateType { types in
            self.EstatesType = types
            self.EstateTypeCollectionView.reloadData()
        }
    }
    
    
    var group3Container = RadioButtonContainer()
    @IBOutlet weak var viewGroup: RadioButtonContainerView!
    
    @IBOutlet weak var RentRadioButton: RadioButton!
    @IBOutlet weak var SellRadioButton: RadioButton!
    
    
    
    func setupGroup2() {
        viewGroup.buttonContainer.delegate = self
        viewGroup.buttonContainer.setEachRadioButtonColor {
            return RadioButtonColor(active: $0.tintColor , inactive: $0.tintColor)
        }
        group3Container.addButtons([RentRadioButton, SellRadioButton])
        group3Container.delegate = self
        group3Container.selectedButton = RentRadioButton
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.showSpinningWheel(_:)), name: NSNotification.Name(rawValue: "CuntryName"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notificationRecevied1(_:)), name: NSNotification.Name(rawValue: "CityName"), object: nil)
    }
    
    
    
    
    
    
    
    @IBOutlet weak var MinSpaceLable: UILabel!
    @IBOutlet weak var MaxSpaceLable: UILabel!
    
    
    
    
    @IBAction func SpaveSLider(_ sender: Slider2) {
        MinSpaceLable.text = "\(sender.value)"
        MaxSpaceLable.text = "\(sender.value2)"
    }
    
    
    
    
    @IBOutlet weak var AddressLable: LanguageLable!
    
    var cuntry = ""
    var city = ""
    var CityId = 0
    
    @objc func showSpinningWheel(_ notification: NSNotification) {
        if let data = notification.userInfo as NSDictionary? {print("22222")
            if let Cuntry = data["Cuntry"] as? String{
                self.cuntry = Cuntry
            }
        }
       
    }
      
    @objc func notificationRecevied1(_ notification: NSNotification) {
        if let data = notification.userInfo as NSDictionary? {print("33333")
            if let City = data["City"] as? String{
                self.city = City
            }
            if let CityId = data["CityId"] as? String{
                self.CityId = (CityId as NSString).integerValue
            }
            self.AddressLable.text = self.city
        }
    }

    

    
    @IBAction func FullAddress(_ sender: Any) {
        //self.performSegue(withIdentifier: "GoToCuntrys", sender: nil)
    }

    
    

    var PriceMAX = 0.0
    var PriceMIN = 0.0
    
    var RoomsMAX = 0.0
    var RoomsMIN = 0.0
    
    var M2MAX = 0.0
    var M2MIN = 0.0
    
    var filter1 : [EstateObject] = []
    @IBAction func Apply(_ sender: Any) {
        
        let Price_Min = Double(self.PriceMin.text!) ?? 0.0
        let Price_Max = Double(self.PriceMax.text!) ?? 0.0
        
        
        if Price_Min == 0.0 && Price_Max == 0.0{
            filter1 = self.AllEstateArray
        }else{
            if Price_Min > Price_Max{
                self.PriceMIN = Price_Max
                self.PriceMAX = Price_Min
            }else{
                self.PriceMIN = Price_Min
                self.PriceMAX = Price_Max
            }
            filter1 = self.AllEstateArray.filter{ $0.price ?? 0 <= self.PriceMAX && $0.price ?? 0 >= self.PriceMIN}
        }
        
        let filter2 = filter1.filter{ $0.space ?? "" <= self.MaxSpaceLable.text! && $0.space ?? "" <= self.MinSpaceLable.text!}
        
        let filter3 = filter2.filter{ $0.RoomNo == "\(self.NumberOfRoom)"}
        
        let filter4 = filter3.filter{ $0.estate_type_id == self.EstateTypy }
        
        let filter5 = filter4.filter{ $0.RentOrSell == self.RentOrSell}
        
        let filter6 = filter5.filter{ $0.address == self.AddressLable.text!}
        

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myVC = storyboard.instantiateViewController(withIdentifier: "AllEstateVC") as! AllEstateVC
        myVC.title = "Result"
        myVC.AllEstate = filter6
        self.navigationController?.pushViewController(myVC, animated: true)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let estate = sender as? EstateObject{
            if let next = segue.destination as? EstateProfileVc{
                next.CommingEstate = estate
            }
        }
    }
    
}





extension FilterVC : UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.EstateTypeCollectionView{
            if EstatesType.count == 0 {
                return 0
            }else{
                return EstatesType.count
            }
        }
        if collectionView == self.NumberOfRoomsCollectionView{
            if NumberOfRooms.count == 0 {
                return 0
            }else{
                return NumberOfRooms.count
            }
        }
        
        return 0
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.NumberOfRoomsCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NCell", for: indexPath) as! EstateTypeCollectionViewCell
            if self.NumberOfRooms.count != 0{
                
                if self.IsFirstRoom == false && indexPath.row == 1{
                    self.selecteNumbercell = 2
                    self.NumberOfRoom = 2
                    self.IsFirstRoom = true
                }
                
                if self.selecteNumbercell == NumberOfRooms[indexPath.row]{
                    UIView.animate(withDuration: 0.3) {
                        cell.Vieww.backgroundColor = #colorLiteral(red: 0, green: 0.6025940776, blue: 0.9986988902, alpha: 1)
                        cell.Name.textColor = .white
                    }
                }else{
                    cell.Vieww.backgroundColor = .white
                    cell.Name.textColor = #colorLiteral(red: 0.4430069923, green: 0.4869378209, blue: 0.5339931846, alpha: 1)
                }
                cell.Name.text = "\(NumberOfRooms[indexPath.row])"
            }
            
            return cell
        }
        
        
        if collectionView == self.EstateTypeCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EstateCell", for: indexPath) as! EstateTypeCollectionViewCell
            if self.EstatesType.count != 0{
                
                if self.IsFirstType == false && indexPath.row == 2{
                    self.EstateTypy = self.EstatesType[indexPath.row].name ?? ""
                    self.selecteEstatedcell = self.EstatesType[indexPath.row]
                    self.IsFirstType = true
                }
                
                if self.selecteEstatedcell?.id == EstatesType[indexPath.row].id{
                    UIView.animate(withDuration: 0.3) {
                        cell.Vieww.backgroundColor = #colorLiteral(red: 0, green: 0.6025940776, blue: 0.9986988902, alpha: 1)
                        cell.Name.textColor = .white
                    }
                }else{
                    cell.Vieww.backgroundColor = .white
                    cell.Name.textColor = #colorLiteral(red: 0.4430069923, green: 0.4869378209, blue: 0.5339931846, alpha: 1)
                }
                cell.Name.text = EstatesType[indexPath.row].name
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.NumberOfRoomsCollectionView{
            return CGSize(width: collectionView.frame.size.width / 7, height: 45)
        }
        return CGSize(width: collectionView.frame.size.width / 4, height: 45)
     }

    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 5
     }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.EstateTypeCollectionView{
            if self.EstatesType.count != 0  && indexPath.row <= self.EstatesType.count{
                self.EstateTypy = EstatesType[indexPath.row].id ?? ""
                self.selecteEstatedcell = self.EstatesType[indexPath.row]
                self.EstateTypeCollectionView.reloadData()
            }
        }
        
        if collectionView == self.NumberOfRoomsCollectionView{
            if self.NumberOfRooms.count != 0  && indexPath.row <= self.NumberOfRooms.count{
                self.NumberOfRoom = NumberOfRooms[indexPath.row + 1]
                self.selecteNumbercell = self.NumberOfRooms[indexPath.row]
                self.NumberOfRoomsCollectionView.reloadData()
            }
        }
    }
    
}


