//
//  SignatureAndArabicName.swift
//  RealEstates
//
//  Created by Botan Amedi on 29/05/2023.
//

import UIKit
import EPSignature
import Foundation
import MHLoadingButton
class SignatureAndArabicName: UIViewController, EPSignatureDelegate{
    
    func epSignature(_: EPSignatureViewController, didCancel error: NSError) {
        //
    }
    
    func epSignature(_: EPSignatureViewController, didSign signatureImage: UIImage, boundingRect: CGRect) {
        let rotatedImage = signatureImage.rotated(by: Measurement(value: 90, unit: .degrees))
        self.SignatureImg.append(rotatedImage!)
        self.SignatureImage.image = rotatedImage
    }
    
    @IBAction func Dismiss(_ sender: Any){
        self.dismiss(animated: true)
    }

    @IBOutlet weak var ArabicName: LanguagePlaceHolder!
    @IBOutlet weak var SignatureImage: UIImageView!
    
    
    @IBOutlet weak var Continue: LoadingButton!
    
    
    
    var contract_image =  ""
    var IsOfficeHasAr_Name_And_Contract_Image = false
    var SignatureImg : [UIImage] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if XLanguage.get() == .English {
            self.Continue.setTitle("Continue")
        } else if XLanguage.get() == .Kurdish {
            self.Continue.setTitle("بەردەوامبە")
        } else if XLanguage.get() == .Arabic {
            self.Continue.setTitle("استمر")
        } else if XLanguage.get() == .Hebrew {
            self.Continue.setTitle("המשך")
        } else if XLanguage.get() == .Chinese {
            self.Continue.setTitle("继续")
        } else if XLanguage.get() == .Hindi {
            self.Continue.setTitle("जारी रखें")
        } else if XLanguage.get() == .Portuguese {
            self.Continue.setTitle("Continuar")
        } else if XLanguage.get() == .Swedish {
            self.Continue.setTitle("Fortsätt")
        } else if XLanguage.get() == .Greek {
            self.Continue.setTitle("Συνέχεια")
        } else if XLanguage.get() == .Russian {
            self.Continue.setTitle("Продолжить")
        } else if XLanguage.get() == .Dutch {
            self.Continue.setTitle("Doorgaan")
        } else if XLanguage.get() == .French {
            self.Continue.setTitle("Continuer")
        } else if XLanguage.get() == .Spanish {
            self.Continue.setTitle("Continuar")
        } else if XLanguage.get() == .German {
            self.Continue.setTitle("Fortsetzen")
        } else {
            self.Continue.setTitle("Continue")
        }
        
        
        
        
        
        
        if let FireId = UserDefaults.standard.string(forKey: "UserId"){
            OfficeAip.GetOfficeById(Id: FireId) { office in
                let url = URL(string: office.contract_image ?? "")
                self.SignatureImage.sd_setImage(with: url,  placeholderImage: UIImage())
                self.ArabicName.text = office.arabic_name ?? ""
                
                if office.arabic_name == "" && office.contract_image == ""{
                    self.IsOfficeHasAr_Name_And_Contract_Image = false
                }else{
                    self.IsOfficeHasAr_Name_And_Contract_Image = true
                    self.contract_image = office.contract_image ?? ""
                }
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasHiden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    var count = 1
    @objc func keyboardWasShown(notification: NSNotification) {
        if count == 1{
           count += 1
        let info = notification.userInfo!
            let keyboardFrame : CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            self.ScrollViewLayout.constant += keyboardFrame.height - 100
        }
    }
    
    @IBOutlet weak var ScrollViewLayout: NSLayoutConstraint!
    @objc func keyboardWasHiden(notification: NSNotification) {
        self.ScrollViewLayout.constant = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    var EstateData : EstateObject!
    
    
    func uploadManyImage(complition : @escaping (_ URLs: [String])->()){
        var uploadedImages : [String] = []
        for one in self.SignatureImg{
            one.upload { (url) in
                uploadedImages.append(url)
                if self.SignatureImg.count == uploadedImages.count{
                    complition(uploadedImages)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let estate = sender as? EstateObject{
            if let next = segue.destination as? PaymentVc{
                next.EstateData = estate
            }
        }
    }
    
    
    func GoTOPaymentVC(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "Payment") as! PaymentViewController
        self.present(vc, animated: true)
        
    }
    
    @IBOutlet weak var SendInfo: LoadingButton!
    
    @IBAction func SendInfo(_ sender: Any) {
        self.SendInfo.showLoader(userInteraction: true)
        if UserDefaults.standard.bool(forKey: "Login") == true {
            if let FireId = UserDefaults.standard.string(forKey: "UserId"){
                if self.SignatureImage.image != UIImage() && self.ArabicName.text?.removeWhitespace() != "" {
                    if IsOfficeHasAr_Name_And_Contract_Image == false{
                        self.uploadManyImage { URLs in
                            OfficeAip.UpdateContractData(id:UserDefaults.standard.string(forKey: "OfficeId") ?? "",arabic_name: self.ArabicName.text!, contract_image: URLs[0]) { _ in
                                print("Office id is done")
                                self.performSegue(withIdentifier: "Next", sender: self.EstateData)
                                self.SendInfo.hideLoader()
                                //self.GoTOPaymentVC()
                            }
                        }
                    }else{
                        OfficeAip.UpdateContractData(id:UserDefaults.standard.string(forKey: "OfficeId") ?? "",arabic_name: self.ArabicName.text!, contract_image: self.contract_image) { _ in
                            print("Office id is done1111")
                            self.performSegue(withIdentifier: "Next", sender: self.EstateData)
                            self.SendInfo.hideLoader()
                            //self.GoTOPaymentVC()
                        }
                    }
                }else{
                    self.SendInfo.hideLoader()
                    if self.SignatureImage.image == UIImage(){
                        if XLanguage.get() == .English {
                            let ac = UIAlertController(title: "Signature", message: "Please sign your signature.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else if XLanguage.get() == .Kurdish {
                            let ac = UIAlertController(title: "Signature", message: "تکایە واژووەکەت بنووسە.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "باشە", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else if XLanguage.get() == .Arabic {
                            let ac = UIAlertController(title: "توقيع", message: "يرجى توقيع التوقيع الخاص بك.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "حسناً", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else if XLanguage.get() == .Hebrew {
                            let ac = UIAlertController(title: "חתימה", message: "אנא חתום את החתימה שלך.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "אישור", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else if XLanguage.get() == .Chinese {
                            let ac = UIAlertController(title: "签名", message: "请签上你的签名。", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "确定", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else if XLanguage.get() == .Hindi {
                            let ac = UIAlertController(title: "हस्ताक्षर", message: "कृपया अपना हस्ताक्षर करें।", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "ठीक है", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else if XLanguage.get() == .Portuguese {
                            let ac = UIAlertController(title: "Assinatura", message: "Por favor, assine sua assinatura.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else if XLanguage.get() == .Swedish {
                            let ac = UIAlertController(title: "Signatur", message: "Vänligen skriv din signatur.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else if XLanguage.get() == .Greek {
                            let ac = UIAlertController(title: "Υπογραφή", message: "Παρακαλώ υπογράψτε την υπογραφή σας.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "Εντάξει", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else if XLanguage.get() == .Russian {
                            let ac = UIAlertController(title: "Подпись", message: "Пожалуйста, подпишите свою подпись.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "ОК", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else if XLanguage.get() == .Dutch {
                            let ac = UIAlertController(title: "Handtekening", message: "Gelieve uw handtekening te plaatsen.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else if XLanguage.get() == .French {
                            let ac = UIAlertController(title: "Signature", message: "Veuillez signer votre signature.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else if XLanguage.get() == .Spanish {
                            let ac = UIAlertController(title: "Firma", message: "Por favor, firme su firma.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else if XLanguage.get() == .German {
                            let ac = UIAlertController(title: "Unterschrift", message: "Bitte unterschreiben Sie Ihre Unterschrift.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else {
                            let ac = UIAlertController(title: "Signature", message: "Please sign your signature.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        }

                    }
                    
                    if self.ArabicName.text?.removeWhitespace() == ""{
                        if XLanguage.get() == .English {
                            let ac = UIAlertController(title: "Your Full Name", message: "Please write your full name.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else if XLanguage.get() == .Kurdish {
                            let ac = UIAlertController(title: "ناوی تەواوت", message: "تکایە ناوی تەواوی خۆت بنووسە.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "باشە", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else if XLanguage.get() == .Arabic {
                            let ac = UIAlertController(title: "اسمك الكامل", message: "يرجى كتابة اسمك الكامل.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "حسناً", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else if XLanguage.get() == .Hebrew {
                            let ac = UIAlertController(title: "השם המלא שלך", message: "נא לכתוב את שמך המלא.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "אישור", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else if XLanguage.get() == .Chinese {
                            let ac = UIAlertController(title: "您的全名", message: "请写下你的全名。", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "确定", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else if XLanguage.get() == .Hindi {
                            let ac = UIAlertController(title: "आपका पूरा नाम", message: "कृपया अपना पूरा नाम लिखें।", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "ठीक है", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else if XLanguage.get() == .Portuguese {
                            let ac = UIAlertController(title: "Seu Nome Completo", message: "Por favor, escreva seu nome completo.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else if XLanguage.get() == .Swedish {
                            let ac = UIAlertController(title: "Ditt Fullständiga Namn", message: "Vänligen skriv ditt fullständiga namn.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else if XLanguage.get() == .Greek {
                            let ac = UIAlertController(title: "Το Πλήρες Όνομά Σας", message: "Παρακαλώ γράψτε το πλήρες όνομά σας.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "Εντάξει", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else if XLanguage.get() == .Russian {
                            let ac = UIAlertController(title: "Ваше Полное Имя", message: "Пожалуйста, напишите ваше полное имя.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "ОК", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else if XLanguage.get() == .Dutch {
                            let ac = UIAlertController(title: "Uw Volledige Naam", message: "Schrijf uw volledige naam.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else if XLanguage.get() == .French {
                            let ac = UIAlertController(title: "Votre Nom Complet", message: "Veuillez écrire votre nom complet.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else if XLanguage.get() == .Spanish {
                            let ac = UIAlertController(title: "Su Nombre Completo", message: "Por favor, escriba su nombre completo.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else if XLanguage.get() == .German {
                            let ac = UIAlertController(title: "Ihr Vollständiger Name", message: "Bitte schreiben Sie Ihren vollständigen Namen.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        } else {
                            let ac = UIAlertController(title: "Your Full Name", message: "Please write your full name.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                                ac.dismiss(animated: true)
                            }))
                            present(ac, animated: true)
                        }

                    }
                }
            }
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVCViewController
            vc.modalPresentationStyle = .fullScreen
            vc.IsFromAnotherVc = true
            self.present(vc, animated: true)
        }
        
    }
    

    
    
    
    @IBAction func NewSignature(_ sender: Any) {
        let signatureVC = EPSignatureViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: true)
        let nav = UINavigationController(rootViewController: signatureVC)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
}


extension UIImage {
    struct RotationOptions: OptionSet {
        let rawValue: Int

        static let flipOnVerticalAxis = RotationOptions(rawValue: 1)
        static let flipOnHorizontalAxis = RotationOptions(rawValue: 2)
    }

    func rotated(by rotationAngle: Measurement<UnitAngle>, options: RotationOptions = []) -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }

        let rotationInRadians = CGFloat(rotationAngle.converted(to: .radians).value)
        let transform = CGAffineTransform(rotationAngle: rotationInRadians)
        var rect = CGRect(origin: .zero, size: self.size).applying(transform)
        rect.origin = .zero

        let renderer = UIGraphicsImageRenderer(size: rect.size)
        return renderer.image { renderContext in
            renderContext.cgContext.translateBy(x: rect.midX, y: rect.midY)
            renderContext.cgContext.rotate(by: rotationInRadians)

            let x = options.contains(.flipOnVerticalAxis) ? -1.0 : 1.0
            let y = options.contains(.flipOnHorizontalAxis) ? 1.0 : -1.0
            renderContext.cgContext.scaleBy(x: CGFloat(x), y: CGFloat(y))

            let drawRect = CGRect(origin: CGPoint(x: -self.size.width/2, y: -self.size.height/2), size: self.size)
            renderContext.cgContext.draw(cgImage, in: drawRect)
        }
    }
}
