//
//  XLanguages.swift
//  rollTest
//
//  Created by Botan Amedi on 18/01/2021.
//

import UIKit

class XLanguage {
    
    enum LanguageEnum : String {
        case English
        case Kurdish
        case Arabic
        case Hebrew
        case Chinese
        case Hindi
        case Portuguese
        case Swedish
        case Greek
        case Russian
        case Dutch
        case French
        case Spanish
        case German
        case none
    }
    
    
    static func set(Language : LanguageEnum){
        UserDefaults.standard.set(Language.rawValue, forKey: "lang")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)
    }
    static func get()->LanguageEnum{
        if let lang = UserDefaults.standard.value(forKey: "lang") as? String{
            if lang == "Arabic"{
                return .Arabic
            }else if lang == "Kurdish"{
                return .Kurdish
            }else if lang == "English"{
                return .English
            } else if lang == "German"{
                return .German
            }else if lang == "Spanish"{
                return .Spanish
            }else if lang == "French"{
                return .French
            }else if lang == "Dutch"{
                return .Dutch
            }else if lang == "Russian"{
                return .Russian
            }else if lang == "Greek"{
                return .Greek
            }else if lang == "Swedish"{
                return .Swedish
            }else if lang == "Portuguese"{
                return .Portuguese
            }else if lang == "Hindi"{
                return .Hindi
            }else if lang == "Chinese"{
                return .Chinese
            }else if lang == "Hebrew"{
                return .Hebrew
            }
        }
        return .none
    }
    
    
}



class Languagebutton: UIButton{
    @IBInspectable var ArabicTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var KurdishTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var EnglishTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var GermanTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var SpanishTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var FrenchTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var DutchTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var RussianTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var GreekTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var SwedishTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var PortugueseTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var HindiTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var ChineseTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var HebrewTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }

    // Text properties

    @IBInspectable var ArabicText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var KurdishText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var EnglishText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var GermanText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var SpanishText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var FrenchText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var DutchText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var RussianText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var GreekText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var SwedishText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var PortugueseText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var HindiText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var ChineseText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var HebrewText : String = ""{
        didSet{
            update()
        }
    }

    
    @objc func update(){
        
        if XLanguage.get() == .Arabic{
            self.setTitle(self.ArabicText , for: .normal)
            self.titleLabel?.font = UIFont(name: "PeshangDes2", size: ArabicTextSize)!
        }else if XLanguage.get() == .Kurdish{
            self.setTitle(self.KurdishText , for: .normal)
            self.titleLabel?.font = UIFont(name: "PeshangDes2", size: KurdishTextSize)!
        }else if XLanguage.get() == .English{
            self.setTitle(self.EnglishText , for: .normal)
            self.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: EnglishTextSize)!
        }else if XLanguage.get() == .German{
            self.setTitle(self.GermanText , for: .normal)
            self.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: GermanTextSize)!
        }else if XLanguage.get() == .Spanish{
            self.setTitle(self.SpanishText , for: .normal)
            self.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: SpanishTextSize)!
        }else if XLanguage.get() == .French{
            self.setTitle(self.FrenchText , for: .normal)
            self.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: FrenchTextSize)!
        }else if XLanguage.get() == .Dutch{
            self.setTitle(self.DutchText , for: .normal)
            self.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: DutchTextSize)!
        }else if XLanguage.get() == .Russian{
            self.setTitle(self.RussianText , for: .normal)
            self.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: RussianTextSize)!
        }else if XLanguage.get() == .Greek{
            self.setTitle(self.GreekText , for: .normal)
            self.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: GreekTextSize)!
        }else if XLanguage.get() == .Swedish{
            self.setTitle(self.SwedishText , for: .normal)
            self.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: SwedishTextSize)!
        }else if XLanguage.get() == .Portuguese{
            self.setTitle(self.PortugueseText , for: .normal)
            self.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: PortugueseTextSize)!
        }else if XLanguage.get() == .Hindi{
            self.setTitle(self.HindiText , for: .normal)
            self.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: HindiTextSize)!
        }else if XLanguage.get() == .Chinese{
            self.setTitle(self.ChineseText , for: .normal)
            self.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: ChineseTextSize)!
        }else if XLanguage.get() == .Hebrew{
            self.setTitle(self.HebrewText , for: .normal)
            self.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: HebrewTextSize)!
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(Languagebutton.update), name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)
    }
}





