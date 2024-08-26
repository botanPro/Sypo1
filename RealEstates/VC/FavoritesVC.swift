//
//  FavoritesVC.swift
//  RealEstates
//
//  Created by botan pro on 6/14/21.
//

import UIKit
import CRRefresh
class FavoritesVC: UIViewController {
    @IBOutlet weak var InternetViewHeight: NSLayoutConstraint!
    @IBOutlet weak var InternetConnectionView: UIView!
    
    var ProductArray : [EstateObject] = []
    @IBOutlet weak var TableView: UITableView!{didSet{self.TableView.delegate = self; self.TableView.dataSource = self }}
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.InternetViewHeight.constant = 0
        self.InternetConnectionView.isHidden = true
 
        
        if XLanguage.get() == .Arabic{
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "PeshangDes2", size: 16)!,.foregroundColor: #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)]

        }else if XLanguage.get() == .Kurdish{
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "PeshangDes2", size: 16)!,.foregroundColor: #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)]
        }else {
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 16)!,.foregroundColor: #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)]

        }
        
        
        TableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        if let FireId = UserDefaults.standard.string(forKey: "UserId"){print(FireId)
            FavoriteItemsObjectAip.GetFavoriteItemsById(fire_id: FireId) { [self] Item in
                ProductAip.GetAllProducts { estate in
                    for i in estate{
                        if i.id == Item.estate_id{
                            self.ProductArray.append(i)
                        }
                    }
                    self.TableView.reloadData()
                }
            }
        }
        
        self.TableView.cr.addHeadRefresh(animator: FastAnimator()) {
            self.ProductArray.removeAll()
            if let FireId = UserDefaults.standard.string(forKey: "UserId"){
                FavoriteItemsObjectAip.GetFavoriteItemsById(fire_id: FireId) { [self] Item in
                    ProductAip.GetAllProducts { estate in
                        for i in estate{
                            if i.id == Item.estate_id && i.archived != "1"{
                                self.ProductArray.append(i)
                            }
                        }
                        self.TableView.cr.endHeaderRefresh()
                        self.TableView.reloadData()
                    }
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
    
    
    @objc func remov(sender : UIButton){
        if CheckInternet.Connection(){
            UIView.animate(withDuration: 0.3) {
                self.InternetViewHeight.constant = 0
                self.InternetConnectionView.isHidden = true
                self.view.layoutIfNeeded()
            }
            
        if XLanguage.get() == .Kurdish{
            self.Title = "لابردن"
            self.message = "ئایا دڵنیای کە دەتەوێت لاببەیت؟"
            self.action = "دڵنیام"
            self.cancel = "نەخێر"
        }else if XLanguage.get() == .Arabic{
            self.Title = "الحذف"
            self.message = "هل أنت متأكد أنك تريد الحذف؟"
            self.action = "متأكد"
            self.cancel = "لا"
        }else if XLanguage.get() == .English {
            self.Title = "Remove"
            self.message = "Are you sure you want to remove?"
            self.action = "I'm sure"
            self.cancel = "Cancel"
        } else if XLanguage.get() == .French {
            self.Title = "Supprimer"
            self.message = "Êtes-vous sûr de vouloir supprimer ?"
            self.action = "Je suis sûr"
            self.cancel = "Annuler"
        } else if XLanguage.get() == .Spanish {
            self.Title = "Eliminar"
            self.message = "¿Estás seguro de que quieres eliminar?"
            self.action = "Estoy seguro"
            self.cancel = "Cancelar"
        } else if XLanguage.get() == .German {
            self.Title = "Entfernen"
            self.message = "Sind Sie sicher, dass Sie entfernen möchten?"
            self.action = "Ich bin sicher"
            self.cancel = "Abbrechen"
        } else if XLanguage.get() == .Portuguese {
            self.Title = "Remover"
            self.message = "Tem certeza de que deseja remover?"
            self.action = "Tenho certeza"
            self.cancel = "Cancelar"
        } else if XLanguage.get() == .Russian {
            self.Title = "Удалить"
            self.message = "Вы уверены, что хотите удалить?"
            self.action = "Я уверен"
            self.cancel = "Отмена"
        } else if XLanguage.get() == .Dutch {
            self.Title = "Verwijderen"
            self.message = "Weet u zeker dat u dit wilt verwijderen?"
            self.action = "Ik ben zeker"
            self.cancel = "Annuleren"
        } else if XLanguage.get() == .Chinese {
            self.Title = "删除"
            self.message = "您确定要删除吗？"
            self.action = "我确定"
            self.cancel = "取消"
        }
        
        let myAlert = UIAlertController(title: self.Title, message: self.message, preferredStyle: UIAlertController.Style.alert)
        myAlert.addAction(UIAlertAction(title: self.action, style: .default, handler: { (UIAlertAction) in
            FavoriteItemsObject.init(fire_id: "", estate_id: "",id:sender.accessibilityIdentifier!).Remov()
            self.ProductArray.remove(at: (sender.accessibilityValue! as NSString).integerValue)
            self.TableView.reloadData()
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
}

extension FavoritesVC : UITableViewDelegate , UITableViewDataSource{
    
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
            
            cell.RightLayoutConstraint2.constant = 10
            if let FireId = UserDefaults.standard.string(forKey: "UserId"){
                FavoriteItemsObjectAip.GetFavoriteItemsById(fire_id: FireId) { item in
                    if item.fire_id == FireId && item.estate_id == self.ProductArray[indexPath.row].id ?? ""{
                        cell.Delete.accessibilityValue = "\(indexPath.row)"
                        cell.Delete.accessibilityIdentifier = item.id
                    }
                }
            }
            cell.Delete.addTarget(self, action: #selector(self.remov(sender:)), for: .touchUpInside)
            cell.update(self.ProductArray[indexPath.row])
            cell.Edit.isHidden = true
            cell.Sold.isHidden = true
        }
        return cell
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if ProductArray.count != 0 && indexPath.row <= ProductArray.count{
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

