//
//  CityVC.swift
//  RealEstates
//
//  Created by botan pro on 4/26/21.
//

import UIKit
import CRRefresh
class CityVC: UIViewController {
    var City : [CityObject] = []
    @IBOutlet weak var TableView: UITableView!{didSet{self.TableView.delegate = self; self.TableView.dataSource = self ; self.GetCity()}}
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.register(UINib(nibName: "CuntryAndCityTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        GetCity()
        self.TableView.cr.addHeadRefresh(animator: FastAnimator()) {
            self.GetCity()
        }
}
    
    func GetCity(){
        self.City.removeAll()
        CityObjectAip.GetCities { city in
            self.City = city
            self.TableView.cr.endHeaderRefresh()
            self.TableView.reloadData()
        }
        
    }
}

extension CityVC : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if City.count == 0{
            self.TableView.alpha = 0
            return 0
        }
        self.TableView.alpha = 1
        return City.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CuntryAndCityTableViewCell
        cell.Name.text = City[indexPath.row].name ?? ""
        return cell
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if City.count != 0{
        let CityName : [String : String] = ["City" : self.City[indexPath.row].name ?? "" ,"CityId":self.City[indexPath.row].id ?? ""]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CityName"), object: nil ,userInfo:CityName)
            self.popBack(2)
        }
    }
    
    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }
}


extension UINavigationController {

  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).last {
      popToViewController(vc, animated: animated)
    }
  }
}
