//
//  PaymentVc.swift
//  RealEstates
//
//  Created by Botan Amedi on 01/06/2023.
//

import UIKit
import Alamofire
import SwiftyJSON
import MHLoadingButton
import Stripe



class PaymentVc: UIViewController , UITextFieldDelegate{
    @IBOutlet weak var SelectedCashView: UIView!
    @IBOutlet weak var SelectedFastPayView: UIView!
    @IBOutlet weak var SelectedMasterCardView: UIView!
    @IBOutlet weak var Price: UILabel!
    
    @IBOutlet weak var CardInfoView: UIView!
    @IBOutlet weak var CardNumberView: UIView!
    @IBOutlet weak var CardNameView: UIView!
    @IBOutlet weak var CardNumner: UITextField!
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var EXView: UIView!
    @IBOutlet weak var EXPire: UITextField!
    @IBOutlet weak var CVVView: UIView!
    @IBOutlet weak var CVV: UITextField!
    
    @IBOutlet weak var SelectedCardNumber: UILabel!
    @IBOutlet weak var SelectedEXP: UILabel!
    
    @IBOutlet weak var ChangeCardInfo: Languagebutton!
    
    
    
    
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text, let r = Range(range, in: oldText) else {
            return true
        }
        let updatedText = oldText.replacingCharacters(in: r, with: string)

        if string == "" {
            if updatedText.count == 2 {
                textField.text = "\(updatedText.prefix(1))"
                return false
            }
        } else if updatedText.count == 1 {
            if updatedText > "1" {
                return false
            }
        } else if updatedText.count == 2 {
            if updatedText <= "12" { //Prevent user to not enter month more than 12
                textField.text = "\(updatedText)/" //This will add "/" when user enters 2nd digit of month
            }
            return false
        } else if updatedText.count == 5 {
            self.expDateValidation(dateStr: updatedText)
        } else if updatedText.count > 5 {
            return false
        }

