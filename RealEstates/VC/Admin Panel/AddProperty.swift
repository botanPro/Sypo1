//
//  AddProperty.swift
//  RealEstates
//
//  Created by botan pro on 2/9/22.
//

import UIKit
import BSImagePicker
import Photos
import MBRadioCheckboxButton
import DropDown
import Toast_Swift
import Firebase
import FirebaseStorage
import FirebaseFirestore
class AddProperty: UIViewController , RadioButtonDelegate, UITextFieldDelegate ,UIPickerViewDelegate , UIPickerViewDataSource ,UITextViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == ProjectpickerView{
           return ProjectArray.count
        }
        
        if pickerView == EstateTypepickerView{
            return EstatesType.count
        }
        
        if pickerView == TypepickerView{
            return typees.count
        }
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            
            pickerLabel?.textAlignment = .center
            
            if pickerView == ProjectpickerView{
                if self.ProjectArray[row].id == "ZlFVOHo5MUXQ8NtnZfZ7"{
                    pickerLabel?.textColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
                }
                if XLanguage.get() == .English{
                    pickerLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
                    pickerLabel?.text = self.ProjectArray[row].project_name
                }else if XLanguage.get() == .Arabic{
                    pickerLabel?.font = UIFont(name: "PeshangDes2", size: 12)!
                    pickerLabel?.text = self.ProjectArray[row].project_ar_name
                }else{
                    pickerLabel?.font = UIFont(name: "PeshangDes2", size: 12)!
                    pickerLabel?.text = self.ProjectArray[row].project_ku_name
                }
            }
            
            if pickerView == EstateTypepickerView{
                if XLanguage.get() == .English{
                    pickerLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
                    pickerLabel?.text = self.EstatesType[row].name
                }else if XLanguage.get() == .Arabic{
                    pickerLabel?.font = UIFont(name: "PeshangDes2", size: 12)!
                    pickerLabel?.text = self.EstatesType[row].ar_name
                }else{
                    pickerLabel?.font = UIFont(name: "PeshangDes2", size: 12)!
                    pickerLabel?.text = self.EstatesType[row].ku_name
                }
            }
            
            if pickerView == TypepickerView{
                if XLanguage.get() == .English{
                    pickerLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
                    pickerLabel?.text = self.typees[row].name
                }else if XLanguage.get() == .Arabic{
                    pickerLabel?.font = UIFont(name: "PeshangDes2", size: 12)!
                    pickerLabel?.text = self.typees[row].ar_name
                }else{
                    pickerLabel?.font = UIFont(name: "PeshangDes2", size: 12)!
                    pickerLabel?.text = self.typees[row].ku_name
                }
            }
        }
        return pickerLabel!
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if pickerView == ProjectpickerView{
//        self.ProjectName.text = self.ProjectArray[row].project_name
//        self.ProjectId = self.ProjectArray[row].id ?? ""
//        }
//        if pickerView == EstateTypepickerView{
//        self.EstateTypeLable.text = self.EstatesType[row].name
//        self.selecteEstatedcell = self.EstatesType[row]
//        }
//        if pickerView == TypepickerView{
//        self.Typelable.text = self.typees[row].name
//       // self.ProjectId = self.typees[row].id ?? ""
//        }
    }

    
    
    
    
    
    var BoudTypes : [BoundTypeObject] = []
    var SelectedFurnished = "0"
    var SelectedBoundTypeId = "0"
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.Furnished {
            self.view.endEditing(true)
            
            if XLanguage.get() == .Kurdish{
                dropDown.dataSource = ["مۆبیلیات کراوە", "مۆبیلیات نییە"]
            }else if XLanguage.get() == .English{
                dropDown.dataSource = ["Furnished", "Not Furnished"]
            }else{
                dropDown.dataSource = ["مفروشة", "غير مفروشة"]
            }
            
            dropDown.show()
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.Furnished.text = item
                self.SelectedFurnished = "\(index)"
                dropDown.hide()
            }
        }
        
        if textField == self.BondType {
            self.view.endEditing(true)
            self.dropDown1.dataSource.removeAll()
            BoundTypeAip.GetAllBoundType { bounds in
                self.BoudTypes = bounds
                for bound in bounds{
                    self.dropDown1.dataSource.append(bound.en_title ?? "")
                }
                self.dropDown1.show()
                self.dropDown1.selectionAction = { [unowned self] (index: Int, item: String) in
                    self.BondType.text = item
                    self.SelectedBoundTypeId = self.BoudTypes[index].id ?? ""
                    dropDown1.hide()
                }
            }
            
        }
    }
    
    
    var RentOrSell = 0
    func radioButtonDidSelect(_ button: RadioButton) {
        print("select  : \(button.tag)")
        if button.tag == 1{
            self.RentOrSell = 1
        }else{
            self.RentOrSell = 0
        }
    }
    
    func radioButtonDidDeselect(_ button: RadioButton) {
        print("Dselect  : \(button.tag)")
    }
    
    
    var selecteEstatedcell : EstateTypeObject?
    var selecteNumbercell = 0
    var selecteWashcell = 0
    var selecteTypecell : TypesObject?
    var NumberOfRoom = 0
    var NumberOfWashRoom = 0
    var SelectedEstateTypy = ""
    var Selectedtypee =  ""
    var EstatesType : [EstateTypeObject] = []
    var typees : [TypesObject] = []
    var NumberOfWashRooms = [1,2,3,4,5,6,7,8,9,10]
    var NumberOfRooms = [1,2,3,4,5,6,7,8,9,10]
    @IBOutlet weak var NumberOfRoomsCollectionView: UICollectionView!
    @IBOutlet weak var NumberOfWashRoomsCollectionView: UICollectionView!
    
    @IBOutlet weak var ScrollViewLayout: NSLayoutConstraint!
    
    
    @IBOutlet weak var RentRadioButton: RadioButton!
    @IBOutlet weak var SellRadioButton: RadioButton!
    
    
 
    
    @IBOutlet weak var LatLongAddress: UILabel!
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Price: UITextField!
    @IBOutlet weak var Address: UITextField!
    @IBOutlet weak var Desc: UITextView!
    
    

    
    @IBOutlet weak var Space: LanguagePlaceHolder!
    @IBOutlet weak var Furnished: LanguagePlaceHolder!
    @IBOutlet weak var Floor: LanguagePlaceHolder!
    @IBOutlet weak var Building: LanguagePlaceHolder!
    @IBOutlet weak var BondType: LanguagePlaceHolder!
    @IBOutlet weak var PropertyNo: LanguagePlaceHolder!
    @IBOutlet weak var Year: LanguagePlaceHolder!
    @IBOutlet weak var MonthlyFee: LanguagePlaceHolder!
    
    
    
    var group3Container = RadioButtonContainer()
    @IBOutlet weak var viewGroup: RadioButtonContainerView!
  
    
    func setupGroup2() {
        viewGroup.buttonContainer.delegate = self
        viewGroup.buttonContainer.setEachRadioButtonColor {
            return RadioButtonColor(active: $0.tintColor , inactive: $0.tintColor)
        }
        group3Container.addButtons([RentRadioButton, SellRadioButton])
        group3Container.delegate = self
        group3Container.selectedButton = RentRadioButton
    }
    
    
    let dropDown = DropDown()
    let dropDown1 = DropDown()
    
    
    @IBOutlet weak var UploadItemBar: UIBarButtonItem!
    
    
    
    @IBOutlet weak var TypeView: UIView!
    @IBOutlet weak var EstateTypeView: UIView!
    
    @IBOutlet weak var Typelable: UILabel!
    @IBOutlet weak var EstateTypeLable: UILabel!
    
    @IBOutlet weak var InternetViewHeight: NSLayoutConstraint!
    @IBOutlet weak var InternetConnectionView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.InternetViewHeight.constant = 0
        self.InternetConnectionView.isHidden = true
        setupGroup2()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.ProjectHeight.constant = 0
        self.ProjectTopConstans.constant = 0
        self.ProjectView.isHidden = true
        
        
        TypeView.layer.backgroundColor = UIColor.clear.cgColor
        TypeView.layer.borderWidth = 1
        TypeView.layer.borderColor = #colorLiteral(red: 0.776776731, green: 0.8295580745, blue: 0.8200985789, alpha: 1)
        
        EstateTypeView.layer.backgroundColor = UIColor.clear.cgColor
        EstateTypeView.layer.borderWidth = 1
        EstateTypeView.layer.borderColor = #colorLiteral(red: 0.776776731, green: 0.8295580745, blue: 0.8200985789, alpha: 1)
        
        ProjectView.layer.backgroundColor = UIColor.clear.cgColor
        ProjectView.layer.borderWidth = 1
        ProjectView.layer.borderColor = #colorLiteral(red: 0.776776731, green: 0.8295580745, blue: 0.8200985789, alpha: 1)
        
        
        
        if XLanguage.get() == .English{
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 16)!,.foregroundColor: #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)]
            self.RentRadioButton.setTitle("RENT", for: .normal)
            self.SellRadioButton.setTitle("SELL", for: .normal)
            self.RentRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            self.SellRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        }else if XLanguage.get() == .Arabic{
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "PeshangDes2", size: 16)!,.foregroundColor: #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)]
            self.RentRadioButton.setTitle("بیع", for: .normal)
            self.SellRadioButton.setTitle("ايجار", for: .normal)
            self.RentRadioButton.titleLabel?.font = UIFont(name: "PeshangDes2", size: 14)!
            self.SellRadioButton.titleLabel?.font = UIFont(name: "PeshangDes2", size: 14)!
        }else if XLanguage.get() == .Kurdish{
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "PeshangDes2", size: 16)!,.foregroundColor: #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)]
            self.RentRadioButton.setTitle("کرێ", for: .normal)
            self.SellRadioButton.setTitle("فروشتن", for: .normal)
            self.RentRadioButton.titleLabel?.font = UIFont(name: "PeshangDes2", size: 14)!
            self.SellRadioButton.titleLabel?.font = UIFont(name: "PeshangDes2", size: 14)!
        }
        NumberOfRoomsCollectionView.register(UINib(nibName: "EstateTypeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NCell")
        NumberOfWashRoomsCollectionView.register(UINib(nibName: "EstateTypeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NWCell")
        ImagesCollectionView.register(UINib(nibName: "ExpImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        
  
        self.IsSClicked = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.Furnished.delegate = self
        self.BondType.delegate = self
        dropDown.anchorView = self.Furnished
        dropDown1.anchorView = self.BondType
        GetEstateTypes()
        GetType()
        GetAllProjects()
        
        if XLanguage.get() == .Kurdish{
            self.ImageCount.text = "وێنە (\(self.Images.count))"
            self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
        }else if XLanguage.get() == .English{
            self.ImageCount.text = "IMAGES (\(self.Images.count))"
            self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        }else{
            self.ImageCount.text = "صور (\(self.Images.count))"
            self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
        }
        
        if XLanguage.get() == .English{
            self.LatLongAddress.text = "LOCATION ()"
            self.LatLongAddress.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        }else if XLanguage.get() == .Arabic{
            self.LatLongAddress.text = "الموقع ()"
            self.LatLongAddress.font = UIFont(name: "PeshangDes2", size: 12)!
        }else{
            self.LatLongAddress.text = "شوێن ()"
            self.LatLongAddress.font = UIFont(name: "PeshangDes2", size: 12)!
        }
        
        
        self.Name.delegate = self
        self.Name.delegate = self
        self.Name.delegate = self
        self.Price.delegate = self
        self.Price.delegate = self
        self.Price.delegate = self
        self.Address.delegate = self
        self.Address.delegate = self
        self.Address.delegate = self
        self.Space.delegate = self
        self.Space.delegate = self
        self.Space.delegate = self
        self.Floor.delegate = self
        self.Floor.delegate = self
        self.Floor.delegate = self
        self.Building.delegate = self
        self.Building.delegate = self
        self.Building.delegate = self
        self.Year.delegate = self
        self.Year.delegate = self
        self.Year.delegate = self
        self.MonthlyFee.delegate = self
        self.MonthlyFee.delegate = self
        self.MonthlyFee.delegate = self
        self.PropertyNo.delegate = self
        self.PropertyNo.delegate = self
        self.PropertyNo.delegate = self

        
        
        GetData()
    }
    
    
    
    var CommingEstate : EstateObject?
    var IsUpdate = false
    var CommignImages : [String] = []
    var estate_id = ""
    var IsUpdateEstateType = false
    func GetData(){
        self.RemoveAllImages.isEnabled = false
        if let data = CommingEstate{
            self.IsUpdate = true
            self.estate_id = data.id ?? ""
            self.CommignImages = data.ImageURL ?? []
            if XLanguage.get() == .Kurdish{
                self.ImageCount.text = "وێنە (\(self.CommignImages.count))"
                self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
            }else if XLanguage.get() == .English{
                self.ImageCount.text = "IMAGES (\(self.CommignImages.count))"
                self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            }else{
                self.ImageCount.text = "صور (\(self.CommignImages.count))"
                self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
            }
            
            if self.CommignImages.count != 0{
                self.ImagesCollectionViewLayoutHeight.constant = 150
                self.view.layoutIfNeeded()
            }
            self.ImagesCollectionView.reloadData()
           
            self.Name.text = data.name ?? ""
            self.Price.text = "\(data.price ?? 0.0)"
            self.Space.text = data.space
            self.selecteNumbercell = (data.RoomNo as? NSString)?.integerValue ?? 0
            self.selecteWashcell = (data.WashNo as? NSString)?.integerValue ?? 0
            self.NumberOfRoomsCollectionView.reloadData()
            self.NumberOfWashRoomsCollectionView.reloadData()
            self.PropertyNo.text = data.propertyNo
            self.Address.text = data.address
            
            
            
            

            
            
            self.Floor.text = data.floor
            self.Building.text = data.Building
            self.Year.text = data.Year
            self.MonthlyFee.text = data.MonthlyService
            self.Desc.text = data.desc
            self.lat = data.lat ?? ""
            self.long = data.long ?? ""
            
            if XLanguage.get() == .English{
                self.LatLongAddress.text = "LOCATION (\(self.lat), \(self.long))"
            }else if XLanguage.get() == .Arabic{
                self.LatLongAddress.text = "الموقع (\(self.lat), \(self.long))"
            }else{
                self.LatLongAddress.text = "شوێن (\(self.lat), \(self.long))"
            }
            
            if data.Furnished == "0" && XLanguage.get() == .English{
                self.Furnished.text = "Furnished"
                self.SelectedFurnished = "0"
            }else if data.Furnished == "1" && XLanguage.get() == .English{
                self.Furnished.text = "Not Furnished"
                self.SelectedFurnished = "1"
            }
            if data.Furnished == "0" && XLanguage.get() == .Kurdish{
                self.Furnished.text = "مۆبیلیات کراوە"
                self.SelectedFurnished = "0"
            }else if data.Furnished == "1" && XLanguage.get() == .Kurdish{
                self.Furnished.text = "مۆبیلیات نییە"
                self.SelectedFurnished = "1"
            }
            if data.Furnished == "0" && XLanguage.get() == .Arabic{
                self.Furnished.text = "مفروشة"
                self.SelectedFurnished = "0"
            }else if data.Furnished == "1" && XLanguage.get() == .Arabic{
                self.Furnished.text = "غير مفروشة"
                self.SelectedFurnished = "1"
            }
            
            
            
            BoundTypeAip.GetBoundTypeByOfficeId(id: data.bound_id ?? "") { bound in
                self.SelectedBoundTypeId = bound.id ?? ""
                self.BondType.text = bound.en_title ?? ""
            }
            

        
            if data.RentOrSell == "1" {
                self.RentRadioButton.isOn = false
                self.SellRadioButton.isOn = true
                group3Container.selectedButton = SellRadioButton
            }else{
                self.RentRadioButton.isOn = true
                self.SellRadioButton.isOn = false
                group3Container.selectedButton = RentRadioButton
            }
            
            self.AddressLable.text = data.city_name
            self.city = data.city_name ?? ""
            self.CityId = data.city_id ?? ""
            
            self.selecteEstatedcell = EstateTypeObject(name: "", id:data.estate_type_id ??  "",ar_name: "" , ku_name: "")
            
            EstateTypeAip.GeEstateTypeNameById(id: data.estate_type_id ?? "") { type in
                self.EstateTypeLable.text = type.name
            }
           

            print("===================================")
            if data.estate_type_id == "UTY25FYJHkliygt4nvPP"{
                GetAllProjectsAip.GetAllProducts { project in
                    for pro in project{
                        if pro.id == data.project_id{
                            self.ProjectName.text = pro.project_name
                        }
                    }
                }
                self.ProjectId = data.project_id ?? ""
                self.IsApartment = true
                self.Floor.isUserInteractionEnabled = true
                self.Floor.alpha = 1
                self.Building.isUserInteractionEnabled = true
                self.Building.alpha = 1
                self.MonthlyFee.isUserInteractionEnabled = true
                self.MonthlyFee.alpha = 1
                
                UIView.animate(withDuration: 0.2, delay: 0.0) {
                    self.ProjectHeight.constant = 45
                    self.ProjectTopConstans.constant = 20
                    self.ProjectView.isHidden = false
                    self.view.layoutIfNeeded()
                }
            }else{
                self.IsApartment = false
                self.Floor.isUserInteractionEnabled = false
                self.Floor.alpha = 0.5
                self.Building.isUserInteractionEnabled = false
                self.Building.alpha = 0.5
                self.MonthlyFee.isUserInteractionEnabled = false
                self.MonthlyFee.alpha = 0.5
                
                UIView.animate(withDuration: 0.2, delay: 0.0) {
                    self.ProjectHeight.constant = 0
                    self.ProjectTopConstans.constant = 0
                    self.ProjectView.isHidden = true
                    self.view.layoutIfNeeded()
                }
            }
            self.IsUpdateEstateType = true
            
            self.Direction = data.Direction ?? ""
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.endEditing(true)
        if IsUpdate == false{
        if self.Images.count == 0{
            self.ImagesCollectionViewLayoutHeight.constant = 0
        }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.MapDissmised), name: NSNotification.Name(rawValue: "MapDissmised"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.GetCordinate(_:)), name: NSNotification.Name(rawValue: "CordinateComing"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notificationRecevied1(_:)), name: NSNotification.Name(rawValue: "CityName"), object: nil)
    }
    
    /// ava waxte map dismissed bo keyboard barza dbo veja waxte dismissed dbyt eksar address active dbyt da keyboard dyar bbyt
    @objc func MapDissmised(){
        //self.Address.becomeFirstResponder()
    }
    
    
    @IBAction func ChooseType(_ sender: Any) {
        setupTypesAlert()
    }
    
    var IsPickerSelected = ""
    var TypepickerView = UIPickerView(frame: CGRect(x: 10, y: 50, width: 250, height: 150))
    
    private func setupTypesAlert() {
        GetType()
        TypepickerView.delegate = self
        TypepickerView.dataSource = self
        IsPickerSelected = "1"
        if XLanguage.get() == .Kurdish{
            self.ProjectsTitle   = "جۆرەکە هەلبژێرە"
            self.ProjectsAction  = "هەڵبژێرە"
            self.ProjectsCancel  = "هەڵوەشاندنەوە"
        }else if XLanguage.get() == .English{
            self.ProjectsTitle   = "Choose a Type"
            self.ProjectsAction  = "Select"
            self.ProjectsCancel  = "Cancel"
        }else{
            self.ProjectsTitle   = "اختر نوع"
            self.ProjectsAction  = "تحديد"
            self.ProjectsCancel  = "إلغاء"
        }
        let ac = UIAlertController(title:  self.ProjectsTitle, message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        ac.view.addSubview(TypepickerView)
        ac.addAction(UIAlertAction(title:  self.ProjectsAction, style: .default, handler: { _ in
            if self.typees.count != 0{
            let pickerValue = self.typees[self.TypepickerView.selectedRow(inComponent: 0)]
            if XLanguage.get() == .English{
            self.Typelable.text = pickerValue.name
                self.Typelable.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            }else if XLanguage.get() == .Arabic{
                self.Typelable.text = pickerValue.ar_name
                self.Typelable.font = UIFont(name: "PeshangDes2", size: 12)!
            }else{
                self.Typelable.text = pickerValue.ku_name
                self.Typelable.font = UIFont(name: "PeshangDes2", size: 12)!
            }
            
            
            print("Picker value: \(pickerValue) was selected")
            }
        }))
        ac.addAction(UIAlertAction(title: self.ProjectsCancel, style: .cancel, handler: nil))
        present(ac, animated: true)
    }
    
    
    
    func GetType(){
        self.typees.removeAll()
        TypesObjectAip.GetTypes { types in
            self.typees = types
            self.TypepickerView.reloadAllComponents()
        }
    }
    
    
    
    
    
    @IBAction func ChooseEstateType(_ sender: Any) {
        setupEstateTypesAlert()
    }
    
    
    var EstateTypepickerView = UIPickerView(frame: CGRect(x: 10, y: 50, width: 250, height: 150))
    private func setupEstateTypesAlert() {
        GetEstateTypes()
        EstateTypepickerView.delegate = self
        EstateTypepickerView.dataSource = self
        IsPickerSelected = "2"
        if XLanguage.get() == .Kurdish{
            self.ProjectsTitle = "جۆری خانوبەر هەلبژێرە"
            self.ProjectsAction = "هەڵبژێرە"
            self.ProjectsCancel = "هەڵوەشاندنەوە"
        }else if XLanguage.get() == .English{
            self.ProjectsTitle = "Choose Estate Type"
            self.ProjectsAction = "Select"
            self.ProjectsCancel = "Cancel"
        }else{
            self.ProjectsTitle = "اختر نوع العقار"
            self.ProjectsAction  = "تحديد"
            self.ProjectsCancel  = "إلغاء"
        }
        let ac = UIAlertController(title:  self.ProjectsTitle, message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        ac.view.addSubview(EstateTypepickerView)
        ac.addAction(UIAlertAction(title:  self.ProjectsAction, style: .default, handler: { _ in
            if self.EstatesType.count != 0{
            let pickerValue = self.EstatesType[self.EstateTypepickerView.selectedRow(inComponent: 0)]
            if XLanguage.get() == .English{
            self.EstateTypeLable.text = pickerValue.name
                self.EstateTypeLable.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            }else if XLanguage.get() == .Arabic{
                self.EstateTypeLable.text = pickerValue.ar_name
                self.EstateTypeLable.font = UIFont(name: "PeshangDes2", size: 12)!
            }else{
                self.EstateTypeLable.text = pickerValue.ku_name
                self.EstateTypeLable.font = UIFont(name: "PeshangDes2", size: 12)!
            }
            self.selecteEstatedcell = pickerValue
            print(pickerValue.id ?? "")
            if pickerValue.id == "UTY25FYJHkliygt4nvPP"{
                self.IsApartment = true
                self.Floor.isUserInteractionEnabled = true
                self.Floor.alpha = 1
                self.Building.isUserInteractionEnabled = true
                self.Building.alpha = 1
                self.MonthlyFee.isUserInteractionEnabled = true
                self.MonthlyFee.alpha = 1
                UIView.animate(withDuration: 0.2, delay: 0.0) {
                    self.ProjectHeight.constant = 45
                    self.ProjectTopConstans.constant = 20
                    self.ProjectView.isHidden = false
                    self.view.layoutIfNeeded()
                }
            }else{
                self.IsApartment = false
                self.Floor.isUserInteractionEnabled = false
                self.Floor.alpha = 0.5
                self.Building.isUserInteractionEnabled = false
                self.Building.alpha = 0.5
                self.MonthlyFee.isUserInteractionEnabled = false
                self.MonthlyFee.alpha = 0.5
                UIView.animate(withDuration: 0.2, delay: 0.0) {
                    self.ProjectHeight.constant = 0
                    self.ProjectTopConstans.constant = 0
                    self.ProjectView.isHidden = true
                    self.view.layoutIfNeeded()
                }
            }
            print("Picker value: \(pickerValue.name ?? "") was selected")
            }
        }))
        ac.addAction(UIAlertAction(title: self.ProjectsCancel, style: .cancel, handler: nil))
        present(ac, animated: true)
        
    }
    
    
    
    
    
    func GetEstateTypes(){
        self.EstatesType.removeAll()
        EstateTypeAip.GetEstateType{ (estates) in
            self.EstatesType = estates
            self.EstateTypepickerView.reloadAllComponents()
        }
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
    
    @objc func keyboardWasHide(notification: NSNotification) {
        self.count = 1
        self.ScrollViewLayout.constant = 0
    }
 
    
    
    var lat = ""
    var long = ""
    var NewPlace : Place!
    @objc func GetCordinate(_ notification: NSNotification) {
        if let dict = notification.userInfo as NSDictionary? {
            if let lat = dict["latitude"] as? CLLocationDegrees , let long = dict["longtitude"] as? CLLocationDegrees{
                let Lat = "\(lat)"
                let arrLat = Array(Lat)
                let Long = "\(long)"
                let arrLong = Array(Long)
                self.lat = String(arrLat[0..<8])
                self.long = String(arrLong[0..<8])
                if XLanguage.get() == .English{
                    self.LatLongAddress.text = "LOCATION (\(String(arrLat[0..<8])), \(String(arrLong[0..<8])))"
                }else if XLanguage.get() == .Arabic{
                    self.LatLongAddress.text = "الموقع (\(String(arrLat[0..<8])), \(String(arrLong[0..<8])))"
                }else{
                    self.LatLongAddress.text = "شوێن (\(String(arrLat[0..<8])), \(String(arrLong[0..<8])))"
                }
                self.Address.becomeFirstResponder()
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    var IsApartment = false
    @IBOutlet weak var ProjectTopConstans: NSLayoutConstraint!
    @IBOutlet weak var ProjectHeight: NSLayoutConstraint!
    @IBOutlet weak var ProjectView : UIView!
    private var alertController = UIAlertController()
    private var tblView = UITableView()
    var ProjectpickerView = UIPickerView(frame: CGRect(x: 10, y: 50, width: 250, height: 150))
    @IBOutlet weak var ProjectName : UILabel!
    var ProjectId = ""
    
    @IBAction func ChooseProject(_ sender: Any) {
        setupCitySelectionAlert()
    }
    
    
    var ProjectArray : [ProjectObject] = []
    var ProjectsTitle = ""
    var ProjectsAction = ""
    var ProjectsCancel = ""
    private func setupCitySelectionAlert() {
        ProjectpickerView.delegate = self
        ProjectpickerView.dataSource = self
        IsPickerSelected = "3"
        if XLanguage.get() == .Kurdish{
            self.ProjectsTitle = "پرۆژە هەڵبژێرە"
            self.ProjectsAction  = "هەڵبژێرە"
            self.ProjectsCancel  = "هەڵوەشاندنەوە"
        }else if XLanguage.get() == .English{
            self.ProjectsTitle = "Choose project"
            self.ProjectsAction = "Select"
            self.ProjectsCancel = "Cancel"
        }else{
            self.ProjectsTitle = "اختر المشروع"
            self.ProjectsAction = "تحديد"
            self.ProjectsCancel = "إلغاء"
        }
        
        let ac = UIAlertController(title: self.ProjectsTitle, message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        ac.view.addSubview(ProjectpickerView)
        ac.addAction(UIAlertAction(title: self.ProjectsAction, style: .default, handler: { _ in
            if self.ProjectArray.count != 0{
            let pickerValue = self.ProjectArray[self.ProjectpickerView.selectedRow(inComponent: 0)]
            self.ProjectName.text = pickerValue.project_name
            self.ProjectId = pickerValue.id ?? ""
            print("Picker value: \(pickerValue) was selected")
            }
        }))
        ac.addAction(UIAlertAction(title: self.ProjectsCancel, style: .cancel, handler: nil))
        present(ac, animated: true)
    }
    
    
    func GetAllProjects(){
        self.ProjectArray.removeAll()
        GetAllProjectsAip.GetAllProducts { pro in
            self.ProjectArray = pro
            self.ProjectpickerView.reloadAllComponents()
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    @IBOutlet weak var Arrow: UIImageView!
    var IsNClicked = false
    var IsEClicked = false
    var IsWClicked = false
    var IsSClicked = false
    
    var IsNWClicked = false
    var IsENClicked = false
    var IsWSClicked = false
    var IsSEClicked = false
    
    var Direction = "N"
    
    
    
    
    
    @IBAction func N(_ sender: Any) {
        if !IsNClicked{
            if IsEClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 1.5)
                }
            }
            if IsSClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 3)
                }
            }
            if IsWClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: -(.pi * 1.5))
                }
            }
            
            
            if IsENClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 1.75)
                }
            }
            if IsNWClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: -(.pi * 1.75))
                }
            }
            if IsSEClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 1.25)
                }
            }
            if IsWSClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: -(.pi * 1.25))
                }
            }
           
            
            
            self.Direction = "N"
            self.IsNClicked = true
            self.IsEClicked = false
            self.IsWClicked = false
            self.IsSClicked = false
            
            self.IsNWClicked = false
            self.IsENClicked = false
            self.IsSEClicked = false
            self.IsWSClicked = false
        }
    }
    
    @IBAction func E(_ sender: Any) {
        if !IsEClicked{
            if IsNClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: -(.pi * 1.5))
                }
            }
            if IsSClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 1.5)
                }
            }
            if IsWClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 3)
                }
            }
            
            
            if IsENClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: -(.pi * 1.75))
                }
            }
            if IsNWClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: -(.pi * 1.25))
                }
            }
            if IsSEClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 1.75)
                }
            }
            if IsWSClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 1.25)
                }
            }
            
            self.Direction = "E"
            self.IsEClicked = true
            self.IsNClicked = false
            self.IsWClicked = false
            self.IsSClicked = false
            
            self.IsNWClicked = false
            self.IsENClicked = false
            self.IsSEClicked = false
            self.IsWSClicked = false
                
        }
    }
    
    @IBAction func S(_ sender: Any) {
        if !IsSClicked{
            
            if IsNClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 3)
                }
            }
            if IsEClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: -(.pi * 1.5))
                }
            }
            if IsWClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 1.5)
                }
            }
            
            
            
            
            
            if IsENClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: -(.pi * 1.25))
                }
            }
            if IsNWClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 1.25)
                }
            }
            if IsSEClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: -(.pi * 1.75))
                }
            }
            if IsWSClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 1.75)
                }
            }
            
            
            
            self.Direction = "S"
            self.IsSClicked = true
            self.IsEClicked = false
            self.IsNClicked = false
            self.IsWClicked = false
            
            self.IsNWClicked = false
            self.IsENClicked = false
            self.IsSEClicked = false
            self.IsWSClicked = false
        }
    }
    
    
    @IBAction func W(_ sender: Any) {
        if !IsWClicked{
            if IsNClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 1.5)
                }
            }
            if IsSClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: -(.pi * 1.5))
                }
            }
            if IsEClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 3)
                }
            }
            
            
            
            
            if IsENClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 1.25)
                }
            }
            if IsNWClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 1.75)
                }
            }
            if IsSEClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: -(.pi * 1.25))
                }
            }
            if IsWSClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: -(.pi * 1.75))
                }
            }
            
            
            
            self.Direction = "W"
            self.IsWClicked = true
            self.IsEClicked = false
            self.IsNClicked = false
            self.IsSClicked = false
            
            self.IsNWClicked = false
            self.IsENClicked = false
            self.IsSEClicked = false
            self.IsWSClicked = false
        }
    }
    
    
    
    
    
    @IBAction func NW(_ sender: Any) {
        if !IsNWClicked{
            if IsNClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 1.75)
                }
            }
            if IsSClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: -(.pi * 1.25))
                }
            }
            if IsEClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 1.25)
                }
            }
            if IsWClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: -(.pi * 1.75))
                }
            }
            
            
            
            
            if IsENClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 1.5)
                }
            }
            if IsSEClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 3)
                }
            }
            if IsWSClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: -(.pi * 1.5))
                }
            }
        }
        
        self.IsWClicked = false
        self.IsEClicked = false
        self.IsNClicked = false
        self.IsSClicked = false
        self.Direction = "NW"
        self.IsNWClicked = true
        self.IsENClicked = false
        self.IsSEClicked = false
        self.IsWSClicked = false
    }
    
    @IBAction func WS(_ sender: Any) {
        if !IsWSClicked{
            if IsNClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 1.25)
                }
            }
            if IsSClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: -(.pi * 1.75))
                }
            }
            if IsEClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: -(.pi * 1.25))
                }
            }
            if IsWClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 1.75)
                }
            }
            
            
            
            
            
            
            
            if IsENClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 3)
                }
            }
            if IsSEClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: -(.pi * 1.5))
                }
            }
            if IsNWClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 1.5)
                }
            }
        }
        self.IsWClicked = false
        self.IsEClicked = false
        self.IsNClicked = false
        self.IsSClicked = false
        
        self.IsNWClicked = false
        self.IsENClicked = false
        self.IsSEClicked = false
        self.IsWSClicked = true
        self.Direction = "WS"
    }
    
    @IBAction func SE(_ sender: Any) {
        if !IsSEClicked{
            if IsNClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: -(.pi * 1.25))
                }
            }
            if IsSClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 1.75)
                }
            }
            if IsEClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: -(.pi * 1.75))
                }
            }
            if IsWClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 1.25)
                }
            }
            
            
            
            
            
            
            
            
            if IsENClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: -(.pi * 1.5))
                }
            }
            if IsWSClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 1.5)
                }
            }
            if IsNWClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 3)
                }
            }
        }
        self.IsWClicked = false
        self.IsEClicked = false
        self.IsNClicked = false
        self.IsSClicked = false
        
        self.IsNWClicked = false
        self.IsENClicked = false
        self.Direction = "SE"
        self.IsSEClicked = true
        self.IsWSClicked = false
    }
    
    @IBAction func EN(_ sender: Any) {
        if !IsENClicked{
            if IsNClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: -(.pi * 1.75))
                }
            }
            if IsSClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 1.25)
                }
            }
            if IsEClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 1.75)
                }
            }
            if IsWClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: -(.pi * 1.25))
                }
            }
            
            
            
            
            if IsWSClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 3)
                }
            }
            if IsSEClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: .pi * 1.5)
                }
            }
            if IsNWClicked{
                UIView.animate(withDuration: 0.3) {
                    self.Arrow.transform = self.Arrow.transform.rotated(by: -(.pi * 1.5))
                }
            }
        }
        
        self.IsWClicked = false
        self.IsEClicked = false
        self.IsNClicked = false
        self.IsSClicked = false
        
        self.IsNWClicked = false
        self.Direction = "NE"
        self.IsENClicked = true
        self.IsSEClicked = false
        self.IsWSClicked = false
        
    }
    
    
    
    
    
    
    
    
    
    @IBOutlet weak var AddressLable: LanguageLable!
    var city = ""
    var CityId = ""
    

    @objc func notificationRecevied1(_ notification: NSNotification) {
        if let data = notification.userInfo as NSDictionary? {print("33333")
            if let City = data["City"] as? String{
                self.city = City
            }
            if let CityId = data["CityId"] as? String{
                self.CityId = CityId
            }
            self.AddressLable.text = self.city
        }
    }
    
    
    
    
        
    
    

    
    @IBOutlet weak var RemoveAllImages : UIButton!
    
    @IBAction func RemoveAllImages(_ sender: Any) {
        self.Images.removeAll()
        self.ImageCount.text = "IMAGES (\(self.Images.count))"
        self.ImagesCollectionView.reloadData()
    }
    
    
    
    
    var SelectedAssets = [PHAsset]()
    var Images : [UIImage] = []
    var ImageUrl : [String] = []
    @IBAction func AddImages(_ sender: Any) {
        self.SelectedAssets.removeAll()
        let vc = BSImagePickerViewController()
        bs_presentImagePickerController(vc, animated: true,
                                        select: { (asset: PHAsset) -> Void in
        }, deselect: { (asset: PHAsset) -> Void in
        }, cancel: { (assets: [PHAsset]) -> Void in
        }, finish: { (assets: [PHAsset]) -> Void in
            for i in 0..<assets.count{
                self.SelectedAssets.append(assets[i])
                print(self.SelectedAssets)
            }
            self.getAllImages()
        }, completion: nil)
    }
    
    
    var loadingLableMessage = ""
    func LoadingView(){
        
        if XLanguage.get() == .Kurdish{
            self.loadingLableMessage = "تكایه‌ چاوه‌ڕێبه‌..."
        }else if XLanguage.get() == .English{
            self.loadingLableMessage = "Please wait..."
        }else{
            self.loadingLableMessage = "يرجى الانتظار..."
        }
            let alert = UIAlertController(title: nil, message: self.loadingLableMessage, preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    
    
   
    @IBOutlet weak var ViewmapButton: UIButton!
    
    @IBOutlet weak var ImagesCollectionViewLayoutHeight: NSLayoutConstraint!
    @IBOutlet weak var ImagesCollectionView: UICollectionView!
    var NewImages : [String] = []
    @IBOutlet weak var ImageCount : UILabel!
    func getAllImages() -> Void {
        if SelectedAssets.count != 0{
            for i in 0..<SelectedAssets.count{
                let manager = PHImageManager.default()
                let option = PHImageRequestOptions()
                var thumbnail = UIImage()
                option.isSynchronous = true
                manager.requestImage(for: SelectedAssets[i], targetSize: CGSize(width: 512, height: 512), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
                    thumbnail = result!
                })
                self.Images.append(thumbnail)
                
                if self.Images.count != 0{print("1111111")
                    UIView.animate(withDuration: 0.2, delay: 0.3, options: []) {print("222222")
                        if self.IsUpdate == true{
                            self.LoadingView()
                            self.uploadManyImage { URLs in
                                print("333333")
                                self.NewImages = URLs
                                self.CommignImages.append(contentsOf: URLs)
                                self.ImagesCollectionView.reloadData()
                                self.dismiss(animated: true, completion: nil)
                            }
                            
                        }
                        self.ImagesCollectionViewLayoutHeight.constant = 150
                        self.ImagesCollectionView.reloadData()
                        self.view.layoutIfNeeded()
                    } completion: { t in
                        
                    }
                }
                
                if self.IsUpdate == false{
                    if self.Images.count != 1{
                        if XLanguage.get() == .Kurdish{
                            self.ImageCount.text = "وێنە (\(self.Images.count))"
                            self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
                        }else if XLanguage.get() == .English{
                            self.ImageCount.text = "IMAGES (\(self.Images.count))"
                            self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
                        }else{
                            self.ImageCount.text = "صور (\(self.Images.count))"
                            self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
                        }
                    }else{
                        if XLanguage.get() == .Kurdish{
                            self.ImageCount.text = "وێنە (\(self.Images.count))"
                            self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
                        }else if XLanguage.get() == .English{
                            self.ImageCount.text = "IMAGE (\(self.Images.count))"
                            self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
                        }else{
                            self.ImageCount.text = "صور (\(self.Images.count))"
                            self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
                        }
                    }
                }else{print("555555")
                    if self.CommignImages.count != 1{
                        if XLanguage.get() == .Kurdish{
                            self.ImageCount.text = "وێنە (\(self.CommignImages.count))"
                            self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
                        }else if XLanguage.get() == .English{
                            self.ImageCount.text = "IMAGES (\(self.CommignImages.count))"
                            self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
                        }else{
                            self.ImageCount.text = "صور (\(self.CommignImages.count))"
                            self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
                        }
                    }else{
                        if XLanguage.get() == .Kurdish{
                            self.ImageCount.text = "وێنە (\(self.CommignImages.count))"
                            self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
                        }else if XLanguage.get() == .English{
                            self.ImageCount.text = "IMAGE (\(self.CommignImages.count))"
                            self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
                        }else{
                            self.ImageCount.text = "صور (\(self.CommignImages.count))"
                            self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
                        }
                    }
                }
                self.ImagesCollectionView.reloadData()
            }
        }
    }
    
    func uploadManyImage(complition : @escaping (_ URLs: [String])->()){
        var uploadedImages : [String] = []
        for one in self.Images{
            one.upload { (url) in
                uploadedImages.append(url)
                if self.Images.count == uploadedImages.count{
                    complition(uploadedImages)
                }
            }
        }
    }
    
    
    var Messagee = ""
    var Actionn = ""
    var Title = ""
    var message = ""
    var action = ""
    var cancel = ""
    
    @objc func removeOne(){
        if XLanguage.get() == .Kurdish{
            self.Title = "ژێبرن"
            self.message = "؟تو یێ پشتراستی"
            self.action = "بەلێ"
            self.cancel = "نەخێر"
        }else if XLanguage.get() == .Arabic{
            self.Title = "الحذف"
            self.message = "؟هل انت متاكد"
            self.action = "حذف"
            self.cancel = "لا"
        }else{
            self.Title = "Delete"
            self.message = "Are you sure?"
            self.action = "Yes"
            self.cancel = "Cancel"
        }
    }
    
    
    var removdImages : [String] = []
    @objc func remove(sender: UIButton) {
        if IsUpdate == false{
            self.Images.remove(at: (sender.accessibilityIdentifier! as NSString).integerValue)
            if self.Images.count == 0{
                UIView.animate(withDuration: 0.2) {
                    self.ImagesCollectionViewLayoutHeight.constant = 0
                    self.view.layoutIfNeeded()
                }
            }
            if self.Images.count != 1{
                if XLanguage.get() == .Kurdish{
                    self.ImageCount.text = "وێنە (\(self.Images.count))"
                    self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
                }else if XLanguage.get() == .English{
                    self.ImageCount.text = "IMAGES (\(self.Images.count))"
                    self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
                }else{
                    self.ImageCount.text = "صور (\(self.Images.count))"
                    self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
                }
            }else{
                if XLanguage.get() == .Kurdish{
                    self.ImageCount.text = "وێنە (\(self.Images.count))"
                    self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
                }else if XLanguage.get() == .English{
                    self.ImageCount.text = "IMAGE (\(self.Images.count))"
                    self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
                }else{
                    self.ImageCount.text = "صور (\(self.Images.count))"
                    self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
                }
            }
            self.ImagesCollectionView.reloadData()
        }else{
            self.removdImages.append(sender.accessibilityValue!)
            self.CommignImages.remove(at: (sender.accessibilityIdentifier! as NSString).integerValue)
            if self.CommignImages.count == 0{
                UIView.animate(withDuration: 0.2) {
                    self.ImagesCollectionViewLayoutHeight.constant = 0
                    self.view.layoutIfNeeded()
                }
            }
            if self.CommignImages.count != 1{
                if XLanguage.get() == .Kurdish{
                    self.ImageCount.text = "وێنە (\(self.CommignImages.count))"
                    self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
                }else if XLanguage.get() == .English{
                    self.ImageCount.text = "IMAGES (\(self.CommignImages.count))"
                    self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
                }else{
                    self.ImageCount.text = "صور (\(self.CommignImages.count))"
                    self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
                }
            }else{
                if XLanguage.get() == .Kurdish{
                    self.ImageCount.text = "وێنە (\(self.CommignImages.count))"
                    self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
                }else if XLanguage.get() == .English{
                    self.ImageCount.text = "IMAGE (\(self.CommignImages.count))"
                    self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
                }else{
                    self.ImageCount.text = "صور (\(self.CommignImages.count))"
                    self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
                }
            }
            self.ImagesCollectionView.reloadData()
        }
    }

    
    
    
    
    var pleaseEnter = ""
    var chooseProject = ""
    func EmptyTextField(_ textfield : UITextField){
        if XLanguage.get() == .Kurdish{
            pleaseEnter = "تکایە داخڵ بکە"
            chooseProject = "تکایە پڕۆژەیەک بۆ موڵکەکەت هەڵبژێرە."
        }else if XLanguage.get() == .English{
            pleaseEnter = "Please Enter"
            chooseProject = "Please choose a project for your estate."
        }else{
            pleaseEnter = "من فضلك أدخل"
            chooseProject = "الرجاء اختيار مشروع لممتلكاتك."
        }
        
        var style = ToastStyle()
        style.messageColor = .white
        style.cornerRadius = 5
        style.backgroundColor = #colorLiteral(red: 1, green: 0.2541987598, blue: 0.2995160222, alpha: 1)
        style.messageFont = .systemFont(ofSize: 12, weight: .bold)
        self.view.makeToast("\(pleaseEnter) \(textfield.placeholder!).", duration: 2.2, position: .top, style: style)
        ToastManager.shared.isTapToDismissEnabled = true
        AudioServicesPlaySystemSound(1519);
        textfield.layer.borderColor = UIColor.red.cgColor;
        textfield.layer.borderWidth = 1.5 ;
        textfield.layer.cornerRadius = 5 ;
        textfield.clipsToBounds = false
        textfield.layer.shadowOpacity=0.4
        textfield.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    func EmptyLable(_ textfield : UILabel){
        if textfield == self.ProjectName{
            self.view.makeToast("Please choose project for your estate.", duration: 3.0, position: .top)
        }else{
            self.view.makeToast("\(pleaseEnter) \(textfield.text!).", duration: 3.0, position: .top)
        }
        ToastManager.shared.isTapToDismissEnabled = true
        AudioServicesPlaySystemSound(1519);
        textfield.layer.borderColor = UIColor.red.cgColor;
        textfield.layer.borderWidth = 1.5 ;
        textfield.layer.cornerRadius = 5 ;
        textfield.clipsToBounds = false
        textfield.layer.shadowOpacity=0.4
        textfield.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    func EmptyLatidute(_ button : UIButton){
        self.view.makeToast("\(pleaseEnter) \(ViewmapButton.titleLabel?.text ?? "").", duration: 3.0, position: .top)
        ToastManager.shared.isTapToDismissEnabled = true
        AudioServicesPlaySystemSound(1519);
        button.layer.backgroundColor =  UIColor.red.cgColor
        button.setTitleColor(UIColor.white, for: .normal)
    }
    
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if IsBecomeUpdated == true{
        if self.NewImages.count != 0{
            for image in self.NewImages{
                let imageUrl = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                if let range = imageUrl.range(of: "?") {
                    let ImageId = imageUrl.substring(to: range.lowerBound)
                    Task{
                        do{
                            try await Storage.storage().reference().child("Pictures").child(String(ImageId.suffix(36))).delete()
                        }catch {
                            print(error)
                        }
                    }
                }
            }
        }
        }
    }
    
    
    
    
    var titlee = ""
    var messagee = ""
    var updatetitlee = ""
    var updatemessagee = ""
    var Action = ""
    var cancell = ""
    
    
    var IsBecomeUpdated = false
    var lang : Int = UserDefaults.standard.integer(forKey: "language")
    var RealDirection = "S"
    @IBAction func Upload(_ sender: Any) {
        if CheckInternet.Connection(){
            UIView.animate(withDuration: 0.3) {
                self.InternetViewHeight.constant = 0
                self.InternetConnectionView.isHidden = true
                self.view.layoutIfNeeded()
            }
        AudioServicesPlaySystemSound(1519);
        self.Name.layer.borderWidth = 0
        self.Name.layer.shadowOpacity = 0
        self.Name.layer.shadowColor = UIColor.clear.cgColor
        self.Price.layer.borderWidth = 0
        self.Price.layer.shadowOpacity = 0
        self.Price.layer.shadowColor = UIColor.clear.cgColor
        self.Address.layer.borderWidth = 0
        self.Address.layer.shadowOpacity = 0
        self.Address.layer.shadowColor = UIColor.white.cgColor
        self.ViewmapButton.layer.backgroundColor =  UIColor.white.cgColor
        self.ViewmapButton.setTitleColor(#colorLiteral(red: 0.07023883611, green: 0.2064703405, blue: 0.3367385566, alpha: 1), for: .normal)
        self.AddressLable.layer.borderWidth = 0
        self.AddressLable.layer.shadowOpacity = 0
        self.AddressLable.layer.shadowColor = UIColor.clear.cgColor
        self.Space.layer.borderWidth = 0
        self.Space.layer.shadowOpacity = 0
        self.Space.layer.shadowColor = UIColor.clear.cgColor
        self.Furnished.layer.borderWidth = 0
        self.Furnished.layer.shadowOpacity = 0
        self.Furnished.layer.shadowColor = UIColor.clear.cgColor
        self.Floor.layer.borderWidth = 0
        self.Floor.layer.shadowOpacity = 0
        self.Floor.layer.shadowColor = UIColor.clear.cgColor
        self.Building.layer.borderWidth = 0
        self.Building.layer.shadowOpacity = 0
        self.Building.layer.shadowColor = UIColor.clear.cgColor
        self.Year.layer.borderWidth = 0
        self.Year.layer.shadowOpacity = 0
        self.Year.layer.shadowColor = UIColor.clear.cgColor
        self.MonthlyFee.layer.borderWidth = 0
        self.MonthlyFee.layer.shadowOpacity = 0
        self.MonthlyFee.layer.shadowColor = UIColor.clear.cgColor
        self.BondType.layer.borderWidth = 0
        self.BondType.layer.shadowOpacity = 0
        self.BondType.layer.shadowColor = UIColor.clear.cgColor
        self.PropertyNo.layer.borderWidth = 0
        self.PropertyNo.layer.shadowOpacity = 0
        self.PropertyNo.layer.shadowColor = UIColor.clear.cgColor
        
        if IsUpdate == false{
            guard self.Images.count != 0 else{
                AudioServicesPlaySystemSound(1519);
                if XLanguage.get() == .English{
                    let myAlert = UIAlertController(title: "تکایە لانیکەم یەک وێنە هەڵبژێرە.", message: nil, preferredStyle: UIAlertController.Style.alert)
                    myAlert.addAction(UIAlertAction(title: "بەڵێ", style: UIAlertAction.Style.cancel, handler: nil))
                    self.present(myAlert, animated: true, completion: nil)
                    return
                }else if XLanguage.get() == .Kurdish{
                    let myAlert = UIAlertController(title: "Please choose at least one image.", message: nil, preferredStyle: UIAlertController.Style.alert)
                    myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
                    self.present(myAlert, animated: true, completion: nil)
                    return
                }else{
                    let myAlert = UIAlertController(title: "الرجاء اختيار صورة واحدة على الأقل.", message: nil, preferredStyle: UIAlertController.Style.alert)
                    myAlert.addAction(UIAlertAction(title: "إلغاء", style: UIAlertAction.Style.cancel, handler: nil))
                    self.present(myAlert, animated: true, completion: nil)
                    return
                }
                
            }
        }
        guard self.Name.text!.isEmpty == false else{EmptyTextField(self.Name); return }
       
        guard self.Price.text!.isEmpty == false else{EmptyTextField(self.Price);return}
       
        guard self.Address.text!.isEmpty == false else{ EmptyTextField(self.Address); return}
       
        if XLanguage.get() == .English{
            guard self.LatLongAddress.text! != "LOCATION ( )" else{ EmptyLatidute(self.ViewmapButton); return}
        }else if XLanguage.get() == .Kurdish{
            guard self.LatLongAddress.text! != "شوێن ( )" else{ EmptyLatidute(self.ViewmapButton); return}
        }else{
            guard self.LatLongAddress.text! != "موقعك ( )" else{ EmptyLatidute(self.ViewmapButton); return}
        }
       
        guard self.AddressLable.text!.isEmpty == false else{EmptyLable(self.AddressLable); return}
       
        guard self.Space.text!.isEmpty == false else{EmptyTextField(self.Space); return}
        
        guard self.Furnished.text!.isEmpty == false else{EmptyTextField(self.Furnished); return}
        
        if self.IsApartment == true{
            guard self.Floor.text!.isEmpty == false else{EmptyTextField(self.Floor); return}
            
            guard self.Building.text!.isEmpty == false else{EmptyTextField(self.Building); return}
            
            guard self.MonthlyFee.text!.isEmpty == false else{EmptyTextField(self.MonthlyFee); return}
            
            guard self.ProjectName.text!.isEmpty == false else{EmptyLable(self.ProjectName); return}
        }
        
        guard self.BondType.text!.isEmpty == false else{EmptyTextField(self.BondType); return}
        
        guard self.Year.text!.isEmpty == false else{EmptyTextField(self.Year); return}
       
        guard self.PropertyNo.text!.isEmpty == false else{EmptyTextField(self.PropertyNo); return}
        
        if XLanguage.get() == .Kurdish{
            self.titlee = "بەرزکردنەوەی زانیاریەکان"
            self.updatetitlee = "زانیاری نوێکردنەوە"
            self.updatemessagee = "ئایا دڵنیای لە نوێکردنەوە؟"
            self.message = "ئایا دڵنیای لە نەرزکردنەوەی زانیاریەکان؟"
            self.Action = "بەڵێ"
            self.cancel = "نەخێر"
        }else if XLanguage.get() == . English{
            self.titlee = "Upload Information"
            self.message = "Are you sure to upload?"
            self.updatetitlee = "Update Information"
            self.updatemessagee = "Are you sure to update?"
            self.Action = "Yes"
            self.cancel = "No"
        }else{
            self.titlee = "رفع المعلومات"
            self.message = "هل أنت متأكد من رفع المعلومات؟"
            self.updatetitlee = "تحديث المعلومات"
            self.updatemessagee = "هل أنت متأكد من التحديث؟"
            self.Action = "نعم"
            self.cancel = "لا"
        }
        
        if IsUpdate == false{
            if let FireId = UserDefaults.standard.string(forKey: "UserId"){
                OfficeAip.GetOfficeById(Id: FireId) { office in
                    if office.name != ""{
                        let alertController = UIAlertController(title: self.titlee, message: self.messagee, preferredStyle: .alert)
                        let okAction = UIAlertAction(title:  self.Action, style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            self.uploadManyImage { URLs in
                                self.ImageUrl = URLs
                                print("444")
                                EstateObject.init(name: self.Name.text!
                                                  , id: UUID().uuidString
                                                  , stamp: Date().timeIntervalSince1970
                                                  , RentOrSell: "\(self.RentOrSell)"
                                                  , city_name: self.city
                                                  , address: self.Address.text!
                                                  , lat: self.lat
                                                  , long: self.long
                                                  , price: (self.Price.text!.convertedDigitsToLocale(Locale(identifier: "EN")) as NSString).doubleValue
                                                  , desc: self.Desc.text!
                                                  , office_id: office.id ?? ""
                                                  , fire_id: FireId
                                                  , ImageURL: self.ImageUrl
                                                  , city_id: self.CityId
                                                  , estate_type_id: self.selecteEstatedcell?.id ?? ""
                                                  , Direction: self.Direction
                                                  , floor: self.Floor.text!.convertedDigitsToLocale(Locale(identifier: "EN"))
                                                  , Building: self.Building.text!.convertedDigitsToLocale(Locale(identifier: "EN"))
                                                  , Year: self.Year.text!.convertedDigitsToLocale(Locale(identifier: "EN"))
                                                  , Furnished: self.SelectedFurnished
                                                  , bound_id: self.SelectedBoundTypeId
                                                  , MonthlyService: self.MonthlyFee.text!.convertedDigitsToLocale(Locale(identifier: "EN"))
                                                  , RoomNo:"\(self.selecteNumbercell)"
                                                  , WashNo: "\(self.selecteWashcell)"
                                                  , space: self.Space.text!.convertedDigitsToLocale(Locale(identifier: "EN"))
                                                  , propertyNo: self.PropertyNo.text!.convertedDigitsToLocale(Locale(identifier: "EN"))
                                                  , state: "0"
                                                  , project_id: self.ProjectId
                                                  , video_link: ""
                                                  , archived: "0"
                                                  , sold: "0").Upload()
                            }
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "EstateInserted"), object: nil)
                            self.navigationController?.popViewController(animated: true)
                        }
                        let cancelAction = UIAlertAction(title: self.cancel, style: UIAlertAction.Style.cancel) { UIAlertAction in }
                        alertController.addAction(okAction)
                        alertController.addAction(cancelAction)
                        self.present(alertController, animated: true, completion: nil)
                    }else{
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let myVC = storyboard.instantiateViewController(withIdentifier: "GoToRegisterVC") as! EditProfileVC
                        self.navigationController?.pushViewController(myVC, animated: true)
                    }
                }
            }
        }else{
            if let FireId = UserDefaults.standard.string(forKey: "UserId"){
                OfficeAip.GetOfficeById(Id: FireId) { office in
                    if office.name != ""{
                        
                        let alertController = UIAlertController(title: self.updatetitlee, message: self.updatemessagee, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: self.Action, style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            if self.removdImages.count != 0{
                                for image in self.removdImages{
                                    let imageUrl = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                                    if let range = imageUrl.range(of: "?") {
                                        let ImageId = imageUrl.substring(to: range.lowerBound)
                                        Task{
                                            do{
                                                try await Storage.storage().reference().child("Pictures").child(String(ImageId.suffix(36))).delete()
                                            }catch{
                                                print(error)
                                            }
                                        }
                                       
                                    }
                                }
                            }
                            self.IsBecomeUpdated = true
                            EstateObject.init(name: self.Name.text!
                                              , id: self.estate_id
                                              , stamp: Date().timeIntervalSince1970
                                              , RentOrSell: "\(self.RentOrSell)"
                                              , city_name: self.city
                                              , address: self.Address.text!
                                              , lat: self.lat
                                              , long: self.long
                                              , price: (self.Price.text!.convertedDigitsToLocale(Locale(identifier: "EN")) as NSString).doubleValue
                                              , desc: self.Desc.text!
                                              , office_id: office.id ?? ""
                                              , fire_id: FireId
                                              , ImageURL: self.CommignImages
                                              , city_id: self.CityId
                                              , estate_type_id: self.selecteEstatedcell?.id ?? ""
                                              , Direction: self.Direction
                                              , floor: self.Floor.text!.convertedDigitsToLocale(Locale(identifier: "EN"))
                                              , Building: self.Building.text!.convertedDigitsToLocale(Locale(identifier: "EN"))
                                              , Year: self.Year.text!.convertedDigitsToLocale(Locale(identifier: "EN"))
                                              , Furnished: self.SelectedFurnished
                                              , bound_id: self.SelectedBoundTypeId
                                              , MonthlyService: self.MonthlyFee.text!.convertedDigitsToLocale(Locale(identifier: "EN"))
                                              , RoomNo:"\(self.selecteNumbercell)"
                                              , WashNo: "\(self.selecteWashcell)"
                                              , space: self.Space.text!.convertedDigitsToLocale(Locale(identifier: "EN"))
                                              , propertyNo: self.PropertyNo.text!.convertedDigitsToLocale(Locale(identifier: "EN"))
                                              , state: "0"
                                              , project_id: self.ProjectId
                                              , video_link: ""
                                              , archived: "0"
                                              , sold: "0").Update()
                            
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "EstateInserted"), object: nil)
                            self.navigationController?.popViewController(animated: true)
                        }
                        let cancelAction = UIAlertAction(title: self.cancel, style: UIAlertAction.Style.cancel) { UIAlertAction in }
                        alertController.addAction(okAction)
                        alertController.addAction(cancelAction)
                        self.present(alertController, animated: true, completion: nil)
                    }else{
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let myVC = storyboard.instantiateViewController(withIdentifier: "GoToRegisterVC") as! EditProfileVC
                        self.navigationController?.pushViewController(myVC, animated: true)
                    }
                }
            }
        }
        }else{
            UIView.animate(withDuration: 0.3) {
                self.InternetViewHeight.constant = 20
                self.InternetConnectionView.isHidden = false
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    

    
    
    
}


extension AddProperty : UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if collectionView == self.NumberOfRoomsCollectionView{
            if NumberOfRooms.count == 0 {
                return 0
            }else{
                return NumberOfRooms.count
            }
        }
        if collectionView == self.NumberOfWashRoomsCollectionView{
            if NumberOfWashRooms.count == 0 {
                return 0
            }else{
                return NumberOfWashRooms.count
            }
        }
        if collectionView == ImagesCollectionView{
            if IsUpdate == false{
                if Images.count == 0 {
                    self.ImagesCollectionViewLayoutHeight.constant = 0
                    self.view.layoutIfNeeded()
                    return 0
                }else{
                    return Images.count
                }
            }else{
                if CommignImages.count == 0 {
                    self.ImagesCollectionViewLayoutHeight.constant = 0
                    self.view.layoutIfNeeded()
                    return 0
                }else{
                    return CommignImages.count
                }
            }
        }
        
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.NumberOfRoomsCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NCell", for: indexPath) as! EstateTypeCollectionViewCell
            if self.NumberOfRooms.count != 0{
                cell.Name.text = "\(NumberOfRooms[indexPath.row])"
                if self.selecteNumbercell == 0 && indexPath.row == 3{
                    cell.Vieww.backgroundColor = #colorLiteral(red: 0, green: 0.6025940776, blue: 0.9986988902, alpha: 1)
                    cell.Name.textColor = .white
                    self.selecteNumbercell = indexPath.row
                }else{
                    if self.selecteNumbercell == NumberOfRooms[indexPath.row]{
                        UIView.animate(withDuration: 0.3) {
                            cell.Vieww.backgroundColor = #colorLiteral(red: 0, green: 0.6025940776, blue: 0.9986988902, alpha: 1)
                            cell.Name.textColor = .white
                        }
                    }else{
                        cell.Vieww.backgroundColor = .white
                        cell.Name.textColor = #colorLiteral(red: 0.4430069923, green: 0.4869378209, blue: 0.5339931846, alpha: 1)
                    }
                }
            }
            return cell
        }
        
        
        
        if collectionView == self.NumberOfWashRoomsCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NWCell", for: indexPath) as! EstateTypeCollectionViewCell
            if self.NumberOfWashRooms.count != 0{
                cell.Name.text = "\(NumberOfWashRooms[indexPath.row])"
                if self.selecteWashcell == 0 && indexPath.row == 2{
                    cell.Vieww.backgroundColor = #colorLiteral(red: 0, green: 0.6025940776, blue: 0.9986988902, alpha: 1)
                    cell.Name.textColor = .white
                    self.selecteWashcell = indexPath.row
                }else{
                    if self.selecteWashcell == NumberOfWashRooms[indexPath.row]{
                        UIView.animate(withDuration: 0.3) {
                            cell.Vieww.backgroundColor = #colorLiteral(red: 0, green: 0.6025940776, blue: 0.9986988902, alpha: 1)
                            cell.Name.textColor = .white
                        }
                    }else{
                        cell.Vieww.backgroundColor = .white
                        cell.Name.textColor = #colorLiteral(red: 0.4430069923, green: 0.4869378209, blue: 0.5339931846, alpha: 1)
                    }
                }
            }
            return cell
        }
        
        
        
        if collectionView == ImagesCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ExpImagesCollectionViewCell
            if IsUpdate == false{
                cell.Delete.accessibilityIdentifier = "\(indexPath.row)"
                cell.Delete.addTarget(self, action: #selector(self.remove(sender:)), for:.touchUpInside)
                cell.Imagee.image = self.Images[indexPath.row]
                return cell
            }else{
                cell.Delete.accessibilityIdentifier = "\(indexPath.row)"
                cell.Delete.accessibilityValue = CommignImages[indexPath.row]
                cell.Delete.addTarget(self, action: #selector(self.remove(sender:)), for:.touchUpInside)
                let url = URL(string: CommignImages[indexPath.row])
                cell.Imagee.sd_setImage(with: url, completed: nil)
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        

        if collectionView == ImagesCollectionView{
        return CGSize(width: collectionView.frame.size.width / 4, height: 150)
        }
        
        if collectionView == self.NumberOfRoomsCollectionView || collectionView == self.NumberOfWashRoomsCollectionView {
            return CGSize(width: collectionView.frame.size.width / 7, height: 45)
        }
        
        return CGSize()
        
     }

    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 5
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
        if collectionView == self.NumberOfRoomsCollectionView{
            if self.NumberOfRooms.count != 0  && indexPath.row <= self.NumberOfRooms.count{
                self.NumberOfRoom = NumberOfRooms[indexPath.row]
                self.selecteNumbercell = self.NumberOfRooms[indexPath.row]
                self.NumberOfRoomsCollectionView.reloadData()
            }
        }
        
        if collectionView == self.NumberOfWashRoomsCollectionView{
            if self.NumberOfWashRooms.count != 0  && indexPath.row <= self.NumberOfWashRooms.count{
                self.NumberOfWashRoom = NumberOfWashRooms[indexPath.row]
                self.selecteWashcell = self.NumberOfWashRooms[indexPath.row]
                self.NumberOfWashRoomsCollectionView.reloadData()
            }
        }
    }
    
}