class LanguageTabBarItem: UITabBarItem{
    
    
    @IBInspectable var ArabicTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var KurdishTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var EnglishTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var GermanTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var SpanishTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var FrenchTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var DutchTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var RussianTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var GreekTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var SwedishTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var PortugueseTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var HindiTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var ChineseTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var HebrewTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
   
    // Text properties

    @IBInspectable var ArabicText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var KurdishText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var EnglishText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var GermanText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var SpanishText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var FrenchText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var DutchText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var RussianText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var GreekText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var SwedishText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var PortugueseText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var HindiText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var ChineseText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var HebrewText : String = ""{
        didSet{
            update()
        }
    }

    @objc func update(){
        
        if XLanguage.get() == .Arabic{
            self.title = ArabicText
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "PeshangDes2", size: ArabicTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
        }else if XLanguage.get() == .Kurdish{
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "PeshangDes2", size: ArabicTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
            self.title = KurdishText
        }else if XLanguage.get() == .English{
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: EnglishTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
            self.title = EnglishText
        }else if XLanguage.get() == .German{
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: GermanTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
            self.title = GermanText
        }else if XLanguage.get() == .Spanish{
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: SpanishTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
            self.title = SpanishText
        }else if XLanguage.get() == .French{
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: FrenchTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
            self.title = FrenchText
        }else if XLanguage.get() == .Dutch{
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: DutchTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
            self.title = DutchText
        }else if XLanguage.get() == .Russian{
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: RussianTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
            self.title = RussianText
        }else if XLanguage.get() == .Greek{
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: GreekTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
            self.title = GreekText
        }else if XLanguage.get() == .Swedish{
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: SwedishTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
            self.title = SwedishText
        }else if XLanguage.get() == .Portuguese{
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: PortugueseTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
            self.title = PortugueseText
        }else if XLanguage.get() == .Hindi{
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: HindiTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
            self.title = HindiText
        }else if XLanguage.get() == .Chinese{
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: ChineseTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
            self.title = ChineseText
        }else if XLanguage.get() == .Hebrew{
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: HebrewTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
            self.title = HebrewText
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(LanguageTabBarItem.update), name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)
    }
}




class LanguageLable: UILabel{
    