        return true
    }
    
    
    func expDateValidation(dateStr:String) {

        let currentYear = Calendar.current.component(.year, from: Date()) % 100   // This will give you current year (i.e. if 2019 then it will be 19)
        let currentMonth = Calendar.current.component(.month, from: Date()) // This will give you current month (i.e if June then it will be 6)

        let enteredYear = Int(dateStr.suffix(2)) ?? 0 // get last two digit from entered string as year
        let enteredMonth = Int(dateStr.prefix(2)) ?? 0 // get first two digit from entered string as month
        print(dateStr) // This is MM/YY Entered by user

        if enteredYear > currentYear {
            if (1 ... 12).contains(enteredMonth) {
                print("Entered Date Is Right")
            } else {
                print("Entered Date Is Wrong")
            }
        } else if currentYear == enteredYear {
            if enteredMonth >= currentMonth {
                if (1 ... 12).contains(enteredMonth) {
                   print("Entered Date Is Right")
                } else {
                   print("Entered Date Is Wrong")
                }
            } else {
                print("Entered Date Is Wrong")
            }
        } else {
           print("Entered Date Is Wrong")
        }

    }
    
    
    var IsChangeClicked = false
    @IBAction func ChangeCardInfo(_ sender: Any) {
        if IsChangeClicked == false {
            IsChangeClicked = true
            UIView.animate(withDuration: 0.2) {
                self.CardInfoView.isHidden = false
                self.view.layoutIfNeeded()
                
                if UserDefaults.standard.string(forKey: "CardNumner") == "" || UserDefaults.standard.string(forKey: "CardNumner") == nil{
                    self.CardNumner.text = ""
                    self.CVV.text = ""
                    self.EXPire.text = ""
                }else{
                    self.CardNumner.text = UserDefaults.standard.string(forKey: "CardNumner") ?? ""
                    self.CVV.text = UserDefaults.standard.string(forKey: "CVV") ?? ""
                    self.EXPire.text = UserDefaults.standard.string(forKey: "Expire") ?? ""
                }
                
            }
        }else{
            IsChangeClicked = false
            UIView.animate(withDuration: 0.2) {
                self.CardInfoView.isHidden = true
                self.view.layoutIfNeeded()
            }
            self.CardNumner.resignFirstResponder()
            self.EXPire.resignFirstResponder()
            self.CVV.resignFirstResponder()
        }
    }
    
    
    @IBAction func Dismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    

    
    
    
    var EstateData : EstateObject!

    @IBOutlet weak var Pay: LoadingButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CVV.keyboardType = .numberPad
        EXPire.keyboardType = .numberPad
        CardNumner.keyboardType = .numberPad
        
        if XLanguage.get() == .English {
            self.Pay.setTitle("Pay Now")
        } else if XLanguage.get() == .Kurdish {
            self.Pay.setTitle("ئێستا پارە بدە")
        } else if XLanguage.get() == .Arabic {
            self.Pay.setTitle("ادفع الآن")
        } else if XLanguage.get() == .Hebrew {
            self.Pay.setTitle("שלם עכשיו")
        } else if XLanguage.get() == .Chinese {
            self.Pay.setTitle("立即支付")
        } else if XLanguage.get() == .Hindi {
            self.Pay.setTitle("अब भुगतान करें")
        } else if XLanguage.get() == .Portuguese {
            self.Pay.setTitle("Pagar Agora")
        } else if XLanguage.get() == .Swedish {
            self.Pay.setTitle("Betala Nu")
        } else if XLanguage.get() == .Greek {
            self.Pay.setTitle("Πληρώστε Τώρα")
        } else if XLanguage.get() == .Russian {
            self.Pay.setTitle("Заплатить Сейчас")
        } else if XLanguage.get() == .Dutch {
            self.Pay.setTitle("Nu Betalen")
        } else if XLanguage.get() == .French {
            self.Pay.setTitle("Payer Maintenant")
        } else if XLanguage.get() == .Spanish {
            self.Pay.setTitle("Pagar Ahora")
        } else if XLanguage.get() == .German {
            self.Pay.setTitle("Jetzt Bezahlen")
        } else {
            self.Pay.setTitle("Pay Now")
        }

        
     
        
        
        self.EXPire.delegate = self
        self.SelectedFastPayView.layer.cornerRadius = self.SelectedFastPayView.bounds.width / 2
        self.SelectedCashView.layer.cornerRadius = self.SelectedCashView.bounds.width / 2
        self.SelectedMasterCardView.layer.cornerRadius = self.SelectedCashView.bounds.width / 2
        self.SelectedFastPayView.layer.borderWidth = 0.7
        self.SelectedCashView.layer.borderWidth = 0.7
        self.SelectedCashView.layer.borderColor = UIColor.white.cgColor
        self.SelectedFastPayView.layer.borderColor = UIColor.white.cgColor
        
        self.Price.text = "$50"
        
        self.CardNumberView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.CardNumberView.layer.borderWidth = 0.7
        
        self.EXView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.EXView.layer.borderWidth = 0.7
        
        self.CVVView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.CVVView.layer.borderWidth = 0.7
        
        self.CardNameView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.CardNameView.layer.borderWidth = 0.7
        
        
        if UserDefaults.standard.string(forKey: "CardNumner") == "" || UserDefaults.standard.string(forKey: "CardNumner") == nil || UserDefaults.standard.string(forKey: "CardName") == ""{
            self.SelectedCashView.backgroundColor = #colorLiteral(red: 0.1620929837, green: 0.4347665906, blue: 0.8148480654, alpha: 1)
            self.SelectedFastPayView.backgroundColor = #colorLiteral(red: 0.06285511702, green: 0.06285511702, blue: 0.06285511702, alpha: 1)
            self.SelectedMasterCardView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.IsCashSelected = true
            self.IsMasterCardSelected = false
            self.ChangeCardInfo.isHidden = true
            self.SelectedEXP.text = ""
            self.Name.text = ""
            self.SelectedCardNumber.text = ""
            self.CardInfoView.isHidden = true
        }else{
            self.SelectedCashView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.SelectedFastPayView.backgroundColor = #colorLiteral(red: 0.06285511702, green: 0.06285511702, blue: 0.06285511702, alpha: 1)
            self.SelectedMasterCardView.backgroundColor = #colorLiteral(red: 0.1620929837, green: 0.4347665906, blue: 0.8148480654, alpha: 1)
            self.IsCashSelected = false
            self.IsMasterCardSelected = true
            self.ChangeCardInfo.isHidden = false
            self.SelectedEXP.text = UserDefaults.standard.string(forKey: "Expire") ?? ""
            self.Name.text = UserDefaults.standard.string(forKey: "CardName") ?? ""
            self.CardInfoView.isHidden = true
            let formattedText = formatTextWithMaskedDigits(UserDefaults.standard.string(forKey: "CardNumner") ?? "")
            SelectedCardNumber.text = formattedText
        }
        
        self.addDoneButtonOnKeyboard()
    }
    
    func formatTextWithMaskedDigits(_ text: String) -> String {
           guard text.count == 16 else { return text }
           
           var formattedText = ""
           let characters = Array(text)
           
           for (index, character) in characters.enumerated() {
               if index < 12 {
                   if index != 0 && index % 4 == 0 {
                       formattedText.append(" ")
                   }
                   formattedText.append("X")
               } else {
                   if index != 0 && index % 4 == 0 {
                       formattedText.append(" ")
                   }
                   formattedText.append(character)
               }
           }
           
           return formattedText
       }

    func addDoneButtonOnKeyboard(){
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            doneToolbar.barStyle = .default

            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()

        self.CardNumner.inputAccessoryView = doneToolbar
        self.EXPire.inputAccessoryView = doneToolbar
        self.CVV.inputAccessoryView = doneToolbar
        self.Name.inputAccessoryView = doneToolbar
        }

    @objc func doneButtonAction(){
        self.CardNumner.resignFirstResponder()
        self.EXPire.resignFirstResponder()
        self.CVV.resignFirstResponder()
        self.Name.resignFirstResponder()
    }
    
    var IsCashSelected = false
    @IBAction func Cash(_ sender: Any) {
        IsCashSelected = true
        IsMasterCardSelected = false
        self.SelectedCashView.backgroundColor = #colorLiteral(red: 0.1620929837, green: 0.4347665906, blue: 0.8148480654, alpha: 1)
        self.SelectedFastPayView.backgroundColor = #colorLiteral(red: 0.06285511702, green: 0.06285511702, blue: 0.06285511702, alpha: 1)
        self.SelectedMasterCardView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        IsChangeClicked = false
        UIView.animate(withDuration: 0.2) {
            self.CardInfoView.isHidden = true
            self.ChangeCardInfo.isHidden = true
            self.view.layoutIfNeeded()
        }
    }
    var IsMasterCardSelected = false
    @IBAction func MasterCarsd(_ sender: Any) {
        if UserDefaults.standard.string(forKey: "CardNumner") == "" || UserDefaults.standard.string(forKey: "CardNumner") == nil || UserDefaults.standard.string(forKey: "CardName") == ""{
            IsChangeClicked = true
            UIView.animate(withDuration: 0.2) {
                self.CardInfoView.isHidden = false
                self.view.layoutIfNeeded()
            }
        }
        IsMasterCardSelected = true
        IsCashSelected = false
        self.SelectedMasterCardView.backgroundColor = #colorLiteral(red: 0.1620929837, green: 0.4347665906, blue: 0.8148480654, alpha: 1)
        self.SelectedCashView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.SelectedFastPayView.backgroundColor = #colorLiteral(red: 0.06285511702, green: 0.06285511702, blue: 0.06285511702, alpha: 1)
        UIView.animate(withDuration: 0.2) {
            self.ChangeCardInfo.isHidden = false
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func FastPay(_ sender: Any) {
        self.SelectedFastPayView.backgroundColor = #colorLiteral(red: 0.1620929837, green: 0.4347665906, blue: 0.8148480654, alpha: 1)
        self.SelectedCashView.backgroundColor = #colorLiteral(red: 0.06285511702, green: 0.06285511702, blue: 0.06285511702, alpha: 1)
        self.SelectedMasterCardView.backgroundColor = #colorLiteral(red: 0.06285511702, green: 0.06285511702, blue: 0.06285511702, alpha: 1)
    }

    var contract_id = ""
    
    @IBOutlet weak var Buy: LoadingButton!
    
    
    func AlertMessage(){
        if XLanguage.get() == .English {
            let ac = UIAlertController(title: "Paymentation", message: "Your paymentation is successfully done", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                ac.dismiss(animated: true)
            }))
            self.Buy.hideLoader()
            self.present(ac, animated: true)
        } else if XLanguage.get() == .Kurdish {
            let ac = UIAlertController(title: "پارەدان", message: "پارەدانەکەت بە سەرکەوتوویی تەواو بوو", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "باشە", style: .default, handler: { _ in
                self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                ac.dismiss(animated: true)
            }))
            self.Buy.hideLoader()
            self.present(ac, animated: true)
        } else if XLanguage.get() == .Arabic {
            let ac = UIAlertController(title: "الدفع", message: "تم الدفع بنجاح", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "حسناً", style: .default, handler: { _ in
                self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                ac.dismiss(animated: true)
            }))
            self.Buy.hideLoader()
            self.present(ac, animated: true)
        } else if XLanguage.get() == .Hebrew {
            let ac = UIAlertController(title: "תשלום", message: "התשלום בוצע בהצלחה", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "אישור", style: .default, handler: { _ in
                self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                ac.dismiss(animated: true)
            }))
            self.Buy.hideLoader()
            self.present(ac, animated: true)
        } else if XLanguage.get() == .Chinese {
            let ac = UIAlertController(title: "付款", message: "您的付款已成功完成", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "确定", style: .default, handler: { _ in
                self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                ac.dismiss(animated: true)
            }))
            self.Buy.hideLoader()
            self.present(ac, animated: true)
        } else if XLanguage.get() == .Hindi {
            let ac = UIAlertController(title: "भुगतान", message: "आपका भुगतान सफलतापूर्वक हो गया है", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "ठीक है", style: .default, handler: { _ in
                self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                ac.dismiss(animated: true)
            }))
            self.Buy.hideLoader()
            self.present(ac, animated: true)
        } else if XLanguage.get() == .Portuguese {
            let ac = UIAlertController(title: "Pagamento", message: "O seu pagamento foi realizado com sucesso", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                ac.dismiss(animated: true)
            }))
            self.Buy.hideLoader()
            self.present(ac, animated: true)
        } else if XLanguage.get() == .Swedish {
            let ac = UIAlertController(title: "Betalning", message: "Din betalning har genomförts", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                ac.dismiss(animated: true)
            }))
            self.Buy.hideLoader()
            self.present(ac, animated: true)
        } else if XLanguage.get() == .Greek {
            let ac = UIAlertController(title: "Πληρωμή", message: "Η πληρωμή σας ολοκληρώθηκε επιτυχώς", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Εντάξει", style: .default, handler: { _ in
                self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                ac.dismiss(animated: true)
            }))
            self.Buy.hideLoader()
            self.present(ac, animated: true)
        } else if XLanguage.get() == .Russian {
            let ac = UIAlertController(title: "Оплата", message: "Ваш платеж успешно завершен", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "ОК", style: .default, handler: { _ in
                self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                ac.dismiss(animated: true)
            }))
            self.Buy.hideLoader()
            self.present(ac, animated: true)
        } else if XLanguage.get() == .Dutch {
            let ac = UIAlertController(title: "Betaling", message: "Uw betaling is succesvol voltooid", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                ac.dismiss(animated: true)
            }))
            self.Buy.hideLoader()
            self.present(ac, animated: true)
        } else if XLanguage.get() == .French {
            let ac = UIAlertController(title: "Paiement", message: "Votre paiement a été effectué avec succès", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                ac.dismiss(animated: true)
            }))
            self.Buy.hideLoader()
            self.present(ac, animated: true)
        } else if XLanguage.get() == .Spanish {
            let ac = UIAlertController(title: "Pago", message: "Su pago se ha realizado con éxito", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                ac.dismiss(animated: true)
            }))
            self.Buy.hideLoader()
            self.present(ac, animated: true)
        } else if XLanguage.get() == .German {
            let ac = UIAlertController(title: "Zahlung", message: "Ihre Zahlung wurde erfolgreich abgeschlossen", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                ac.dismiss(animated: true)
            }))
            self.Buy.hideLoader()
            self.present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Paymentation", message: "Your paymentation is successfully done", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                ac.dismiss(animated: true)
            }))
            self.Buy.hideLoader()
            self.present(ac, animated: true)
        }

    }
    
    

    func PayDone(complition : @escaping (_ lol: String)->()){
        let cardParams = STPCardParams()
        
        let dateStr = self.EXPire.text!
        let dateComponents = dateStr.components(separatedBy: "/")
        print("000000")
        if dateComponents.count == 2 {print("33333")
            if let month = UInt(dateComponents[0]), let year = UInt(dateComponents[1]) {print("5555")
                // Now you have month and year as UInt variables
                print("Month: \(month)")
                print("Year: \(year)")
                
                
                cardParams.number = self.CardNumner.text!
                cardParams.expMonth = month
                cardParams.expYear = year
                cardParams.cvc = self.CVV.text!
                
                STPAPIClient(publishableKey: "pk_test_51PQtprHKQnChzGMvjVRtunjpa2Iw2Ktela8YrnecBfsv47FLz4pRb6OnayR7ici8rinGYOw9spbbFynd0KcS9IT700AitKLg0P").createToken(withCard: cardParams) { token, error in
                    guard let token = token else {
                        print("Error creating token: \(error?.localizedDescription ?? "")")
                        let ac = UIAlertController(title: "Invalid Information", message: "Invalid information please try again in a few seconds", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                            self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                            ac.dismiss(animated: true)
                        }))
                        self.Buy.hideLoader()
                        self.present(ac, animated: true)
                        return
                    }
                    
                    // Send the token to your backend server to process the payment
                    print(token)
                    
                    let stringUrl = URL(string: API.URL);
                    let param: [String: Any] = [
                        "key":API.key,
                        "username":API.UserName,
                        "fun": "payment",
                        "token": token,
                        "full_name": self.Name.text!
                    ]
                    
                    AF.request(stringUrl!, method: .post, parameters: param).responseData { (response) in
                        switch response.result
                        {
                        case .success(_):
                            let jsonData = JSON(response.data ?? "")
                            print(jsonData)
                            complition("Done")
                        case .failure(let error):
                            print(error);
                        }
                    }
                    
                }
                
                
            } else {
                print("Invalid date components")
                let ac = UIAlertController(title: "Invalid Date Components", message: "Invalid date components, please write correct Date", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                    ac.dismiss(animated: true)
                }))
                self.Buy.hideLoader()
                self.present(ac, animated: true)
            }
        } else {
            print("Invalid date format")
            let ac = UIAlertController(title: "Invalid Date Components", message: "Invalid date components, please write correct Date", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                ac.dismiss(animated: true)
            }))
            self.Buy.hideLoader()
            self.present(ac, animated: true)
        }
        
        
    }
    
    @IBAction func Continue(_ sender: Any) {
        // ava agar user bkr byt
        if IsMasterCardSelected == true{
            if self.CardNumner.text?.trimmingCharacters(in: .whitespaces) != "" && self.EXPire.text?.trimmingCharacters(in: .whitespaces) != "" && self.CVV.text?.trimmingCharacters(in: .whitespaces) != "" && self.Name.text?.trimmingCharacters(in: .whitespaces) != ""{
                UserDefaults.standard.setValue(self.CardNumner.text, forKey: "CardNumner")
                UserDefaults.standard.setValue(self.EXPire.text, forKey: "Expire")
                UserDefaults.standard.setValue(self.Name.text, forKey: "CardName")
                UserDefaults.standard.setValue(self.CVV.text, forKey: "CVV")
                
                self.Buy.showLoader(userInteraction: true)
                if self.EstateData.office_id != UserDefaults.standard.string(forKey: "OfficeId") ?? ""{ print("haaaaat11")
                    
                        self.PayDone(){ _ in
                            self.Buy(buyer_id: UserDefaults.standard.string(forKey: "OfficeId") ?? "", seller_id: self.EstateData.office_id ?? "", estate_id: self.EstateData.id ?? ""){ _ in
                                self.AlertMessage()
                            }
                        }
                        
                    
                }else{// ava agar user froshyar byt byt
                    print("haaaaat")
                    guard let contract_id = UserDefaults.standard.string(forKey: "contract_id") else{return}
                    self.PayDone(){ _ in
                        ContracsObjectAip.SellAndArchiv(contract_id: contract_id, estate_id: self.EstateData.id ?? "") { lol in
                            self.AlertMessage()
                        }
                    }
                }
            }
        }else{
            self.Buy.showLoader(userInteraction: true)
            if self.EstateData.office_id != UserDefaults.standard.string(forKey: "OfficeId") ?? ""{ print("haaaaat11")
                self.Buy(buyer_id: UserDefaults.standard.string(forKey: "OfficeId") ?? "", seller_id: self.EstateData.office_id ?? "", estate_id: self.EstateData.id ?? ""){ _ in
                    self.AlertMessage()
                }
            }else{// ava agar user froshyar byt byt
                print("haaaaat")
                guard let contract_id = UserDefaults.standard.string(forKey: "contract_id") else{return}
                ContracsObjectAip.SellAndArchiv(contract_id: contract_id, estate_id: self.EstateData.id ?? "") { [self] lol in
                    self.AlertMessage()
                }
            }
        }
    }
    
    func Buy(buyer_id : String , seller_id : String,estate_id : String, complition : @escaping (_ lol: String)->()){
        if IsMasterCardSelected == true{
            if self.CardNumner.text?.trimmingCharacters(in: .whitespaces) != "" && self.EXPire.text?.trimmingCharacters(in: .whitespaces) != "" && self.CVV.text?.trimmingCharacters(in: .whitespaces) != ""{
                UserDefaults.standard.setValue(self.CardNumner.text, forKey: "CardNumner")
                UserDefaults.standard.setValue(self.EXPire.text, forKey: "Expire")
                UserDefaults.standard.setValue(self.CVV.text, forKey: "CVV")
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                let currentDate = Date()
                let formattedCurrentDate = dateFormatter.string(from: currentDate)
                
                let UUID = UUID().uuidString
                ContracsObject.init(id: UUID, buyer_id: buyer_id, contract_num: "", estate_id: estate_id, sell_date: "", seller_id: seller_id, archived: "0", buy_date: formattedCurrentDate).Upload()
                
                if let FireId = UserDefaults.standard.string(forKey: "UserId"){
                    OfficeAip.GetOfficeById(Id: FireId) { office in
                        
                        let stringUrl = URL(string: API.URL);
                        let param: [String: Any] = [
                            "key":API.key,
                            "username":API.UserName,
                            "fun": "generate_contract_pdf",
                            "date": formattedCurrentDate,
                            "contract_num": UUID,
                            "buyer_name": office.arabic_name ?? "",
                            "seller_name":"",
                            "buyer_phone":office.phone1 ?? "",
                            "seller_phone":"",
                            "buyer_sign":office.contract_image ?? "",
                            "seller_sign":""
                        ]
                        print("]]]]]]]][[[[[[[[[[")
                        AF.request(stringUrl!, method: .post, parameters: param).responseData { (response) in
                            switch response.result
                            {
                            case .success(_):
                                let jsonData = JSON(response.data ?? "")
                                print("]]]]]]]][[[[[[[[[[1111-------")
                                print(jsonData)
                                complition("Done")
                                
                            case .failure(let error):
                                print(error);
                            }
                        }
                        
                    }
                }
                
            }
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            let currentDate = Date()
            let formattedCurrentDate = dateFormatter.string(from: currentDate)
            
            let UUID = UUID().uuidString
            ContracsObject.init(id: UUID, buyer_id: buyer_id, contract_num: "", estate_id: estate_id, sell_date: "", seller_id: seller_id, archived: "0", buy_date: formattedCurrentDate).Upload()
            
            if let FireId = UserDefaults.standard.string(forKey: "UserId"){
                OfficeAip.GetOfficeById(Id: FireId) { office in
                    
                    let stringUrl = URL(string: API.URL);
                    let param: [String: Any] = [
                        "key":API.key,
                        "username":API.UserName,
                        "fun": "generate_contract_pdf",
                        "date": formattedCurrentDate,
                        "contract_num": UUID,
                        "buyer_name": office.arabic_name ?? "",
                        "seller_name":"",
                        "buyer_phone":office.phone1 ?? "",
                        "seller_phone":"",
                        "buyer_sign":office.contract_image ?? "",
                        "seller_sign":""
                    ]
                    
                    AF.request(stringUrl!, method: .post, parameters: param).responseData { (response) in
                        switch response.result
                        {
                        case .success(_):
                            let jsonData = JSON(response.data ?? "")
                            print(jsonData)
                            complition("Done")
                            
                        case .failure(let error):
                            print(error);
                        }
                    }
                    
                }
            }
        }
    }
    
    
    
}

