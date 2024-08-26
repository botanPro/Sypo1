//
//  FilterVC.swift
//  RealEstates
//
//  Created by botan pro on 4/18/21.
//

import UIKit
import MBRadioCheckboxButton
import Slider2
import Drops
import Photos
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
    var EstateTypy = "UTY25FYJHkliygt4nvPP"
    var EstatesType : [EstateTypeObject] = []
    var NumberOfRooms = [1,2,3,4,5,6,7,8,9,10]
    @IBOutlet weak var EstateTypeCollectionView: UICollectionView!
    @IBOutlet weak var NumberOfRoomsCollectionView: UICollectionView!
    

    var IsFirstRoom = false
    var IsFirstType = false
    
    
    var Delegate : FilterDataDelegate!
    

    @IBOutlet weak var ScrollViewLayout: NSLayoutConstraint!
    @IBOutlet weak var PriceMin: LanguagePlaceHolder!
    @IBOutlet weak var PriceMax: LanguagePlaceHolder!

    
    
    
    @IBOutlet weak var Apply: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.PriceMin.delegate = self
        self.PriceMax.delegate = self
        
       if XLanguage.get() == .Arabic{
            self.RentRadioButton.setTitle("بیع", for: .normal)
            self.SellRadioButton.setTitle("ايجار", for: .normal)
            self.RentRadioButton.titleLabel?.font = UIFont(name: "PeshangDes2", size: 14)!
            self.SellRadioButton.titleLabel?.font = UIFont(name: "PeshangDes2", size: 14)!
        }else if XLanguage.get() == .Kurdish{
            self.RentRadioButton.setTitle("کرێ", for: .normal)
            self.SellRadioButton.setTitle("فروشتن", for: .normal)
            self.RentRadioButton.titleLabel?.font = UIFont(name: "PeshangDes2", size: 14)!
            self.SellRadioButton.titleLabel?.font = UIFont(name: "PeshangDes2", size: 14)!
        }else if XLanguage.get() == .English {
            self.RentRadioButton.setTitle("RENT", for: .normal)
            self.SellRadioButton.setTitle("SELL", for: .normal)
            self.RentRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.SellRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .French {
            self.RentRadioButton.setTitle("LOUER", for: .normal)
            self.SellRadioButton.setTitle("VENDRE", for: .normal)
            self.RentRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.SellRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .Spanish {
            self.RentRadioButton.setTitle("ALQUILAR", for: .normal)
            self.SellRadioButton.setTitle("VENDER", for: .normal)
            self.RentRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.SellRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .German {
            self.RentRadioButton.setTitle("MIETEN", for: .normal)
            self.SellRadioButton.setTitle("VERKAUFEN", for: .normal)
            self.RentRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.SellRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .Dutch {
            self.RentRadioButton.setTitle("HUREN", for: .normal)
            self.SellRadioButton.setTitle("VERKOPEN", for: .normal)
            self.RentRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.SellRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .Portuguese {
            self.RentRadioButton.setTitle("ALUGAR", for: .normal)
            self.SellRadioButton.setTitle("VENDER", for: .normal)
            self.RentRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.SellRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .Russian {
            self.RentRadioButton.setTitle("СДАТЬ В АРЕНДУ", for: .normal)
            self.SellRadioButton.setTitle("ПРОДАТЬ", for: .normal)
            self.RentRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.SellRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .Chinese {
            self.RentRadioButton.setTitle("出租", for: .normal)
            self.SellRadioButton.setTitle("出售", for: .normal)
            self.RentRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.SellRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .Hindi {
            self.RentRadioButton.setTitle("किराये पर देना", for: .normal)
            self.SellRadioButton.setTitle("बेचना", for: .normal)
            self.RentRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.SellRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .Swedish {
            self.RentRadioButton.setTitle("HYRA", for: .normal)
            self.SellRadioButton.setTitle("SÄLJA", for: .normal)
            self.RentRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.SellRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .Greek {
            self.RentRadioButton.setTitle("ΕΝΟΙΚΙΑΣΗ", for: .normal)
            self.SellRadioButton.setTitle("ΠΩΛΗΣΗ", for: .normal)
            self.RentRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.SellRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        }

        
        setupGroup2()
        
        NumberOfRoomsCollectionView.register(UINib(nibName: "EstateTypeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NCell")
        EstateTypeCollectionView.register(UINib(nibName: "EstateTypeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EstateCell")
        GetEstateType()
        GetAllEstates()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    var count = 1
    @objc func keyboardWasShown(notification: NSNotification) {
        if count == 1{
           count += 1
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        self.ScrollViewLayout.constant += keyboardFrame.height - 100
        }
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
    var CityId = ""
    
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
                print(CityId)
                self.CityId = CityId
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
    var filter6 : [EstateObject] = []
    var filter1 : [EstateObject] = []
    @IBAction func Apply(_ sender: Any) {
        Drops.hideAll()
        if !CheckInternet.Connection(){
            if XLanguage.get() == .English{
                let ac = UIAlertController(title: "Error", message: "Please check your internet connection.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            }else if XLanguage.get() == .Arabic{
                let ac = UIAlertController(title: "خطأ", message: "الرجاء التحقق من اتصال الانترنت الخاص بك.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "نعم", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            }else if XLanguage.get() == .Kurdish{
                let ac = UIAlertController(title: "هەڵە", message: "تکایە هێڵی ئینتەرنێتەکەت بپشکنە.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "باشە", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            }else if XLanguage.get() == .Dutch {
                let ac = UIAlertController(title: "Fout", message: "Controleer uw internetverbinding.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .French {
                let ac = UIAlertController(title: "Erreur", message: "Veuillez vérifier votre connexion internet.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Spanish {
                let ac = UIAlertController(title: "Error", message: "Por favor, verifica tu conexión a internet.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .German {
                let ac = UIAlertController(title: "Fehler", message: "Bitte überprüfen Sie Ihre Internetverbindung.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Hebrew {
                let ac = UIAlertController(title: "שגיאה", message: "אנא בדוק את חיבור האינטרנט שלך.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "אישור", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Chinese {
                let ac = UIAlertController(title: "错误", message: "请检查您的互联网连接。", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "确定", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Hindi {
                let ac = UIAlertController(title: "त्रुटि", message: "कृपया अपना इंटरनेट कनेक्शन जाँच लें।", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "ठीक है", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Portuguese {
                let ac = UIAlertController(title: "Erro", message: "Por favor, verifique sua conexão com a internet.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Swedish {
                let ac = UIAlertController(title: "Fel", message: "Vänligen kontrollera din internetanslutning.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Greek {
                let ac = UIAlertController(title: "Σφάλμα", message: "Παρακαλώ ελέγξτε τη σύνδεσή σας στο διαδίκτυο.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "ΟΚ", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            } else if XLanguage.get() == .Russian {
                let ac = UIAlertController(title: "Ошибка", message: "Пожалуйста, проверьте ваше интернет-соединение.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "ОК", style: .default, handler: { _ in
                    ac.dismiss(animated: true)
                }))
                present(ac, animated: true)
            }
        }else{
        
        var Price_Min = Double(self.PriceMin.text!) ?? 0.0
        var Price_Max = Double(self.PriceMax.text!) ?? 0.0
        
        if Price_Min < 0{
            Price_Min = Price_Min * -1
        }
        
        if Price_Max < 0{
            Price_Max = Price_Max * -1
        }
        
        
        if Price_Min == 0.0 && Price_Max == 0.0{
            filter1 = self.AllEstateArray
        }else if Price_Min >= 0.0 && Price_Max >= 0.0{
            if Price_Min > Price_Max{
                self.PriceMIN = Price_Max
                self.PriceMAX = Price_Min
            }else{
                self.PriceMIN = Price_Min
                self.PriceMAX = Price_Max
            }
            filter1 = self.AllEstateArray.filter{ $0.price ?? 0 <= self.PriceMAX && $0.price ?? 0 >= self.PriceMIN}
        }
        
        if self.PriceMIN == 0.0 && self.PriceMAX != 0.0{
            filter1 = self.AllEstateArray.filter{ $0.price ?? 0 <= self.PriceMAX}
        }
        if self.PriceMIN != 0.0 && self.PriceMAX == 0.0{
            filter1 = self.AllEstateArray.filter{ $0.price ?? 0 >= self.PriceMIN}
        }
        
        

        let filter2 = filter1.filter{ $0.space ?? "" <= self.MaxSpaceLable.text! && $0.space ?? "" >= self.MinSpaceLable.text!}

        let filter3 = filter2.filter{ $0.RoomNo == "\(self.NumberOfRoom)"}

        let filter4 = filter3.filter{ $0.estate_type_id == self.EstateTypy }

        let filter5 = filter4.filter{ $0.RentOrSell == self.RentOrSell}

        if self.CityId == ""{
            self.filter6 = filter5
        }else{
            self.filter6 = filter5.filter{ $0.city_id == self.CityId}
        }

        if self.filter6.count != 0{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let myVC = storyboard.instantiateViewController(withIdentifier: "AllEstateVC") as! AllEstateVC
            myVC.title = "Result"
            myVC.AllEstate = self.filter6
            self.navigationController?.pushViewController(myVC, animated: true)
        }else{
            AudioServicesPlaySystemSound(1519);
            var title = "Empty"
            var message = "No estates are found"
            
           if XLanguage.get() == .Kurdish{
                title = "بەتاڵ"
                message = "هیچ خانوبەرێک نەدۆزراوەتەوە"
           }else if XLanguage.get() == .Arabic{
                title = "فارغة"
                message = "لم يتم العثور على عقار"
            }else if XLanguage.get() == .English {
                title = "Empty"
                message = "No estates are found"
            } else if XLanguage.get() == .French {
                title = "Vide"
                message = "Aucun bien immobilier trouvé"
            } else if XLanguage.get() == .Spanish {
                title = "Vacío"
                message = "No se encontraron propiedades"
            } else if XLanguage.get() == .German {
                title = "Leer"
                message = "Keine Immobilien gefunden"
            } else if XLanguage.get() == .Dutch {
                title = "Leeg"
                message = "Geen vastgoed gevonden"
            } else if XLanguage.get() == .Portuguese {
                title = "Vazio"
                message = "Nenhum imóvel encontrado"
            } else if XLanguage.get() == .Russian {
                title = "Пусто"
                message = "Недвижимость не найдена"
            } else if XLanguage.get() == .Chinese {
                title = "空的"
                message = "未找到房地产"
            } else if XLanguage.get() == .Hindi {
                title = "खाली"
                message = "कोई संपत्ति नहीं मिली"
            } else if XLanguage.get() == .Swedish {
                title = "Tom"
                message = "Inga fastigheter hittades"
            } else if XLanguage.get() == .Greek {
                title = "Άδειο"
                message = "Δεν βρέθηκαν ακίνητα"
            } else if XLanguage.get() == .Hebrew {
                title = "ריק"
                message = "לא נמצאו נכסים"
            }

            let drop = Drop(
                title: title,
                subtitle: message,
                icon: UIImage(named: "attention"),
                action: .init {
                    print("Drop tapped")
                    Drops.hideCurrent()
                },
                position: .bottom,
                duration: 3.0,
                accessibility: "Alert: Title, Subtitle"
            )
            Drops.show(drop)
        }
        }

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
                    self.EstateTypy = self.EstatesType[indexPath.row].id ?? ""
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
                    cell.Name.font =  UIFont(name: "ArialRoundedMTBold", size: 11)!
                
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
                self.NumberOfRoom = NumberOfRooms[indexPath.row]
                self.selecteNumbercell = self.NumberOfRooms[indexPath.row]
                self.NumberOfRoomsCollectionView.reloadData()
            }
        }
    }
    
}


