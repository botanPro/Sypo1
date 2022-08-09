//
//  FavoritesVC.swift
//  RealEstates
//
//  Created by botan pro on 6/14/21.
//

import UIKit
import CRRefresh
class FavoritesVC: UIViewController {

    
    var ProductArray : [EstateObject] = []
    @IBOutlet weak var TableView: UITableView!{didSet{self.TableView.delegate = self; self.TableView.dataSource = self }}
    override func viewDidLoad() {
        super.viewDidLoad()
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
                            if i.id == Item.estate_id{
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
        }else{
            self.Title = "Remove"
            self.message = "Are you sure you wan to remove?"
            self.action = "I'm sure"
            self.cancel = "Cancel"
        }
        
        let myAlert = UIAlertController(title: self.Title, message: self.message, preferredStyle: UIAlertController.Style.alert)
        myAlert.addAction(UIAlertAction(title: self.action, style: .default, handler: { (UIAlertAction) in
            FavoriteItemsObject.init(fire_id: "", estate_id: "",id:sender.accessibilityIdentifier!).Remov()
            self.ProductArray.remove(at: (sender.accessibilityValue! as NSString).integerValue)
            self.TableView.reloadData()
        }))
        myAlert.addAction(UIAlertAction(title: self.cancel, style: .cancel, handler: nil))
        self.present(myAlert, animated: true, completion: nil)
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
            cell.Edit.isHidden = true
            cell.Sold.isHidden = true
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

