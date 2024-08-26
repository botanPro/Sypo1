//
//  MyEstatesVc.swift
//  RealEstates
//
//  Created by botan pro on 6/15/22.
//

import UIKit
import CRRefresh
class MyEstatesVc: UIViewController {

    
    @IBOutlet weak var IndecatorView: UIView!
    var ProductArray : [EstateObject] = []
    @IBOutlet weak var TableView: UITableView!{didSet{self.TableView.delegate = self; self.TableView.dataSource = self }}
    @IBOutlet weak var InternetViewHeight: NSLayoutConstraint!
    @IBOutlet weak var InternetConnectionView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        GetMyEstates()
        self.InternetViewHeight.constant = 0
        self.InternetConnectionView.isHidden = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        if XLanguage.get() == .English{
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 16)!,.foregroundColor: #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)]

        }else if XLanguage.get() == .Arabic{
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "PeshangDes2", size: 16)!,.foregroundColor: #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)]

        }else if XLanguage.get() == .Kurdish{
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "PeshangDes2", size: 16)!,.foregroundColor: #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)]
        }
        
        
        self.navigationController?.navigationItem.backButtonTitle = ""
        TableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.EstateInserted), name: NSNotification.Name(rawValue: "EstateInserted"), object: nil)
        
        self.TableView.cr.addHeadRefresh(animator: FastAnimator()) {
            self.GetMyEstates()
        }
    }
    
    

    
    func GetMyEstates(){
        self.ProductArray.removeAll()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.TableView.cr.endHeaderRefresh()
        }
        if let officeId = UserDefaults.standard.string(forKey: "OfficeId"){
            ProductAip.GetMyEstates(office_id: officeId ) { estates in
                if estates.archived != "1"{
                    self.ProductArray.append(estates)
                }
                UIView.animate(withDuration: 0.2, delay: 0.0) {
                    self.IndecatorView.isHidden = true
                }
                self.TableView.reloadData()
            }
        }
    }
    
    
    
    @objc func EstateInserted(){
        UIView.animate(withDuration: 0.2, delay: 0.0) {
            self.IndecatorView.isHidden = false
        }
        GetMyEstates()
    }
    
    
    
    
    var Messagee = ""
    var Actionn = ""
    var Title = ""
    var message = ""
    var action = ""
    var cancel = ""
    
    
    @objc func remov(sender : UIButton){
        if CheckInternet.Connection(){
            UIView.animate(withDuration: 0.3) {
                self.InternetViewHeight.constant = 0
                self.InternetConnectionView.isHidden = true
                self.view.layoutIfNeeded()
            }
            
            
        if XLanguage.get() == .Kurdish{
            self.Title = "لابردن"
            self.message = "ئایا دڵنیای کە دەتەوێت ئەم خانوبەرە لە فرۆشتن لاببەیت؟"
            self.action = "دڵنیام"
            self.cancel = "نەخێر"
        }else if XLanguage.get() == .Arabic{
            self.Title = "الحذف"
            self.message = "هل أنت متأكد أنك تريد إزالة هذا العنصر من البيع؟"
            self.action = "متأكد"
            self.cancel = "لا"
        }else if XLanguage.get() == .English {
            self.Title = "Remove"
            self.message = "Are you sure you want to remove this item from sale?"
            self.action = "I'm sure"
            self.cancel = "Cancel"
        } else if XLanguage.get() == .Dutch {
            self.Title = "Verwijderen"
            self.message = "Weet u zeker dat u dit item uit de verkoop wilt halen?"
            self.action = "Ik ben zeker"
            self.cancel = "Annuleren"
        } else if XLanguage.get() == .French {
            self.Title = "Retirer"
            self.message = "Êtes-vous sûr de vouloir retirer cet article de la vente?"
            self.action = "Je suis sûr"
            self.cancel = "Annuler"
        } else if XLanguage.get() == .Spanish {
            self.Title = "Eliminar"
            self.message = "¿Estás seguro de que quieres quitar este artículo de la venta?"
            self.action = "Estoy seguro"
            self.cancel = "Cancelar"
        } else if XLanguage.get() == .German {
            self.Title = "Entfernen"
            self.message = "Sind Sie sicher, dass Sie diesen Artikel aus dem Verkauf entfernen möchten?"
            self.action = "Ich bin sicher"
            self.cancel = "Abbrechen"
        } else if XLanguage.get() == .Hebrew {
            self.Title = "הסר"
            self.message = "האם אתה בטוח שברצונך להסיר פריט זה מהמכירה?"
            self.action = "אני בטוח"
            self.cancel = "ביטול"
        } else if XLanguage.get() == .Chinese {
            self.Title = "移除"
            self.message = "您确定要将此商品从销售中移除吗？"
            self.action = "我确定"
            self.cancel = "取消"
        } else if XLanguage.get() == .Hindi {
            self.Title = "निकालें"
            self.message = "क्या आप वाकई इस वस्तु को बिक्री से हटाना चाहते हैं?"
            self.action = "मुझे यकीन है"
            self.cancel = "रद्द करें"
        } else if XLanguage.get() == .Portuguese {
            self.Title = "Remover"
            self.message = "Tem certeza de que deseja remover este item da venda?"
            self.action = "Tenho certeza"
            self.cancel = "Cancelar"
        } else if XLanguage.get() == .Russian {
            self.Title = "Удалить"
            self.message = "Вы уверены, что хотите удалить этот товар из продажи?"
            self.action = "Я уверен"
            self.cancel = "Отмена"
        }
        
        
        let myAlert = UIAlertController(title: self.Title, message: self.message, preferredStyle: UIAlertController.Style.alert)
        myAlert.addAction(UIAlertAction(title: self.action, style: .default, handler: { (UIAlertAction) in
            ProductAip.Remov(id: sender.accessibilityIdentifier!) { _ in }
            self.ProductArray.remove(at: (sender.accessibilityHint! as NSString).integerValue)
            self.TableView.reloadData()
            
            FavoriteItemsObjectAip.GetAllFavorites { estates in
                for i in estates{
                    if sender.accessibilityIdentifier! == i.estate_id{
                        FavoriteItemsObject.init(fire_id: "", estate_id: "", id: i.id ?? "").Remov()
                    }
                }
            }
            
            ViewdItemsObjectAip.GetAllViewd { estates in
                for i in estates{
                    if sender.accessibilityIdentifier! == i.estate_id{
                        ViewdItemsObject.init(fire_id: "", estate_id: "", id: i.id ?? "").Remov()
                    }
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "EstateInserted"), object: nil)
        }))
        myAlert.addAction(UIAlertAction(title: self.cancel, style: .cancel, handler: nil))
        self.present(myAlert, animated: true, completion: nil)
        }else{
            UIView.animate(withDuration: 0.3) {
                self.InternetViewHeight.constant = 20
                self.InternetConnectionView.isHidden = false
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    @objc func edit(sender : UIButton){
        for i in ProductArray{
            if i.id == sender.accessibilityValue{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let myVC = storyboard.instantiateViewController(withIdentifier: "AddEstatesVC") as! AddProperty
                myVC.CommingEstate = i
                self.navigationController?.pushViewController(myVC, animated: true)
            }
        }
    }
    
    
    
    
    @objc func Sold(sender : UIButton){
        for i in ProductArray{
            if i.id == sender.accessibilityIdentifier{
                if XLanguage.get() == .Kurdish{
                    self.Title = ""
                    self.message = "ئایا دڵنیای کە ئەم خانوبەرە فرۆشراوە؟"
                    self.action = "دڵنیام"
                    self.cancel = "نەخێر"
                }else if XLanguage.get() == .Arabic{
                    self.Title = ""
                    self.message = "هل أنت متأكد من أنه تم بيع هذه العقار؟"
                    self.action = "متأكد"
                    self.cancel = "لا"
                }else if XLanguage.get() == .English {
                    self.Title = ""
                    self.message = "Are you sure that this estate has been sold?"
                    self.action = "I'm sure"
                    self.cancel = "Cancel"
                } else if XLanguage.get() == .Dutch {
                    self.Title = ""
                    self.message = "Weet u zeker dat dit vastgoed is verkocht?"
                    self.action = "Ik ben zeker"
                    self.cancel = "Annuleren"
                } else if XLanguage.get() == .French {
                    self.Title = ""
                    self.message = "Êtes-vous sûr que ce bien a été vendu?"
                    self.action = "Je suis sûr"
                    self.cancel = "Annuler"
                } else if XLanguage.get() == .Spanish {
                    self.Title = ""
                    self.message = "¿Estás seguro de que esta propiedad ha sido vendida?"
                    self.action = "Estoy seguro"
                    self.cancel = "Cancelar"
                } else if XLanguage.get() == .German {
                    self.Title = ""
                    self.message = "Sind Sie sicher, dass diese Immobilie verkauft wurde?"
                    self.action = "Ich bin sicher"
                    self.cancel = "Abbrechen"
                } else if XLanguage.get() == .Hebrew {
                    self.Title = ""
                    self.message = "האם אתה בטוח שהנכס הזה נמכר?"
                    self.action = "אני בטוח"
                    self.cancel = "בטל"
                } else if XLanguage.get() == .Chinese {
                    self.Title = ""
                    self.message = "您确定这个房产已经售出了吗？"
                    self.action = "我确定"
                    self.cancel = "取消"
                } else if XLanguage.get() == .Hindi {
                    self.Title = ""
                    self.message = "क्या आप सुनिश्चित हैं कि यह संपत्ति बेच दी गई है?"
                    self.action = "मुझे यकीन है"
                    self.cancel = "रद्द करें"
                } else if XLanguage.get() == .Portuguese {
                    self.Title = ""
                    self.message = "Tem certeza de que este imóvel foi vendido?"
                    self.action = "Tenho certeza"
                    self.cancel = "Cancelar"
                } else if XLanguage.get() == .Russian {
                    self.Title = ""
                    self.message = "Вы уверены, что этот объект недвижимости был продан?"
                    self.action = "Я уверен"
                    self.cancel = "Отмена"
                }
                let myAlert = UIAlertController(title: self.Title, message: self.message, preferredStyle: UIAlertController.Style.alert)
                myAlert.addAction(UIAlertAction(title: self.action, style: .default, handler: { (UIAlertAction) in
                    ProductAip.updateState(i.id ?? "", sold: "1") { _ in }
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "EstateInserted"), object: nil)
                }))
                myAlert.addAction(UIAlertAction(title: self.cancel, style: .cancel, handler: nil))
                self.present(myAlert, animated: true, completion: nil)
            }
        }
    }
    
    
    
    var IsViewd = false
    func InsertViewdItem(id : String){
        if let FireId = UserDefaults.standard.string(forKey: "UserId"){
            self.IsViewd = false
            ViewdItemsObjectAip.GeViewdItemsById(fire_id: FireId) { item in
                
                for i in item{
                    print("CurrentEstateId : \(id)")
                    print("ViewdEstateId : \(i.estate_id ?? "")")
                    
                    print("CurrentFireId : \(FireId)")
                    print("ViewdFireId : \(i.fire_id ?? "")")
                    if i.estate_id == id && FireId == i.fire_id{
                        print("Item is Viewd")
                        self.IsViewd = true
                    }
                }
                if self.IsViewd == false{print("Item is Not Viewd")
                  ViewdItemsObject.init(fire_id: FireId, estate_id: id, id: UUID().uuidString).Upload()
                }
            }
        }
    }
    
    
}

extension MyEstatesVc : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ProductArray.count == 0{
            self.TableView.alpha = 0
            return 0
        }
        self.TableView.alpha = 1
        return ProductArray.count
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FavoriteTableViewCell
        if ProductArray.count != 0{
            cell.Edit.accessibilityValue = self.ProductArray[indexPath.row].id
            cell.Delete.accessibilityIdentifier = self.ProductArray[indexPath.row].id
            cell.Delete.accessibilityHint = "\(indexPath.row)"
            cell.Delete.addTarget(self, action: #selector(self.remov(sender:)), for: .touchUpInside)
            cell.Edit.addTarget(self, action: #selector(self.edit(sender:)), for: .touchUpInside)
            cell.Sold.accessibilityIdentifier = self.ProductArray[indexPath.row].id
            cell.Sold.addTarget(self, action: #selector(self.Sold(sender:)), for: .touchUpInside)
            cell.update(self.ProductArray[indexPath.row])
        }
        return cell
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if ProductArray.count != 0 && indexPath.row <= ProductArray.count{
            InsertViewdItem(id : ProductArray[indexPath.row].id ?? "")
            self.performSegue(withIdentifier: "Next", sender: ProductArray[indexPath.row])
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

