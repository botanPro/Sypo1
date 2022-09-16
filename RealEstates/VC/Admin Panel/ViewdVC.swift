//
//  ViewdVC.swift
//  RealEstates
//
//  Created by botan pro on 6/13/22.
//

import UIKit
import CRRefresh
class ViewdVC: UIViewController {

    
    var ProductArray : [EstateObject] = []
    @IBOutlet weak var TableView: UITableView!{didSet{self.TableView.delegate = self; self.TableView.dataSource = self}}
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
        
        if XLanguage.get() == .English{
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 16)!,.foregroundColor: #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)]

        }else if XLanguage.get() == .Arabic{
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "PeshangDes2", size: 16)!,.foregroundColor: #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)]

        }else if XLanguage.get() == .Kurdish{
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "PeshangDes2", size: 16)!,.foregroundColor: #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)]
        }
        
        
        TableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        if let FireId = UserDefaults.standard.string(forKey: "UserId"){print(FireId)
            ViewdItemsObjectAip.GeViewdItemById(fire_id: FireId) { [self] Item in
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
            if let FireId = UserDefaults.standard.string(forKey: "UserId"){print(FireId)
                ViewdItemsObjectAip.GeViewdItemById(fire_id: FireId) { [self] Item in
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
}



extension ViewdVC : UITableViewDelegate , UITableViewDataSource{
    
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
            cell.Delete.isHidden = true
            cell.Edit.isHidden = true
           
            cell.RightLayoutConstraint.constant = 10
            cell.RightLayoutConstraint2.constant = 10
            cell.update(self.ProductArray[indexPath.row])
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