    @IBInspectable var ArabicTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var KurdishTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var EnglishTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var GermanTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var SpanishTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var FrenchTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var DutchTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var RussianTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var GreekTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var SwedishTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var PortugueseTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var HindiTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var ChineseTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var HebrewTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }

    // Text properties

    @IBInspectable var ArabicText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var KurdishText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var EnglishText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var GermanText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var SpanishText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var FrenchText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var DutchText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var RussianText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var GreekText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var SwedishText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var PortugueseText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var HindiText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var ChineseText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var HebrewText : String = ""{
        didSet{
            update()
        }
    }

    
    @objc func update(){

        if XLanguage.get() == .Arabic{
            self.text = ArabicText
            self.font = UIFont(name: "PeshangDes2", size: ArabicTextSize)!
        }else if XLanguage.get() == .Kurdish{
            self.text = KurdishText
            self.font = UIFont(name: "PeshangDes2", size: ArabicTextSize)!
        }else if XLanguage.get() == .English{
            self.text = EnglishText
            self.font = UIFont(name: "ArialRoundedMTBold", size: EnglishTextSize)!
        }else if XLanguage.get() == .German{
            self.text = GermanText
            self.font = UIFont(name: "ArialRoundedMTBold", size: GermanTextSize)!
        }else if XLanguage.get() == .Spanish{
            self.text = SpanishText
            self.font = UIFont(name: "ArialRoundedMTBold", size: SpanishTextSize)!
        }else if XLanguage.get() == .French{
            self.text = FrenchText
            self.font = UIFont(name: "ArialRoundedMTBold", size: FrenchTextSize)!
        }else if XLanguage.get() == .Dutch{
            self.text = DutchText
            self.font = UIFont(name: "ArialRoundedMTBold", size: DutchTextSize)!
        }else if XLanguage.get() == .Russian{
            self.text = RussianText
            self.font = UIFont(name: "ArialRoundedMTBold", size: RussianTextSize)!
        }else if XLanguage.get() == .Greek{
            self.text = GreekText
            self.font = UIFont(name: "ArialRoundedMTBold", size: GreekTextSize)!
        }else if XLanguage.get() == .Swedish{
            self.text = SwedishText
            self.font = UIFont(name: "ArialRoundedMTBold", size: SwedishTextSize)!
        }else if XLanguage.get() == .Portuguese{
            self.text = PortugueseText
            self.font = UIFont(name: "ArialRoundedMTBold", size: PortugueseTextSize)!
        }else if XLanguage.get() == .Hindi{
            self.text = HindiText
            self.font = UIFont(name: "ArialRoundedMTBold", size: HindiTextSize)!
        }else if XLanguage.get() == .Chinese{
            self.text = ChineseText
            self.font = UIFont(name: "ArialRoundedMTBold", size: ChineseTextSize)!
        }else if XLanguage.get() == .Hebrew{
            self.text = HebrewText
            self.font = UIFont(name: "ArialRoundedMTBold", size: HebrewTextSize)!
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(LanguageLable.update), name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)
    }
}



class LanguagePlaceHolder: UITextField{
    
    
    @IBInspectable var ArabicTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var KurdishTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var EnglishTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var GermanTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var SpanishTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var FrenchTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var DutchTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var RussianTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var GreekTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var SwedishTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var PortugueseTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var HindiTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var ChineseTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var HebrewTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }

    // Text properties

    @IBInspectable var ArabicText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var KurdishText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var EnglishText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var GermanText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var SpanishText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var FrenchText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var DutchText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var RussianText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var GreekText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var SwedishText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var PortugueseText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var HindiText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var ChineseText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var HebrewText : String = ""{
        didSet{
            update()
        }
    }

    
    @objc func update(){
        
        if XLanguage.get() == .Arabic{
            self.placeholder = ArabicText
            self.font = UIFont(name: "PeshangDes2", size: ArabicTextSize)!
        }else if XLanguage.get() == .Kurdish{
            self.placeholder = KurdishText
            self.font = UIFont(name: "PeshangDes2", size: ArabicTextSize)!
        }else if XLanguage.get() == .English{
            self.placeholder = EnglishText
            self.font = UIFont(name: "ArialRoundedMTBold", size: EnglishTextSize)!
        }else if XLanguage.get() == .German{
            self.placeholder = GermanText
            self.font = UIFont(name: "ArialRoundedMTBold", size: GermanTextSize)!
        }else if XLanguage.get() == .Spanish{
            self.placeholder = SpanishText
            self.font = UIFont(name: "ArialRoundedMTBold", size: SpanishTextSize)!
        }else if XLanguage.get() == .French{
            self.placeholder = FrenchText
            self.font = UIFont(name: "ArialRoundedMTBold", size: FrenchTextSize)!
        }else if XLanguage.get() == .Dutch{
            self.placeholder = DutchText
            self.font = UIFont(name: "ArialRoundedMTBold", size: DutchTextSize)!
        }else if XLanguage.get() == .Russian{
            self.placeholder = RussianText
            self.font = UIFont(name: "ArialRoundedMTBold", size: RussianTextSize)!
        }else if XLanguage.get() == .Greek{
            self.placeholder = GreekText
            self.font = UIFont(name: "ArialRoundedMTBold", size: GreekTextSize)!
        }else if XLanguage.get() == .Swedish{
            self.placeholder = SwedishText
            self.font = UIFont(name: "ArialRoundedMTBold", size: SwedishTextSize)!
        }else if XLanguage.get() == .Portuguese{
            self.placeholder = PortugueseText
            self.font = UIFont(name: "ArialRoundedMTBold", size: PortugueseTextSize)!
        }else if XLanguage.get() == .Hindi{
            self.placeholder = HindiText
            self.font = UIFont(name: "ArialRoundedMTBold", size: HindiTextSize)!
        }else if XLanguage.get() == .Chinese{
            self.placeholder = ChineseText
            self.font = UIFont(name: "ArialRoundedMTBold", size: ChineseTextSize)!
        }else if XLanguage.get() == .Hebrew{
            self.placeholder = HebrewText
            self.font = UIFont(name: "ArialRoundedMTBold", size: HebrewTextSize)!
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(LanguagePlaceHolder.update), name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)
    }
}



