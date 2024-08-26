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
                    pickerLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
                    pickerLabel?.text = self.ProjectArray[row].project_name

            }
            
            if pickerView == EstateTypepickerView{
                    pickerLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
                    pickerLabel?.text = self.EstatesType[row].name
            }
            
            if pickerView == TypepickerView{
                    pickerLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
                    pickerLabel?.text = self.typees[row].name
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
        if textField == self.Furnished {
            self.view.endEditing(true)

            
            
            switch XLanguage.get() {
            case .English:
                dropDown.dataSource = ["Furnished", "Not Furnished"]
            case .Dutch:
                dropDown.dataSource = ["Gemeubileerd", "Niet gemeubileerd"]
            case .Arabic:
                dropDown.dataSource = ["مفروشة", "غير مفروشة"]
            case .Kurdish:
                dropDown.dataSource = ["مۆبیلیات کراوە", "مۆبیلیات نییە"]
            case .French:
                dropDown.dataSource = ["Meublé", "Non meublé"]
            case .Spanish:
                dropDown.dataSource = ["Amueblado", "No amueblado"]
            case .German:
                dropDown.dataSource = ["Möbliert", "Unmöbliert"]
            case .Hebrew:
                dropDown.dataSource = ["מרוהט", "לא מרוהט"]
            case .Chinese:
                dropDown.dataSource = ["配有家具", "无家具"]
            case .Hindi:
                dropDown.dataSource = ["सुसज्जित", "असुसज्जित"]
            case .Portuguese:
                dropDown.dataSource = ["Mobiliado", "Não Mobiliado"]
            case .Swedish:
                dropDown.dataSource = ["Möblerad", "Omöblerad"]
            case .Greek:
                dropDown.dataSource = ["Επιπλωμένο", "Μη επιπλωμένο"]
            case .Russian:
                dropDown.dataSource = ["Меблированная", "Немеблированная"]
            default:
                dropDown.dataSource = ["Furnished", "Not Furnished"]
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
        
        
        

        let language = XLanguage.get()
        let titles = [
            "English": ("RENT", "SELL"),
            "Dutch": ("HUREN", "VERKOPEN"),
            "French": ("LOUER", "VENDRE"),
            "Spanish": ("ALQUILAR", "VENDER"),
            "German": ("MIETEN", "VERKAUFEN"),
            "Hebrew": ("להשכיר", "למכור"),
            "Chinese": ("租", "卖"),
            "Hindi": ("किराये पर लें", "बेचें"),
            "Portuguese": ("ALUGAR", "VENDER"),
            "Swedish": ("HYRA", "SÄLJA"),
            "Greek": ("ΕΝΟΙΚΙΑΣΗ", "ΠΩΛΗΣΗ"),
            "Russian": ("АРЕНДА", "ПРОДАЖА"),
            "Kurdish": ("کرێ", "فروشتن"),
            "Arabic": ("بیع", "ايجار")
        ]

        if let (rentTitle, sellTitle) = titles[language.rawValue] {
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 16)!, .foregroundColor: UIColor(red: 0.076, green: 0.227, blue: 0.355, alpha: 1)]
            self.RentRadioButton.setTitle(rentTitle, for: .normal)
            self.SellRadioButton.setTitle(sellTitle, for: .normal)
            if XLanguage.get() == .Kurdish{
                self.RentRadioButton.titleLabel?.font = UIFont(name: "PeshangDes2", size: 12)!
                self.SellRadioButton.titleLabel?.font = UIFont(name: "PeshangDes2", size: 12)!
            }else if XLanguage.get() == .Arabic{
                self.RentRadioButton.titleLabel?.font = UIFont(name: "PeshangDes2", size: 12)!
                self.SellRadioButton.titleLabel?.font = UIFont(name: "PeshangDes2", size: 12)!
            }else{
                self.RentRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
                self.SellRadioButton.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            }
           
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
        
        if XLanguage.get() == .English{
            self.ImageCount.text = "IMAGES (\(self.CommignImages.count))"
            self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        }else if XLanguage.get() == .Kurdish{
            self.ImageCount.text = "وێنە (\(self.Images.count))"
            self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
        }else if XLanguage.get() == .Arabic{
            self.ImageCount.text = "صور (\(self.Images.count))"
            self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
        }else if XLanguage.get() == .Dutch {
            self.ImageCount.text = "AFBEELDINGEN (\(self.Images.count))"
            self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .French {
            self.ImageCount.text = "IMAGES (\(self.Images.count))"
            self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .Spanish {
            self.ImageCount.text = "IMÁGENES (\(self.Images.count))"
            self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .German {
            self.ImageCount.text = "BILDER (\(self.Images.count))"
            self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .Hebrew {
            self.ImageCount.text = "תמונות (\(self.Images.count))"
            self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .Chinese {
            self.ImageCount.text = "图片 (\(self.Images.count))"
            self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .Hindi {
            self.ImageCount.text = "छवियाँ (\(self.Images.count))"
            self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .Portuguese {
            self.ImageCount.text = "IMAGENS (\(self.Images.count))"
            self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .Swedish {
            self.ImageCount.text = "BILDER (\(self.Images.count))"
            self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .Greek {
            self.ImageCount.text = "ΕΙΚΟΝΕΣ (\(self.Images.count))"
            self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .Russian {
            self.ImageCount.text = "ИЗОБРАЖЕНИЯ (\(self.Images.count))"
            self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        }
        
        if XLanguage.get() == .Arabic{
            self.LatLongAddress.text = "الموقع ()"
            self.LatLongAddress.font = UIFont(name: "PeshangDes2", size: 12)!
        }else if XLanguage.get() == .Kurdish{
            self.LatLongAddress.text = "شوێن ()"
            self.LatLongAddress.font = UIFont(name: "PeshangDes2", size: 12)!
        }else if XLanguage.get() == .English {
            self.LatLongAddress.text = "LOCATION ()"
            self.LatLongAddress.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .Dutch {
            self.LatLongAddress.text = "LOCATIE ()"
            self.LatLongAddress.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .French {
            self.LatLongAddress.text = "EMPLACEMENT ()"
            self.LatLongAddress.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .Spanish {
            self.LatLongAddress.text = "UBICACIÓN ()"
            self.LatLongAddress.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .German {
            self.LatLongAddress.text = "STANDORT ()"
            self.LatLongAddress.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .Hebrew {
            self.LatLongAddress.text = "מיקום ()"
            self.LatLongAddress.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .Chinese {
            self.LatLongAddress.text = "位置 ()"
            self.LatLongAddress.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .Hindi {
            self.LatLongAddress.text = "स्थान ()"
            self.LatLongAddress.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .Portuguese {
            self.LatLongAddress.text = "LOCALIZAÇÃO ()"
            self.LatLongAddress.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .Swedish {
            self.LatLongAddress.text = "PLATS ()"
            self.LatLongAddress.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .Greek {
            self.LatLongAddress.text = "ΤΟΠΟΘΕΣΙΑ ()"
            self.LatLongAddress.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
        } else if XLanguage.get() == .Russian {
            self.LatLongAddress.text = "МЕСТОПОЛОЖЕНИЕ ()"
            self.LatLongAddress.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
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
            if XLanguage.get() == .English{
                self.ImageCount.text = "IMAGES (\(self.CommignImages.count))"
                self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            }else if XLanguage.get() == .Kurdish{
                self.ImageCount.text = "وێنە (\(self.Images.count))"
                self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
            }else if XLanguage.get() == .Arabic{
                self.ImageCount.text = "صور (\(self.Images.count))"
                self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
            }else if XLanguage.get() == .Dutch {
                self.ImageCount.text = "AFBEELDINGEN (\(self.Images.count))"
                self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            } else if XLanguage.get() == .French {
                self.ImageCount.text = "IMAGES (\(self.Images.count))"
                self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            } else if XLanguage.get() == .Spanish {
                self.ImageCount.text = "IMÁGENES (\(self.Images.count))"
                self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            } else if XLanguage.get() == .German {
                self.ImageCount.text = "BILDER (\(self.Images.count))"
                self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            } else if XLanguage.get() == .Hebrew {
                self.ImageCount.text = "תמונות (\(self.Images.count))"
                self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            } else if XLanguage.get() == .Chinese {
                self.ImageCount.text = "图片 (\(self.Images.count))"
                self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            } else if XLanguage.get() == .Hindi {
                self.ImageCount.text = "छवियाँ (\(self.Images.count))"
                self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            } else if XLanguage.get() == .Portuguese {
                self.ImageCount.text = "IMAGENS (\(self.Images.count))"
                self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            } else if XLanguage.get() == .Swedish {
                self.ImageCount.text = "BILDER (\(self.Images.count))"
                self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            } else if XLanguage.get() == .Greek {
                self.ImageCount.text = "ΕΙΚΟΝΕΣ (\(self.Images.count))"
                self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
            } else if XLanguage.get() == .Russian {
                self.ImageCount.text = "ИЗОБРАЖЕНИЯ (\(self.Images.count))"
                self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
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
            
           if XLanguage.get() == .Arabic{
                self.LatLongAddress.text = "الموقع (\(self.lat), \(self.long))"
            }else if XLanguage.get() == .Kurdish{
                self.LatLongAddress.text = "شوێن (\(self.lat), \(self.long))"
            }else if XLanguage.get() == .English {
                self.LatLongAddress.text = "LOCATION (\(self.lat), \(self.long))"
            } else if XLanguage.get() == .Dutch {
                self.LatLongAddress.text = "LOCATIE (\(self.lat), \(self.long))"
            } else if XLanguage.get() == .French {
                self.LatLongAddress.text = "EMPLACEMENT (\(self.lat), \(self.long))"
            } else if XLanguage.get() == .Spanish {
                self.LatLongAddress.text = "UBICACIÓN (\(self.lat), \(self.long))"
            } else if XLanguage.get() == .German {
                self.LatLongAddress.text = "STANDORT (\(self.lat), \(self.long))"
            } else if XLanguage.get() == .Hebrew {
                self.LatLongAddress.text = "מיקום (\(self.lat), \(self.long))"
            } else if XLanguage.get() == .Chinese {
                self.LatLongAddress.text = "位置 (\(self.lat), \(self.long))"
            } else if XLanguage.get() == .Hindi {
                self.LatLongAddress.text = "स्थान (\(self.lat), \(self.long))"
            } else if XLanguage.get() == .Portuguese {
                self.LatLongAddress.text = "LOCALIZAÇÃO (\(self.lat), \(self.long))"
            } else if XLanguage.get() == .Swedish {
                self.LatLongAddress.text = "PLATS (\(self.lat), \(self.long))"
            } else if XLanguage.get() == .Greek {
                self.LatLongAddress.text = "ΤΟΠΟΘΕΣΙΑ (\(self.lat), \(self.long))"
            } else if XLanguage.get() == .Russian {
                self.LatLongAddress.text = "МЕСТОПОЛОЖЕНИЕ (\(self.lat), \(self.long))"
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
            
            
            
            if data.Furnished == "0" && XLanguage.get() == .Hebrew{
                self.Furnished.text = "מרוהט"
                self.SelectedFurnished = "0"
            }else if data.Furnished == "1" && XLanguage.get() == .Hebrew{
                self.Furnished.text = "לא מרוהט"
                self.SelectedFurnished = "1"
            }
            if data.Furnished == "0" && XLanguage.get() == .Chinese{
                self.Furnished.text = "家具"
                self.SelectedFurnished = "0"
            }else if data.Furnished == "1" && XLanguage.get() == .Chinese{
                self.Furnished.text = "没有家具"
                self.SelectedFurnished = "1"
            }
            
            if data.Furnished == "0" && XLanguage.get() == .Hindi{
                self.Furnished.text = "सुसज्जित"
                self.SelectedFurnished = "0"
            }else if data.Furnished == "1" && XLanguage.get() == .Hindi{
                self.Furnished.text = "असुसज्जित"
                self.SelectedFurnished = "1"
            }
            
            
            if data.Furnished == "0" && XLanguage.get() == .Portuguese{
                self.Furnished.text = "Mobiliado"
                self.SelectedFurnished = "0"
            }else if data.Furnished == "1" && XLanguage.get() == .Portuguese{
                self.Furnished.text = "Não Mobiliado"
                self.SelectedFurnished = "1"
            }
            
            
            if data.Furnished == "0" && XLanguage.get() == .Swedish{
                self.Furnished.text = "Möblerad"
                self.SelectedFurnished = "0"
            }else if data.Furnished == "1" && XLanguage.get() == .Swedish{
                self.Furnished.text = "Omöblerad"
                self.SelectedFurnished = "1"
            }
            
            
            if data.Furnished == "0" && XLanguage.get() == .Greek{
                self.Furnished.text = "Επιπλωμένο"
                self.SelectedFurnished = "0"
            }else if data.Furnished == "1" && XLanguage.get() == .Greek{
                self.Furnished.text = "Μη επιπλωμένο"
                self.SelectedFurnished = "1"
            }
            
            if data.Furnished == "0" && XLanguage.get() == .Russian{
                self.Furnished.text = "Меблированная"
                self.SelectedFurnished = "0"
            }else if data.Furnished == "1" && XLanguage.get() == .Russian{
                self.Furnished.text = "Немеблированная"
                self.SelectedFurnished = "1"
            }
            
            if data.Furnished == "0" && XLanguage.get() == .Dutch{
                self.Furnished.text = "Gemeubileerd"
                self.SelectedFurnished = "0"
            }else if data.Furnished == "1" && XLanguage.get() == .Dutch{
                self.Furnished.text = "Niet gemeubileerd"
                self.SelectedFurnished = "1"
            }
            
            if data.Furnished == "0" && XLanguage.get() == .French{
                self.Furnished.text = "Meublé"
                self.SelectedFurnished = "0"
            }else if data.Furnished == "1" && XLanguage.get() == .French{
                self.Furnished.text = "Non meublé"
                self.SelectedFurnished = "1"
            }
            
            if data.Furnished == "0" && XLanguage.get() == .Spanish{
                self.Furnished.text = "Amueblado"
                self.SelectedFurnished = "0"
            }else if data.Furnished == "1" && XLanguage.get() == .Spanish{
                self.Furnished.text = "Sin amueblar"
                self.SelectedFurnished = "1"
            }
            
            if data.Furnished == "0" && XLanguage.get() == .German{
                self.Furnished.text = "Möbliert"
                self.SelectedFurnished = "0"
            }else if data.Furnished == "1" && XLanguage.get() == .German{
                self.Furnished.text = "Unmöbliert"
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
            
            EstateTypeAip.GeEstateTypeNameById(id: data.estate_type_id ?? "") { estatetype in
            self.EstateTypeLable.text = estatetype.name
            self.EstateTypeLable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
            

            }
            
            
            self.TypeId = data.type_id ?? ""
            TypesObjectAip.GetTypeById(id: data.type_id ?? "") { type in
                    self.Typelable.text = type.name
                    self.Typelable.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
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
                GetAllProjectsAip.GetProjectById(ID: data.project_id ?? "") { project in
                        self.ProjectName.text = project.project_name
                        self.ProjectName.font = UIFont(name: "ArialRoundedMTBold", size: 11)!
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
        setupTypesAlert()
        }
    }
    
    var IsPickerSelected = ""
    var TypepickerView = UIPickerView(frame: CGRect(x: 10, y: 50, width: 250, height: 150))
    var TypeId = ""
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
        }else if XLanguage.get() == .Arabic{
            self.ProjectsTitle   = "اختر نوع"
            self.ProjectsAction  = "تحديد"
            self.ProjectsCancel  = "إلغاء"
        }else if XLanguage.get() == .Dutch {
            self.ProjectsTitle = "Kies een Type"
            self.ProjectsAction = "Selecteer"
            self.ProjectsCancel = "Annuleren"
        } else if XLanguage.get() == .French {
            self.ProjectsTitle = "Choisissez un Type"
            self.ProjectsAction = "Sélectionner"
            self.ProjectsCancel = "Annuler"
        } else if XLanguage.get() == .Spanish {
            self.ProjectsTitle = "Elija un Tipo"
            self.ProjectsAction = "Seleccionar"
            self.ProjectsCancel = "Cancelar"
        } else if XLanguage.get() == .German {
            self.ProjectsTitle = "Wählen Sie einen Typ"
            self.ProjectsAction = "Auswählen"
            self.ProjectsCancel = "Abbrechen"
        } else if XLanguage.get() == .Hebrew {
            self.ProjectsTitle = "בחר סוג"
            self.ProjectsAction = "בחר"
            self.ProjectsCancel = "ביטול"
        } else if XLanguage.get() == .Chinese {
            self.ProjectsTitle = "选择类型"
            self.ProjectsAction = "选择"
            self.ProjectsCancel = "取消"
        } else if XLanguage.get() == .Hindi {
            self.ProjectsTitle = "एक प्रकार चुनें"
            self.ProjectsAction = "चुनें"
            self.ProjectsCancel = "रद्द करें"
        } else if XLanguage.get() == .Portuguese {
            self.ProjectsTitle = "Escolha um Tipo"
            self.ProjectsAction = "Selecionar"
            self.ProjectsCancel = "Cancelar"
        } else if XLanguage.get() == .Swedish {
            self.ProjectsTitle = "Välj en Typ"
            self.ProjectsAction = "Välj"
            self.ProjectsCancel = "Avbryt"
        } else if XLanguage.get() == .Greek {
            self.ProjectsTitle = "Επιλέξτε Τύπο"
            self.ProjectsAction = "Επιλέξτε"
            self.ProjectsCancel = "Ακύρωση"
        } else if XLanguage.get() == .Russian {
            self.ProjectsTitle = "Выберите Тип"
            self.ProjectsAction = "Выбрать"
            self.ProjectsCancel = "Отмена"
        }
        let ac = UIAlertController(title:  self.ProjectsTitle, message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        ac.view.addSubview(TypepickerView)
        ac.addAction(UIAlertAction(title:  self.ProjectsAction, style: .default, handler: { _ in
            if self.typees.count != 0{
            let pickerValue = self.typees[self.TypepickerView.selectedRow(inComponent: 0)]
            self.Typelable.text = pickerValue.name
            self.Typelable.font = UIFont(name: "ArialRoundedMTBold", size: 12)!
           
            self.TypeId = pickerValue.id ?? ""
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
        setupEstateTypesAlert()
        }
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
        }else if XLanguage.get() == .Arabic{
            self.ProjectsTitle = "اختر نوع العقار"
            self.ProjectsAction  = "تحديد"
            self.ProjectsCancel  = "إلغاء"
        }else if XLanguage.get() == .Dutch {
            self.ProjectsTitle = "Kies Soort Eigendom"
            self.ProjectsAction = "Selecteren"
            self.ProjectsCancel = "Annuleren"
        } else if XLanguage.get() == .French {
            self.ProjectsTitle = "Choisir le Type de Bien"
            self.ProjectsAction = "Sélectionner"
            self.ProjectsCancel = "Annuler"
        } else if XLanguage.get() == .Spanish {
            self.ProjectsTitle = "Elegir Tipo de Propiedad"
            self.ProjectsAction = "Seleccionar"
            self.ProjectsCancel = "Cancelar"
        } else if XLanguage.get() == .German {
            self.ProjectsTitle = "Immobilientyp Wählen"
            self.ProjectsAction = "Auswählen"
            self.ProjectsCancel = "Abbrechen"
        } else if XLanguage.get() == .Hebrew {
            self.ProjectsTitle = "בחר סוג נכס"
            self.ProjectsAction = "בחר"
            self.ProjectsCancel = "בטל"
        } else if XLanguage.get() == .Chinese {
            self.ProjectsTitle = "选择房产类型"
            self.ProjectsAction = "选择"
            self.ProjectsCancel = "取消"
        } else if XLanguage.get() == .Hindi {
            self.ProjectsTitle = "एस्टेट प्रकार चुनें"
            self.ProjectsAction = "चुनें"
            self.ProjectsCancel = "रद्द करें"
        } else if XLanguage.get() == .Portuguese {
            self.ProjectsTitle = "Escolher Tipo de Propriedade"
            self.ProjectsAction = "Selecionar"
            self.ProjectsCancel = "Cancelar"
        } else if XLanguage.get() == .Swedish {
            self.ProjectsTitle = "Välj Fastighetstyp"
            self.ProjectsAction = "Välj"
            self.ProjectsCancel = "Avbryt"
        } else if XLanguage.get() == .Greek {
            self.ProjectsTitle = "Επιλέξτε Τύπο Ακινήτου"
            self.ProjectsAction = "Επιλογή"
            self.ProjectsCancel = "Ακύρωση"
        } else if XLanguage.get() == .Russian {
            self.ProjectsTitle = "Выберите Тип Недвижимости"
            self.ProjectsAction = "Выбрать"
            self.ProjectsCancel = "Отмена"
        }
        let ac = UIAlertController(title:  self.ProjectsTitle, message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        ac.view.addSubview(EstateTypepickerView)
        ac.addAction(UIAlertAction(title:  self.ProjectsAction, style: .default, handler: { _ in
            if self.EstatesType.count != 0{
            let pickerValue = self.EstatesType[self.EstateTypepickerView.selectedRow(inComponent: 0)]

            self.EstateTypeLable.text = pickerValue.name
            self.EstateTypeLable.font = UIFont(name: "ArialRoundedMTBold", size: 12)!

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
    
                if XLanguage.get() == .Arabic{
                    self.LatLongAddress.text = "الموقع (\(String(arrLat[0..<8])), \(String(arrLong[0..<8])))"
                }else if XLanguage.get() == .Kurdish{
                    self.LatLongAddress.text = "شوێن (\(String(arrLat[0..<8])), \(String(arrLong[0..<8])))"
                }else if XLanguage.get() == .English {
                    self.LatLongAddress.text = "LOCATION (\(String(arrLat[0..<8])), \(String(arrLong[0..<8])))"
                } else if XLanguage.get() == .Dutch {
                    self.LatLongAddress.text = "LOCATIE (\(String(arrLat[0..<8])), \(String(arrLong[0..<8])))"
                } else if XLanguage.get() == .French {
                    self.LatLongAddress.text = "EMPLACEMENT (\(String(arrLat[0..<8])), \(String(arrLong[0..<8])))"
                } else if XLanguage.get() == .Spanish {
                    self.LatLongAddress.text = "UBICACIÓN (\(String(arrLat[0..<8])), \(String(arrLong[0..<8])))"
                } else if XLanguage.get() == .German {
                    self.LatLongAddress.text = "STANDORT (\(String(arrLat[0..<8])), \(String(arrLong[0..<8])))"
                } else if XLanguage.get() == .Hebrew {
                    self.LatLongAddress.text = "מיקום (\(String(arrLat[0..<8])), \(String(arrLong[0..<8])))"
                } else if XLanguage.get() == .Chinese {
                    self.LatLongAddress.text = "位置 (\(String(arrLat[0..<8])), \(String(arrLong[0..<8])))"
                } else if XLanguage.get() == .Hindi {
                    self.LatLongAddress.text = "स्थान (\(String(arrLat[0..<8])), \(String(arrLong[0..<8])))"
                } else if XLanguage.get() == .Portuguese {
                    self.LatLongAddress.text = "LOCALIZAÇÃO (\(String(arrLat[0..<8])), \(String(arrLong[0..<8])))"
                } else if XLanguage.get() == .Swedish {
                    self.LatLongAddress.text = "PLATS (\(String(arrLat[0..<8])), \(String(arrLong[0..<8])))"
                } else if XLanguage.get() == .Greek {
                    self.LatLongAddress.text = "ΤΟΠΟΘΕΣΙΑ (\(String(arrLat[0..<8])), \(String(arrLong[0..<8])))"
                } else if XLanguage.get() == .Russian {
                    self.LatLongAddress.text = "МЕСТОПОЛОЖЕНИЕ (\(String(arrLat[0..<8])), \(String(arrLong[0..<8])))"
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
        setupProjectSelectionAlert()
        }
    }
    
    
    var ProjectArray : [ProjectObject] = []
    var ProjectsTitle = ""
    var ProjectsAction = ""
    var ProjectsCancel = ""
    private func setupProjectSelectionAlert() {
        ProjectpickerView.delegate = self
        ProjectpickerView.dataSource = self
        IsPickerSelected = "3"
        if XLanguage.get() == .Kurdish{
            self.ProjectsTitle = "پرۆژە هەڵبژێرە"
            self.ProjectsAction  = "هەڵبژێرە"
            self.ProjectsCancel  = "هەڵوەشاندنەوە"
        }else if XLanguage.get() == .Arabic{
            self.ProjectsTitle = "اختر المشروع"
            self.ProjectsAction = "تحديد"
            self.ProjectsCancel = "إلغاء"
        }else if XLanguage.get() == .English {
            self.ProjectsTitle = "Choose project"
            self.ProjectsAction = "Select"
            self.ProjectsCancel = "Cancel"
        } else if XLanguage.get() == .Dutch {
            self.ProjectsTitle = "Kies project"
            self.ProjectsAction = "Selecteren"
            self.ProjectsCancel = "Annuleren"
        } else if XLanguage.get() == .French {
            self.ProjectsTitle = "Choisir le projet"
            self.ProjectsAction = "Sélectionner"
            self.ProjectsCancel = "Annuler"
        } else if XLanguage.get() == .Spanish {
            self.ProjectsTitle = "Elegir proyecto"
            self.ProjectsAction = "Seleccionar"
            self.ProjectsCancel = "Cancelar"
        } else if XLanguage.get() == .German {
            self.ProjectsTitle = "Projekt wählen"
            self.ProjectsAction = "Auswählen"
            self.ProjectsCancel = "Abbrechen"
        } else if XLanguage.get() == .Hebrew {
            self.ProjectsTitle = "בחר פרויקט"
            self.ProjectsAction = "בחר"
            self.ProjectsCancel = "ביטול"
        } else if XLanguage.get() == .Chinese {
            self.ProjectsTitle = "选择项目"
            self.ProjectsAction = "选择"
            self.ProjectsCancel = "取消"
        } else if XLanguage.get() == .Hindi {
            self.ProjectsTitle = "प्रोजेक्ट चुनें"
            self.ProjectsAction = "चुनें"
            self.ProjectsCancel = "रद्द करें"
        } else if XLanguage.get() == .Portuguese {
            self.ProjectsTitle = "Escolher projeto"
            self.ProjectsAction = "Selecionar"
            self.ProjectsCancel = "Cancelar"
        } else if XLanguage.get() == .Swedish {
            self.ProjectsTitle = "Välj projekt"
            self.ProjectsAction = "Välj"
            self.ProjectsCancel = "Avbryt"
        } else if XLanguage.get() == .Greek {
            self.ProjectsTitle = "Επιλέξτε έργο"
            self.ProjectsAction = "Επιλογή"
            self.ProjectsCancel = "Ακύρωση"
        } else if XLanguage.get() == .Russian {
            self.ProjectsTitle = "Выбрать проект"
            self.ProjectsAction = "Выбрать"
            self.ProjectsCancel = "Отмена"
        }
        
        let ac = UIAlertController(title: self.ProjectsTitle, message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        ac.view.addSubview(ProjectpickerView)
        ac.addAction(UIAlertAction(title: self.ProjectsAction, style: .default, handler: { _ in
            if self.ProjectArray.count != 0{
                let pickerValue = self.ProjectArray[self.ProjectpickerView.selectedRow(inComponent: 0)]
                    self.ProjectName.text = pickerValue.project_name
                    self.ProjectName.font = UIFont(name: "PeshangDes2", size: 12)!

                    
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
        }else if XLanguage.get() == .Arabic{
            self.loadingLableMessage = "يرجى الانتظار..."
        }else if XLanguage.get() == .English {
            self.loadingLableMessage = "Please wait..."
        } else if XLanguage.get() == .Dutch {
            self.loadingLableMessage = "Even wachten alstublieft..."
        } else if XLanguage.get() == .French {
            self.loadingLableMessage = "Veuillez patienter..."
        } else if XLanguage.get() == .Spanish {
            self.loadingLableMessage = "Por favor, espere..."
        } else if XLanguage.get() == .German {
            self.loadingLableMessage = "Bitte warten..."
        } else if XLanguage.get() == .Hebrew {
            self.loadingLableMessage = "אנא המתן..."
        } else if XLanguage.get() == .Chinese {
            self.loadingLableMessage = "请稍候..."
        } else if XLanguage.get() == .Hindi {
            self.loadingLableMessage = "कृपया प्रतीक्षा करें..."
        } else if XLanguage.get() == .Portuguese {
            self.loadingLableMessage = "Por favor, aguarde..."
        } else if XLanguage.get() == .Swedish {
            self.loadingLableMessage = "Var god vänta..."
        } else if XLanguage.get() == .Greek {
            self.loadingLableMessage = "Παρακαλώ περιμένετε..."
        } else if XLanguage.get() == .Russian {
            self.loadingLableMessage = "Пожалуйста, подождите..."
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
                    self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!

                    let imageCount = self.Images.count
                    let language = XLanguage.get()

                    var imageText = ""

                    // English as default
                    if language == .English {
                        imageText = imageCount == 1 ? "IMAGE (\(imageCount))" : "IMAGES (\(imageCount))"
                    } else if language == .Dutch {
                        imageText = imageCount == 1 ? "AFBEELDING (\(imageCount))" : "AFBEELDINGEN (\(imageCount))"
                    } else if language == .French {
                        imageText = imageCount == 1 ? "IMAGE (\(imageCount))" : "IMAGES (\(imageCount))"
                    } else if language == .Spanish {
                        imageText = imageCount == 1 ? "IMAGEN (\(imageCount))" : "IMÁGENES (\(imageCount))"
                    } else if language == .German {
                        imageText = imageCount == 1 ? "BILD (\(imageCount))" : "BILDER (\(imageCount))"
                    } else if language == .Hebrew {
                        imageText = imageCount == 1 ? "תמונה (\(imageCount))" : "תמונות (\(imageCount))"
                    } else if language == .Chinese {
                        imageText = imageCount == 1 ? "图像 (\(imageCount))" : "图像 (\(imageCount))"
                    } else if language == .Hindi {
                        imageText = imageCount == 1 ? "छवि (\(imageCount))" : "छवियाँ (\(imageCount))"
                    } else if language == .Portuguese {
                        imageText = imageCount == 1 ? "IMAGEM (\(imageCount))" : "IMAGENS (\(imageCount))"
                    } else if language == .Swedish {
                        imageText = imageCount == 1 ? "BILD (\(imageCount))" : "BILDER (\(imageCount))"
                    } else if language == .Greek {
                        imageText = imageCount == 1 ? "ΕΙΚΟΝΑ (\(imageCount))" : "ΕΙΚΟΝΕΣ (\(imageCount))"
                    } else if language == .Russian {
                        imageText = imageCount == 1 ? "ИЗОБРАЖЕНИЕ (\(imageCount))" : "ИЗОБРАЖЕНИЯ (\(imageCount))"
                    }else if language == .Arabic {
                        imageText = imageCount == 1 ? "صور (\(imageCount))" : "صور (\(imageCount))"
                        self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
                    } else if language == .Kurdish {
                        imageText = imageCount == 1 ? "وێنە (\(imageCount))" : "وێنە (\(imageCount))"
                        self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
                    }
                    
                    self.ImageCount.text = imageText

                    
                    
                }else{print("555555")
                   
                    self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!

                    let imageCount = self.CommignImages.count
                    let language = XLanguage.get()

                    var imageText = ""

                    // English as default
                    if language == .English {
                        imageText = imageCount == 1 ? "IMAGE (\(imageCount))" : "IMAGES (\(imageCount))"
                    } else if language == .Dutch {
                        imageText = imageCount == 1 ? "AFBEELDING (\(imageCount))" : "AFBEELDINGEN (\(imageCount))"
                    } else if language == .French {
                        imageText = imageCount == 1 ? "IMAGE (\(imageCount))" : "IMAGES (\(imageCount))"
                    } else if language == .Spanish {
                        imageText = imageCount == 1 ? "IMAGEN (\(imageCount))" : "IMÁGENES (\(imageCount))"
                    } else if language == .German {
                        imageText = imageCount == 1 ? "BILD (\(imageCount))" : "BILDER (\(imageCount))"
                    } else if language == .Hebrew {
                        imageText = imageCount == 1 ? "תמונה (\(imageCount))" : "תמונות (\(imageCount))"
                    } else if language == .Chinese {
                        imageText = imageCount == 1 ? "图像 (\(imageCount))" : "图像 (\(imageCount))"
                    } else if language == .Hindi {
                        imageText = imageCount == 1 ? "छवि (\(imageCount))" : "छवियाँ (\(imageCount))"
                    } else if language == .Portuguese {
                        imageText = imageCount == 1 ? "IMAGEM (\(imageCount))" : "IMAGENS (\(imageCount))"
                    } else if language == .Swedish {
                        imageText = imageCount == 1 ? "BILD (\(imageCount))" : "BILDER (\(imageCount))"
                    } else if language == .Greek {
                        imageText = imageCount == 1 ? "ΕΙΚΟΝΑ (\(imageCount))" : "ΕΙΚΟΝΕΣ (\(imageCount))"
                    } else if language == .Russian {
                        imageText = imageCount == 1 ? "ИЗОБРАЖЕНИЕ (\(imageCount))" : "ИЗОБРАЖЕНИЯ (\(imageCount))"
                    }else if language == .Arabic {
                        imageText = imageCount == 1 ? "صور (\(imageCount))" : "صور (\(imageCount))"
                        self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
                    } else if language == .Kurdish {
                        imageText = imageCount == 1 ? "وێنە (\(imageCount))" : "وێنە (\(imageCount))"
                        self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
                    }
                    
                    self.ImageCount.text = imageText

                    
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
        }else if XLanguage.get() == .English {
            self.Title = "Delete"
            self.message = "Are you sure?"
            self.action = "Yes"
            self.cancel = "Cancel"
        } else if XLanguage.get() == .Dutch {
            self.Title = "Verwijderen"
            self.message = "Weet je het zeker?"
            self.action = "Ja"
            self.cancel = "Annuleren"
        } else if XLanguage.get() == .French {
            self.Title = "Supprimer"
            self.message = "Êtes-vous sûr?"
            self.action = "Oui"
            self.cancel = "Annuler"
        } else if XLanguage.get() == .Spanish {
            self.Title = "Eliminar"
            self.message = "¿Estás seguro?"
            self.action = "Sí"
            self.cancel = "Cancelar"
        } else if XLanguage.get() == .German {
            self.Title = "Löschen"
            self.message = "Sind Sie sicher?"
            self.action = "Ja"
            self.cancel = "Abbrechen"
        } else if XLanguage.get() == .Hebrew {
            self.Title = "מחק"
            self.message = "האם אתה בטוח?"
            self.action = "כן"
            self.cancel = "ביטול"
        } else if XLanguage.get() == .Chinese {
            self.Title = "删除"
            self.message = "你确定吗？"
            self.action = "是的"
            self.cancel = "取消"
        } else if XLanguage.get() == .Hindi {
            self.Title = "हटाएं"
            self.message = "क्या आप सुनिश्चित हैं?"
            self.action = "हाँ"
            self.cancel = "रद्द करें"
        } else if XLanguage.get() == .Portuguese {
            self.Title = "Excluir"
            self.message = "Tem certeza?"
            self.action = "Sim"
            self.cancel = "Cancelar"
        } else if XLanguage.get() == .Swedish {
            self.Title = "Radera"
            self.message = "Är du säker?"
            self.action = "Ja"
            self.cancel = "Avbryt"
        } else if XLanguage.get() == .Greek {
            self.Title = "Διαγραφή"
            self.message = "Είστε σίγουροι;"
            self.action = "Ναι"
            self.cancel = "Ακύρωση"
        } else if XLanguage.get() == .Russian {
            self.Title = "Удалить"
            self.message = "Вы уверены?"
            self.action = "Да"
            self.cancel = "Отмена"
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
            self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!

            let imageCount = self.Images.count
            let language = XLanguage.get()

            var imageText = ""

            // English as default
            if language == .English {
                imageText = imageCount == 1 ? "IMAGE (\(imageCount))" : "IMAGES (\(imageCount))"
            } else if language == .Dutch {
                imageText = imageCount == 1 ? "AFBEELDING (\(imageCount))" : "AFBEELDINGEN (\(imageCount))"
            } else if language == .French {
                imageText = imageCount == 1 ? "IMAGE (\(imageCount))" : "IMAGES (\(imageCount))"
            } else if language == .Spanish {
                imageText = imageCount == 1 ? "IMAGEN (\(imageCount))" : "IMÁGENES (\(imageCount))"
            } else if language == .German {
                imageText = imageCount == 1 ? "BILD (\(imageCount))" : "BILDER (\(imageCount))"
            } else if language == .Hebrew {
                imageText = imageCount == 1 ? "תמונה (\(imageCount))" : "תמונות (\(imageCount))"
            } else if language == .Chinese {
                imageText = imageCount == 1 ? "图像 (\(imageCount))" : "图像 (\(imageCount))"
            } else if language == .Hindi {
                imageText = imageCount == 1 ? "छवि (\(imageCount))" : "छवियाँ (\(imageCount))"
            } else if language == .Portuguese {
                imageText = imageCount == 1 ? "IMAGEM (\(imageCount))" : "IMAGENS (\(imageCount))"
            } else if language == .Swedish {
                imageText = imageCount == 1 ? "BILD (\(imageCount))" : "BILDER (\(imageCount))"
            } else if language == .Greek {
                imageText = imageCount == 1 ? "ΕΙΚΟΝΑ (\(imageCount))" : "ΕΙΚΟΝΕΣ (\(imageCount))"
            } else if language == .Russian {
                imageText = imageCount == 1 ? "ИЗОБРАЖЕНИЕ (\(imageCount))" : "ИЗОБРАЖЕНИЯ (\(imageCount))"
            }else if language == .Arabic {
                imageText = imageCount == 1 ? "صور (\(imageCount))" : "صور (\(imageCount))"
                self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
            } else if language == .Kurdish {
                imageText = imageCount == 1 ? "وێنە (\(imageCount))" : "وێنە (\(imageCount))"
                self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
            }
            
            self.ImageCount.text = imageText

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
            self.ImageCount.font = UIFont(name: "ArialRoundedMTBold", size: 12)!

            let imageCount = self.CommignImages.count
            let language = XLanguage.get()

            var imageText = ""

            // English as default
            if language == .English {
                imageText = imageCount == 1 ? "IMAGE (\(imageCount))" : "IMAGES (\(imageCount))"
            } else if language == .Dutch {
                imageText = imageCount == 1 ? "AFBEELDING (\(imageCount))" : "AFBEELDINGEN (\(imageCount))"
            } else if language == .French {
                imageText = imageCount == 1 ? "IMAGE (\(imageCount))" : "IMAGES (\(imageCount))"
            } else if language == .Spanish {
                imageText = imageCount == 1 ? "IMAGEN (\(imageCount))" : "IMÁGENES (\(imageCount))"
            } else if language == .German {
                imageText = imageCount == 1 ? "BILD (\(imageCount))" : "BILDER (\(imageCount))"
            } else if language == .Hebrew {
                imageText = imageCount == 1 ? "תמונה (\(imageCount))" : "תמונות (\(imageCount))"
            } else if language == .Chinese {
                imageText = imageCount == 1 ? "图像 (\(imageCount))" : "图像 (\(imageCount))"
            } else if language == .Hindi {
                imageText = imageCount == 1 ? "छवि (\(imageCount))" : "छवियाँ (\(imageCount))"
            } else if language == .Portuguese {
                imageText = imageCount == 1 ? "IMAGEM (\(imageCount))" : "IMAGENS (\(imageCount))"
            } else if language == .Swedish {
                imageText = imageCount == 1 ? "BILD (\(imageCount))" : "BILDER (\(imageCount))"
            } else if language == .Greek {
                imageText = imageCount == 1 ? "ΕΙΚΟΝΑ (\(imageCount))" : "ΕΙΚΟΝΕΣ (\(imageCount))"
            } else if language == .Russian {
                imageText = imageCount == 1 ? "ИЗОБРАЖЕНИЕ (\(imageCount))" : "ИЗОБРАЖЕНИЯ (\(imageCount))"
            }else if language == .Arabic {
                imageText = imageCount == 1 ? "صور (\(imageCount))" : "صور (\(imageCount))"
                self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
            } else if language == .Kurdish {
                imageText = imageCount == 1 ? "وێنە (\(imageCount))" : "وێنە (\(imageCount))"
                self.ImageCount.font = UIFont(name: "PeshangDes2", size: 12)!
            }
            
            self.ImageCount.text = imageText

            self.ImagesCollectionView.reloadData()
        }
    }

    
    
    @IBOutlet weak var AddressLableView: UIView!
    
    
    var pleaseEnter = ""
    var chooseProject = ""
    func EmptyTextField(_ textfield : UITextField){
        textfield.becomeFirstResponder()
        if XLanguage.get() == .Kurdish{
            pleaseEnter = ""
            chooseProject = "تکایە پڕۆژەیەک بۆ موڵکەکەت هەڵبژێرە."
        }else if XLanguage.get() == .Arabic{
            pleaseEnter = ""
            chooseProject = "الرجاء اختيار مشروع لممتلكاتك."
        }else if XLanguage.get() == .English {
            pleaseEnter = ""
            chooseProject = "Please choose a project for your estate."
        } else if XLanguage.get() == .Dutch {
            pleaseEnter = ""
            chooseProject = "Kies alstublieft een project voor uw vastgoed."
        } else if XLanguage.get() == .French {
            pleaseEnter = ""
            chooseProject = "Veuillez choisir un projet pour votre propriété."
        } else if XLanguage.get() == .Spanish {
            pleaseEnter = ""
            chooseProject = "Por favor, elija un proyecto para su inmueble."
        } else if XLanguage.get() == .German {
            pleaseEnter = ""
            chooseProject = "Bitte wählen Sie ein Projekt für Ihr Grundstück aus."
        } else if XLanguage.get() == .Hebrew {
            pleaseEnter = ""
            chooseProject = "אנא בחר פרויקט לנכס שלך."
        } else if XLanguage.get() == .Chinese {
            pleaseEnter = ""
            chooseProject = "请为您的房产选择一个项目。"
        } else if XLanguage.get() == .Hindi {
            pleaseEnter = ""
            chooseProject = "कृपया अपनी संपत्ति के लिए एक परियोजना चुनें।"
        } else if XLanguage.get() == .Portuguese {
            pleaseEnter = ""
            chooseProject = "Por favor, escolha um projeto para o seu imóvel."
        } else if XLanguage.get() == .Swedish {
            pleaseEnter = ""
            chooseProject = "Vänligen välj ett projekt för din fastighet."
        } else if XLanguage.get() == .Greek {
            pleaseEnter = ""
            chooseProject = "Παρακαλώ επιλέξτε ένα έργο για την ιδιοκτησία σας."
        } else if XLanguage.get() == .Russian {
            pleaseEnter = ""
            chooseProject = "Пожалуйста, выберите проект для вашей недвижимости."
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
             if XLanguage.get() == .Arabic{
                self.view.makeToast("الرجاء اختيار مشروع لممتلكاتك.", duration: 3.0, position: .top)
            }else if XLanguage.get() == .Kurdish{
                self.view.makeToast("تکایە پڕۆژەیەک بۆ موڵکەکەت هەڵبژێرە.", duration: 3.0, position: .top)
            }else if XLanguage.get() == .English {
                self.view.makeToast("Please choose a project for your estate.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Dutch {
                self.view.makeToast("Kies alstublieft een project voor uw vastgoed.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .French {
                self.view.makeToast("Veuillez choisir un projet pour votre propriété.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Spanish {
                self.view.makeToast("Por favor, elija un proyecto para su inmueble.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .German {
                self.view.makeToast("Bitte wählen Sie ein Projekt für Ihr Grundstück aus.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Hebrew {
                self.view.makeToast("אנא בחר פרויקט לנכס שלך.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Chinese {
                self.view.makeToast("请为您的房产选择一个项目。", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Hindi {
                self.view.makeToast("कृपया अपनी संपत्ति के लिए एक परियोजना चुनें।", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Portuguese {
                self.view.makeToast("Por favor, escolha um projeto para o seu imóvel.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Swedish {
                self.view.makeToast("Vänligen välj ett projekt för din fastighet.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Greek {
                self.view.makeToast("Παρακαλώ επιλέξτε ένα έργο για την ιδιοκτησία σας.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Russian {
                self.view.makeToast("Пожалуйста, выберите проект для вашей недвижимости.", duration: 3.0, position: .top)
            }
            AudioServicesPlaySystemSound(1519);
            ProjectView.layer.borderColor = UIColor.red.cgColor
            ProjectView.layer.borderWidth = 1.5
            ProjectView.layer.cornerRadius = 5
            ProjectView.clipsToBounds = false
            ProjectView.layer.shadowOpacity=0.4
            ProjectView.layer.shadowOffset = CGSize(width: 0, height: 0)
        }else if textfield == self.EstateTypeLable{
             if XLanguage.get() == .Arabic{
                self.view.makeToast("الرجاء اختيار نوع العقار.", duration: 3.0, position: .top)
            }else if XLanguage.get() == .Kurdish{
                self.view.makeToast("تکایە جۆری خانوبەر هەڵبژێرە.", duration: 3.0, position: .top)
            }else if XLanguage.get() == .English {
                self.view.makeToast("Please choose estate type.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Dutch {
                self.view.makeToast("Kies alstublieft het type vastgoed.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .French {
                self.view.makeToast("Veuillez choisir le type de propriété.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Spanish {
                self.view.makeToast("Por favor, elija el tipo de propiedad.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .German {
                self.view.makeToast("Bitte wählen Sie den Immobilientyp.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Hebrew {
                self.view.makeToast("אנא בחר את סוג הנכס.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Chinese {
                self.view.makeToast("请选择房产类型。", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Hindi {
                self.view.makeToast("कृपया संपत्ति का प्रकार चुनें।", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Portuguese {
                self.view.makeToast("Por favor, escolha o tipo de imóvel.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Swedish {
                self.view.makeToast("Vänligen välj typ av fastighet.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Greek {
                self.view.makeToast("Παρακαλώ επιλέξτε τον τύπο ακινήτου.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Russian {
                self.view.makeToast("Пожалуйста, выберите тип недвижимости.", duration: 3.0, position: .top)
            }
            
            AudioServicesPlaySystemSound(1519);
            EstateTypeView.layer.borderColor = UIColor.red.cgColor
            EstateTypeView.layer.borderWidth = 1.5
            EstateTypeView.layer.cornerRadius = 5
            EstateTypeView.clipsToBounds = false
            EstateTypeView.layer.shadowOpacity=0.4
            EstateTypeView.layer.shadowOffset = CGSize(width: 0, height: 0)
          
        }else if textfield == Typelable{
             if XLanguage.get() == .Arabic{
                self.view.makeToast("الرجاء اختيار نوع الملكية.", duration: 3.0, position: .top)
            }else if XLanguage.get() == .Kurdish{
                self.view.makeToast("تکایە جۆری موڵکەکە هەڵبژێرە.", duration: 3.0, position: .top)
            }else if XLanguage.get() == .English {
                self.view.makeToast("Please choose the type of property.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Dutch {
                self.view.makeToast("Kies alstublieft het type eigendom.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .French {
                self.view.makeToast("Veuillez choisir le type de propriété.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Spanish {
                self.view.makeToast("Por favor, elija el tipo de propiedad.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .German {
                self.view.makeToast("Bitte wählen Sie die Art der Eigenschaft.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Hebrew {
                self.view.makeToast("אנא בחר את סוג הנכס.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Chinese {
                self.view.makeToast("请选择物业类型。", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Hindi {
                self.view.makeToast("कृपया संपत्ति के प्रकार का चयन करें।", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Portuguese {
                self.view.makeToast("Por favor, escolha o tipo de propriedade.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Swedish {
                self.view.makeToast("Vänligen välj typ av egendom.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Greek {
                self.view.makeToast("Παρακαλώ επιλέξτε τον τύπο της περιουσίας.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Russian {
                self.view.makeToast("Пожалуйста, выберите тип собственности.", duration: 3.0, position: .top)
            }
            AudioServicesPlaySystemSound(1519);
            TypeView.layer.borderColor = UIColor.red.cgColor
            TypeView.layer.borderWidth = 1.5
            TypeView.layer.cornerRadius = 5
            TypeView.clipsToBounds = false
            TypeView.layer.shadowOpacity=0.4
            TypeView.layer.shadowOffset = CGSize(width: 0, height: 0)
        }else if textfield == self.AddressLable{
           if XLanguage.get() == .Arabic{
                self.view.makeToast("الرجاء اختيار المدينة.", duration: 3.0, position: .top)
           }else if XLanguage.get() == .Kurdish{
                self.view.makeToast("تکایە شار هەڵبژێرە.", duration: 3.0, position: .top)
            }else if XLanguage.get() == .English {
                self.view.makeToast("Please choose City.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Dutch {
                self.view.makeToast("Kies alstublieft een stad.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .French {
                self.view.makeToast("Veuillez choisir une ville.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Spanish {
                self.view.makeToast("Por favor, elija una ciudad.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .German {
                self.view.makeToast("Bitte wählen Sie eine Stadt.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Hebrew {
                self.view.makeToast("אנא בחר עיר.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Chinese {
                self.view.makeToast("请选择城市。", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Hindi {
                self.view.makeToast("कृपया शहर चुनें।", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Portuguese {
                self.view.makeToast("Por favor, escolha uma cidade.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Swedish {
                self.view.makeToast("Vänligen välj en stad.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Greek {
                self.view.makeToast("Παρακαλώ επιλέξτε μια πόλη.", duration: 3.0, position: .top)
            } else if XLanguage.get() == .Russian {
                self.view.makeToast("Пожалуйста, выберите город.", duration: 3.0, position: .top)
            }
            ToastManager.shared.isTapToDismissEnabled = true
            AudioServicesPlaySystemSound(1519);
            AddressLableView.layer.borderColor = UIColor.red.cgColor;
            AddressLableView.layer.borderWidth = 1.5 ;
            AddressLableView.layer.cornerRadius = 5 ;
            AddressLableView.clipsToBounds = false
            AddressLableView.layer.shadowOpacity=0.4
            AddressLableView.layer.shadowOffset = CGSize(width: 0, height: 0)
        }else{
            AudioServicesPlaySystemSound(1519);
            textfield.layer.borderColor = UIColor.red.cgColor;
            textfield.layer.borderWidth = 1.5 ;
            textfield.layer.cornerRadius = 5 ;
            textfield.clipsToBounds = false
            textfield.layer.shadowOpacity=0.4
            textfield.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.view.makeToast("\(pleaseEnter) \(textfield.text!).", duration: 3.0, position: .top)
        }
        ToastManager.shared.isTapToDismissEnabled = true
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
                if XLanguage.get() == .Kurdish{
                    let myAlert = UIAlertController(title: "تکایە لانیکەم یەک وێنە هەڵبژێرە.", message: nil, preferredStyle: UIAlertController.Style.alert)
                    myAlert.addAction(UIAlertAction(title: "بەڵێ", style: UIAlertAction.Style.cancel, handler: nil))
                    self.present(myAlert, animated: true, completion: nil)
                    return
                }else if XLanguage.get() == .Arabic{
                    let myAlert = UIAlertController(title: "الرجاء اختيار صورة واحدة على الأقل.", message: nil, preferredStyle: UIAlertController.Style.alert)
                    myAlert.addAction(UIAlertAction(title: "إلغاء", style: UIAlertAction.Style.cancel, handler: nil))
                    self.present(myAlert, animated: true, completion: nil)
                    return
                }else if XLanguage.get() == .English {
                    let myAlert = UIAlertController(title: "Please choose at least one image.", message: nil, preferredStyle: .alert)
                    myAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(myAlert, animated: true, completion: nil)
                    return
                } else if XLanguage.get() == .Dutch {
                    let myAlert = UIAlertController(title: "Kies alstublieft minstens één afbeelding.", message: nil, preferredStyle: .alert)
                    myAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(myAlert, animated: true, completion: nil)
                    return
                } else if XLanguage.get() == .French {
                    let myAlert = UIAlertController(title: "Veuillez choisir au moins une image.", message: nil, preferredStyle: .alert)
                    myAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(myAlert, animated: true, completion: nil)
                    return
                } else if XLanguage.get() == .Spanish {
                    let myAlert = UIAlertController(title: "Por favor, elija al menos una imagen.", message: nil, preferredStyle: .alert)
                    myAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(myAlert, animated: true, completion: nil)
                    return
                } else if XLanguage.get() == .German {
                    let myAlert = UIAlertController(title: "Bitte wählen Sie mindestens ein Bild aus.", message: nil, preferredStyle: .alert)
                    myAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(myAlert, animated: true, completion: nil)
                    return
                } else if XLanguage.get() == .Hebrew {
                    let myAlert = UIAlertController(title: "אנא בחר לפחות תמונה אחת.", message: nil, preferredStyle: .alert)
                    myAlert.addAction(UIAlertAction(title: "אישור", style: .cancel, handler: nil))
                    self.present(myAlert, animated: true, completion: nil)
                    return
                } else if XLanguage.get() == .Chinese {
                    let myAlert = UIAlertController(title: "请选择至少一张图片。", message: nil, preferredStyle: .alert)
                    myAlert.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
                    self.present(myAlert, animated: true, completion: nil)
                    return
                } else if XLanguage.get() == .Hindi {
                    let myAlert = UIAlertController(title: "कृपया कम से कम एक चित्र चुनें।", message: nil, preferredStyle: .alert)
                    myAlert.addAction(UIAlertAction(title: "ठीक है", style: .cancel, handler: nil))
                    self.present(myAlert, animated: true, completion: nil)
                    return
                } else if XLanguage.get() == .Portuguese {
                    let myAlert = UIAlertController(title: "Por favor, escolha pelo menos uma imagem.", message: nil, preferredStyle: .alert)
                    myAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(myAlert, animated: true, completion: nil)
                    return
                } else {
                    let myAlert = UIAlertController(title: "Пожалуйста, выберите хотя бы одно изображение.", message: nil, preferredStyle: .alert)
                    myAlert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: nil))
                    self.present(myAlert, animated: true, completion: nil)
                    return
                }
            }
        }
            
        guard self.Name.text!.isEmpty == false else{EmptyTextField(self.Name); return }
       
        guard self.Price.text!.isEmpty == false else{EmptyTextField(self.Price); return }
       
        guard self.Address.text!.isEmpty == false else{ EmptyTextField(self.Address); return }
       
        let language = XLanguage.get()
        if language == .Kurdish{
            guard self.LatLongAddress.text! != "شوێن ( )" else{ EmptyLatidute(self.ViewmapButton); return}
        }else if language == .Arabic{
            guard self.LatLongAddress.text! != "موقعك ( )" else{ EmptyLatidute(self.ViewmapButton); return}
        }else if language == .English {
                guard self.LatLongAddress.text! != "LOCATION ( )" else { EmptyLatidute(self.ViewmapButton); return }
            } else if language == .Dutch {
                guard self.LatLongAddress.text! != "LOCATIE ( )" else { EmptyLatidute(self.ViewmapButton); return }
            } else if language == .French {
                guard self.LatLongAddress.text! != "EMPLACEMENT ( )" else { EmptyLatidute(self.ViewmapButton); return }
            } else if language == .Spanish {
                guard self.LatLongAddress.text! != "UBICACIÓN ( )" else { EmptyLatidute(self.ViewmapButton); return }
            } else if language == .German {
                guard self.LatLongAddress.text! != "STANDORT ( )" else { EmptyLatidute(self.ViewmapButton); return }
            } else if language == .Hebrew {
                guard self.LatLongAddress.text! != "מיקום ( )" else { EmptyLatidute(self.ViewmapButton); return }
            } else if language == .Chinese {
                guard self.LatLongAddress.text! != "位置 ( )" else { EmptyLatidute(self.ViewmapButton); return }
            } else if language == .Hindi {
                guard self.LatLongAddress.text! != "स्थान ( )" else { EmptyLatidute(self.ViewmapButton); return }
            } else if language == .Portuguese {
                guard self.LatLongAddress.text! != "LOCALIZAÇÃO ( )" else { EmptyLatidute(self.ViewmapButton); return }
            } else if language == .Swedish {
                guard self.LatLongAddress.text! != "PLATS ( )" else { EmptyLatidute(self.ViewmapButton); return }
            } else if language == .Greek {
                guard self.LatLongAddress.text! != "ΤΟΠΟΘΕΣΙΑ ( )" else { EmptyLatidute(self.ViewmapButton); return }
            } else if language == .Russian {
                guard self.LatLongAddress.text! != "МЕСТОПОЛОЖЕНИЕ ( )" else { EmptyLatidute(self.ViewmapButton); return }
            }
       
            
        guard self.CityId != "" else{EmptyLable(self.AddressLable); return}
       
            
        guard self.EstateTypeLable.text!.isEmpty == false else{EmptyLable(self.EstateTypeLable); return}
        

        if self.IsApartment == true{
            guard self.Floor.text!.isEmpty == false else{EmptyTextField(self.Floor); return}
            
            guard self.Building.text!.isEmpty == false else{EmptyTextField(self.Building); return}
            
            guard self.MonthlyFee.text!.isEmpty == false else{EmptyTextField(self.MonthlyFee); return}
            
            guard self.ProjectName.text!.isEmpty == false else{EmptyLable(self.ProjectName); return}
        }
        guard self.TypeId != "" else{EmptyLable(self.Typelable); return}
        
            
            guard self.Space.text!.isEmpty == false else{EmptyTextField(self.Space); return}
            guard self.Furnished.text!.isEmpty == false else{EmptyTextField(self.Furnished); return}
            
        guard self.BondType.text!.isEmpty == false else{EmptyTextField(self.BondType); return}
        
        guard self.Year.text!.isEmpty == false else{EmptyTextField(self.Year); return}
       
        guard self.PropertyNo.text!.isEmpty == false else{EmptyTextField(self.PropertyNo); return}
        
            if XLanguage.get() == .English {
                self.titlee = "Upload Information"
                self.message = "Are you sure you want to upload the information?"
                self.updatetitlee = "Update Information"
                self.updatemessagee = "Are you sure you want to update the information?"
                self.Action = "Yes"
                self.cancel = "No"
            } else if XLanguage.get() == .Kurdish {
                self.titlee = "بارکردنی زانیاری"
                self.message = "ئایا دڵنیای لە بارکردنی زانیاری؟"
                self.updatetitlee = "نوێکردنەوەی زانیاری"
                self.updatemessagee = "ئایا دڵنیای لە نوێکردنەوە؟"
                self.Action = "بەڵێ"
                self.cancel = "نەخێر"
            } else if XLanguage.get() == .Arabic {
                self.titlee = "رفع المعلومات"
                self.message = "هل أنت متأكد من رفع المعلومات؟"
                self.updatetitlee = "تحديث المعلومات"
                self.updatemessagee = "هل أنت متأكد من التحديث؟"
                self.Action = "نعم"
                self.cancel = "لا"
            } else if XLanguage.get() == .Hebrew {
                self.titlee = "העלאת מידע"
                self.message = "האם אתה בטוח שברצונך להעלות את המידע?"
                self.updatetitlee = "עדכון מידע"
                self.updatemessagee = "האם אתה בטוח שברצונך לעדכן את המידע?"
                self.Action = "כן"
                self.cancel = "לא"
            } else if XLanguage.get() == .Chinese {
                self.titlee = "上传信息"
                self.message = "您确定要上传信息吗？"
                self.updatetitlee = "更新信息"
                self.updatemessagee = "您确定要更新信息吗？"
                self.Action = "是"
                self.cancel = "否"
            } else if XLanguage.get() == .Hindi {
                self.titlee = "जानकारी अपलोड करें"
                self.message = "क्या आप सुनिश्चित हैं कि आप जानकारी अपलोड करना चाहते हैं?"
                self.updatetitlee = "जानकारी अपडेट करें"
                self.updatemessagee = "क्या आप सुनिश्चित हैं कि आप जानकारी अपडेट करना चाहते हैं?"
                self.Action = "हाँ"
                self.cancel = "नहीं"
            } else if XLanguage.get() == .Portuguese {
                self.titlee = "Carregar Informações"
                self.message = "Tem certeza de que deseja carregar as informações?"
                self.updatetitlee = "Atualizar Informações"
                self.updatemessagee = "Tem certeza de que deseja atualizar as informações?"
                self.Action = "Sim"
                self.cancel = "Não"
            } else if XLanguage.get() == .Swedish {
                self.titlee = "Ladda upp information"
                self.message = "Är du säker på att du vill ladda upp informationen?"
                self.updatetitlee = "Uppdatera information"
                self.updatemessagee = "Är du säker på att du vill uppdatera informationen?"
                self.Action = "Ja"
                self.cancel = "Nej"
            } else if XLanguage.get() == .Greek {
                self.titlee = "Ανέβασμα Πληροφοριών"
                self.message = "Είστε σίγουροι ότι θέλετε να ανεβάσετε τις πληροφορίες;"
                self.updatetitlee = "Ενημέρωση Πληροφοριών"
                self.updatemessagee = "Είστε σίγουροι ότι θέλετε να ενημερώσετε τις πληροφορίες;"
                self.Action = "Ναι"
                self.cancel = "Όχι"
            } else if XLanguage.get() == .Russian {
                self.titlee = "Загрузка информации"
                self.message = "Вы уверены, что хотите загрузить информацию?"
                self.updatetitlee = "Обновление информации"
                self.updatemessagee = "Вы уверены, что хотите обновить информацию?"
                self.Action = "Да"
                self.cancel = "Нет"
            } else if XLanguage.get() == .Dutch {
                self.titlee = "Informatie Uploaden"
                self.message = "Weet u zeker dat u de informatie wilt uploaden?"
                self.updatetitlee = "Informatie Bijwerken"
                self.updatemessagee = "Weet u zeker dat u de informatie wilt bijwerken?"
                self.Action = "Ja"
                self.cancel = "Nee"
            } else if XLanguage.get() == .French {
                self.titlee = "Télécharger les informations"
                self.message = "Êtes-vous sûr de vouloir télécharger les informations?"
                self.updatetitlee = "Mettre à jour les informations"
                self.updatemessagee = "Êtes-vous sûr de vouloir mettre à jour les informations?"
                self.Action = "Oui"
                self.cancel = "Non"
            } else if XLanguage.get() == .Spanish {
                self.titlee = "Subir Información"
                self.message = "¿Estás seguro de que deseas subir la información?"
                self.updatetitlee = "Actualizar Información"
                self.updatemessagee = "¿Estás seguro de que deseas actualizar la información?"
                self.Action = "Sí"
                self.cancel = "No"
            } else if XLanguage.get() == .German {
                self.titlee = "Informationen Hochladen"
                self.message = "Sind Sie sicher, dass Sie die Informationen hochladen möchten?"
                self.updatetitlee = "Informationen Aktualisieren"
                self.updatemessagee = "Sind Sie sicher, dass Sie die Informationen aktualisieren möchten?"
                self.Action = "Ja"
                self.cancel = "Nein"
            } else {
                self.titlee = "Upload Information"
                self.message = "Are you sure you want to upload the information?"
                self.updatetitlee = "Update Information"
                self.updatemessagee = "Are you sure you want to update the information?"
                self.Action = "Yes"
                self.cancel = "No"
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
                                                  , sold: "0"
                                                  , type_id: self.TypeId).Upload()
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
                                              , office_id: UserDefaults.standard.string(forKey: "OfficeId") ?? ""
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
                                              , sold: "0"
                                              , type_id: self.TypeId).Update()
                            
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

