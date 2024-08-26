//
//  CuntryVC.swift
//  RealEstates
//
//  Created by botan pro on 4/26/21.
//

import UIKit
import CRRefresh
class CuntryVC: UIViewController {
    var Cuntry : [CountryObject] = []
    var IsFromHome = false
    @IBOutlet weak var TableView: UITableView!{didSet{self.TableView.delegate = self; self.TableView.dataSource = self ; GetCuntys()}}
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.register(UINib(nibName: "CuntryAndCityTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.TableView.cr.addHeadRefresh(animator: FastAnimator()) {
            self.GetCuntys()
        }
    }
    
    
    
    func GetCuntys(){
        self.Cuntry.removeAll()
        CountryObjectAip.GetCountries{ (cuntrys) in
            self.Cuntry = cuntrys
            print("cuntry count is : \(cuntrys.count)")
            self.TableView.reloadData()
            self.TableView.cr.endHeaderRefresh()
        }
    }
    
    
    
    
}

extension CuntryVC : UITableViewDelegate , UITableViewDataSource{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Cuntry.count == 0{
            return 0
        }
        return Cuntry.count
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CuntryAndCityTableViewCell
        cell.Name.text = Cuntry[indexPath.row].name
        return cell
    }

   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if Cuntry.count != 0{
            callSegueFromProductC(id: self.Cuntry[indexPath.row].id ?? ""  , name: self.Cuntry[indexPath.row].name ?? "")
        }

    }
    
    
    
    func callSegueFromProductC(id: String, name : String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myVC = storyboard.instantiateViewController(withIdentifier: "GoToCityVC") as! CityVC
        let CuntryName : [String : String] = ["Cuntry" : name]
        myVC.CountryId = id
        if IsFromHome == true{
            myVC.IsFromHome = true
        }else{
            myVC.IsFromHome = false
        }
        self.navigationController?.pushViewController(myVC, animated: true)
    }
    
    
    
}