class LanguageNvigationItem: UINavigationItem{
    

    @IBInspectable var ArabicText: String = "" {
        didSet {
            update()
        }
    }
    @IBInspectable var KurdishText: String = "" {
        didSet {
            update()
        }
    }
    @IBInspectable var EnglishText: String = "" {
        didSet {
            update()
        }
    }
    @IBInspectable var GermanText: String = "" {
        didSet {
            update()
        }
    }
    @IBInspectable var SpanishText: String = "" {
        didSet {
            update()
        }
    }
    @IBInspectable var FrenchText: String = "" {
        didSet {
            update()
        }
    }
    @IBInspectable var DutchText: String = "" {
        didSet {
            update()
        }
    }
    @IBInspectable var RussianText: String = "" {
        didSet {
            update()
        }
    }
    @IBInspectable var GreekText: String = "" {
        didSet {
            update()
        }
    }
    @IBInspectable var SwedishText: String = "" {
        didSet {
            update()
        }
    }
    @IBInspectable var PortugueseText: String = "" {
        didSet {
            update()
        }
    }
    @IBInspectable var HindiText: String = "" {
        didSet {
            update()
        }
    }
    @IBInspectable var ChineseText: String = "" {
        didSet {
            update()
        }
    }
    @IBInspectable var HebrewText: String = "" {
        didSet {
            update()
        }
    }

    
    @objc func update(){
        if XLanguage.get() == .Arabic {
            self.title = ArabicText
        } else if XLanguage.get() == .Kurdish {
            self.title = KurdishText
        } else if XLanguage.get() == .English {
            self.title = EnglishText
        } else if XLanguage.get() == .German {
            self.title = GermanText
        } else if XLanguage.get() == .Spanish {
            self.title = SpanishText
        } else if XLanguage.get() == .French {
            self.title = FrenchText
        } else if XLanguage.get() == .Dutch {
            self.title = DutchText
        } else if XLanguage.get() == .Russian {
            self.title = RussianText
        } else if XLanguage.get() == .Greek {
            self.title = GreekText
        } else if XLanguage.get() == .Swedish {
            self.title = SwedishText
        } else if XLanguage.get() == .Portuguese {
            self.title = PortugueseText
        } else if XLanguage.get() == .Hindi {
            self.title = HindiText
        } else if XLanguage.get() == .Chinese {
            self.title = ChineseText
        } else if XLanguage.get() == .Hebrew {
            self.title = HebrewText
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(LanguageNvigationItem.update), name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)
    }
}


class LanguageBarItem: UIBarButtonItem{
    
    
    @IBInspectable var ArabicTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var KurdishTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var EnglishTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var GermanTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var SpanishTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var FrenchTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var DutchTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var RussianTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var GreekTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var SwedishTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var PortugueseTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var HindiTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var ChineseTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var HebrewTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }

    // Text properties

    @IBInspectable var ArabicText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var KurdishText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var EnglishText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var GermanText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var SpanishText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var FrenchText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var DutchText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var RussianText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var GreekText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var SwedishText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var PortugueseText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var HindiText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var ChineseText : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var HebrewText : String = ""{
        didSet{
            update()
        }
    }

    
    @objc func update(){
        
        if XLanguage.get() == .Arabic{
            self.title = ArabicText
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "PeshangDes2", size: ArabicTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
        }else if XLanguage.get() == .Kurdish{
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "PeshangDes2", size: ArabicTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
            self.title = KurdishText
        }else if XLanguage.get() == .English{
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: EnglishTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
            self.title = EnglishText
        }else if XLanguage.get() == .German{
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: GermanTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
            self.title = GermanText
        }else if XLanguage.get() == .Spanish{
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: SpanishTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
            self.title = SpanishText
        }else if XLanguage.get() == .French{
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: FrenchTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
            self.title = FrenchText
        }else if XLanguage.get() == .Dutch{
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: DutchTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
            self.title = DutchText
        }else if XLanguage.get() == .Russian{
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: RussianTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
            self.title = RussianText
        }else if XLanguage.get() == .Greek{
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: GreekTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
            self.title = GreekText
        }else if XLanguage.get() == .Swedish{
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: SwedishTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
            self.title = SwedishText
        }else if XLanguage.get() == .Portuguese{
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: PortugueseTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
            self.title = PortugueseText
        }else if XLanguage.get() == .Hindi{
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: HindiTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
            self.title = HindiText
        }else if XLanguage.get() == .Chinese{
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: ChineseTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
            self.title = ChineseText
        }else if XLanguage.get() == .Hebrew{
            self.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: HebrewTextSize)!,
                    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
                ], for: .normal)
            self.title = HebrewText
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(LanguageBarItem.update), name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)
}
}








class NavigationBarLang: UINavigationBar{
    
    
    @IBInspectable var ArabicTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var KurdishTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var EnglishTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var GermanTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var SpanishTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var FrenchTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var DutchTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var RussianTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var GreekTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var SwedishTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var PortugueseTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var HindiTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var ChineseTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }
    @IBInspectable var HebrewTextSize : CGFloat = 0{
        didSet{
            update()
        }
    }

    
    @objc func update(){
        
        if XLanguage.get() == .Arabic{
            self.titleTextAttributes =
            [
                NSAttributedString.Key.font: UIFont(name: "PeshangDes2", size: ArabicTextSize)!,
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
            ]
        }else if XLanguage.get() == .Kurdish{
            self.titleTextAttributes =
            [
                NSAttributedString.Key.font: UIFont(name: "PeshangDes2", size: ArabicTextSize)!,
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
            ]
        }else if XLanguage.get() == .English{
            self.titleTextAttributes =
            [
                NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: EnglishTextSize)!,
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
            ]
        }else if XLanguage.get() == .German{
            self.titleTextAttributes =
            [
                NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: GermanTextSize)!,
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
            ]
        }else if XLanguage.get() == .Spanish{
            self.titleTextAttributes =
            [
                NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: SpanishTextSize)!,
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
            ]
        }else if XLanguage.get() == .French{
            self.titleTextAttributes =
            [
                NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: FrenchTextSize)!,
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
            ]
        }else if XLanguage.get() == .Dutch{
            self.titleTextAttributes =
            [
                NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: DutchTextSize)!,
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
            ]
        }else if XLanguage.get() == .Russian{
            self.titleTextAttributes =
            [
                NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: RussianTextSize)!,
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
            ]
        }else if XLanguage.get() == .Greek{
            self.titleTextAttributes =
            [
                NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: GreekTextSize)!,
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
            ]
        }else if XLanguage.get() == .Swedish{
            self.titleTextAttributes =
            [
                NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: SwedishTextSize)!,
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
            ]
        }else if XLanguage.get() == .Portuguese{
            self.titleTextAttributes =
            [
                NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: PortugueseTextSize)!,
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
            ]
        }else if XLanguage.get() == .Hindi{
            self.titleTextAttributes =
            [
                NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: HindiTextSize)!,
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
            ]
        }else if XLanguage.get() == .Chinese{
            self.titleTextAttributes =
            [
                NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: ChineseTextSize)!,
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
            ]
        }else if XLanguage.get() == .Hebrew{
            self.titleTextAttributes =
            [
                NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: HebrewTextSize)!,
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.07560480386, green: 0.2257080078, blue: 0.3554315865, alpha: 1)
            ]
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(NavigationBarLang.update), name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)
    }
}








class LanguageSegment: UISegmentedControl{
    
    @IBInspectable var ArabicText0 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var ArabicText1 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var KurdishText0 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var KurdishText1 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var EnglishText0 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var EnglishText1 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var GermanText0 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var GermanText1 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var SpanishText0 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var SpanishText1 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var FrenchText0 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var FrenchText1 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var DutchText0 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var DutchText1 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var RussianText0 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var RussianText1 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var GreekText0 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var GreekText1 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var SwedishText0 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var SwedishText1 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var PortugueseText0 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var PortugueseText1 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var HindiText0 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var HindiText1 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var ChineseText0 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var ChineseText1 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var HebrewText0 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var HebrewText1 : String = ""{
        didSet{
            update()
        }
    }
    @IBInspectable var BelgianText0 : String = ""{
        didSet{
            update()
        }
    }


    
    @objc func update(){
        
        if XLanguage.get() == .Arabic {
            self.setTitle(ArabicText0, forSegmentAt: 0)
            self.setTitle(ArabicText1, forSegmentAt: 1)
        } else if XLanguage.get() == .Kurdish {
            self.setTitle(KurdishText0, forSegmentAt: 0)
            self.setTitle(KurdishText1, forSegmentAt: 1)
        } else if XLanguage.get() == .English {
            self.setTitle(EnglishText0, forSegmentAt: 0)
            self.setTitle(EnglishText1, forSegmentAt: 1)
        }
        else if XLanguage.get() == .German {
            self.setTitle(GermanText0, forSegmentAt: 0)
            self.setTitle(GermanText1, forSegmentAt: 1)
        }
        else if XLanguage.get() == .Spanish {
            self.setTitle(SpanishText0, forSegmentAt: 0)
            self.setTitle(SpanishText1, forSegmentAt: 1)
        }
        else if XLanguage.get() == .French {
            self.setTitle(FrenchText0, forSegmentAt: 0)
            self.setTitle(FrenchText1, forSegmentAt: 1)
        }
        else if XLanguage.get() == .Dutch {
            self.setTitle(DutchText0, forSegmentAt: 0)
            self.setTitle(DutchText1, forSegmentAt: 1)
        }
        else if XLanguage.get() == .Russian {
            self.setTitle(RussianText0, forSegmentAt: 0)
            self.setTitle(RussianText1, forSegmentAt: 1)
        }
        else if XLanguage.get() == .Greek {
            self.setTitle(GreekText0, forSegmentAt: 0)
            self.setTitle(GreekText1, forSegmentAt: 1)
        }
        else if XLanguage.get() == .Swedish {
            self.setTitle(SwedishText0, forSegmentAt: 0)
            self.setTitle(SwedishText1, forSegmentAt: 1)
        }
        else if XLanguage.get() == .Portuguese {
            self.setTitle(PortugueseText0, forSegmentAt: 0)
            self.setTitle(PortugueseText1, forSegmentAt: 1)
        }
        else if XLanguage.get() == .Hindi {
            self.setTitle(HindiText0, forSegmentAt: 0)
            self.setTitle(HindiText1, forSegmentAt: 1)
        }
        else if XLanguage.get() == .Chinese {
            self.setTitle(ChineseText0, forSegmentAt: 0)
            self.setTitle(ChineseText1, forSegmentAt: 1)
        }
        else if XLanguage.get() == .Hebrew {
            self.setTitle(HebrewText0, forSegmentAt: 0)
            self.setTitle(HebrewText1, forSegmentAt: 1)
        }
      
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(LanguageSegment.update), name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)
}
}

