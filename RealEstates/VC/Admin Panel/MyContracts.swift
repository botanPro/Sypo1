//
//  MyContracts.swift
//  RealEstates
//
//  Created by Botan Amedi on 01/06/2023.
//

import UIKit
import CRRefresh
class MyContracts: UIViewController{


    var ContractsArray : [ContracsObject] = []

    var Estate : EstateObject?
    @IBOutlet weak var TableView: UITableView!{didSet{self.TableView.delegate = self; self.TableView.dataSource = self}}
    
    
    var IsSeller = false
    
    
    @IBOutlet weak var SoldAndBoughtSegmentedController: LanguageSegment!
    
    
    @IBAction func SoldAndBoughtSegmentedController(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.IsSeller = true
            if let id = UserDefaults.standard.string(forKey: "OfficeId"){
                self.ContractsArray.removeAll()
                ContracsObjectAip.GetContracts() { [self] Item in
                        for i in Item {
                            if i.archived != "1" && i.buyer_id == id {
                                self.ContractsArray.append(i)
                            }
                        }
                        self.TableView.reloadData()
                    }
            }
        }else{
            if let id = UserDefaults.standard.string(forKey: "OfficeId"){
                self.ContractsArray.removeAll()
                self.IsSeller = false
                ContracsObjectAip.GetContracts() { [self] Item in
                        for i in Item{
                            if i.archived != "1" && i.seller_id == id{
                                self.ContractsArray.append(i)
                            }
                        }
                        self.TableView.reloadData()
                }
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
        
        if XLanguage.get() == .Arabic{
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "PeshangDes2", size: 16)!,.foregroundColor: #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)]
        }else if XLanguage.get() == .Kurdish{
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "PeshangDes2", size: 16)!,.foregroundColor: #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)]
        }else {
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 16)!,.foregroundColor: #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)]
        }
        
        TableView.register(UINib(nibName: "ContractsTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
         

        if let id = UserDefaults.standard.string(forKey: "OfficeId"){print("p[p[p[p")
            ContracsObjectAip.GetContracts() { [self] Item in
                print("p[p[p[p")
                    for i in Item{
                        print(i.id)
                        if i.archived != "1" && i.buyer_id == id{
                            self.ContractsArray.append(i)
                        }
                    }
                    self.TableView.reloadData()
                }
        }
        
        
        self.TableView.cr.addHeadRefresh(animator: FastAnimator()) {
            self.ContractsArray.removeAll()
            if let id = UserDefaults.standard.string(forKey: "OfficeId"){
                ContracsObjectAip.GetContracts() { [self] Item in
                        for i in Item{
                            if i.archived != "1" && i.buyer_id == id{
                                self.ContractsArray.append(i)
                            }
                        }
                        self.TableView.cr.endHeaderRefresh()
                        self.TableView.reloadData()
                    self.SoldAndBoughtSegmentedController.selectedSegmentIndex = 0
                    }
            }
        }
    }
    
    
 
}



extension MyContracts : UITableViewDelegate , UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ContractsArray.count == 0{
            self.TableView.alpha = 0
            return 0
        }
        self.TableView.alpha = 1
        return ContractsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ContractsTableViewCell
        if ContractsArray.count != 0{
            cell.SellBuyLable.isHidden = true
            cell.update(self.ContractsArray[indexPath.row])
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.SoldAndBoughtSegmentedController.selectedSegmentIndex == 1 {
            if ContractsArray.count != 0 && indexPath.row <= ContractsArray.count{
                ProductAip.GetProduct(ID: self.ContractsArray[indexPath.row].estate_id  ?? "") { Estate in
                    UserDefaults.standard.setValue(self.ContractsArray[indexPath.row].id  ?? "", forKey: "contract_id")
                    self.performSegue(withIdentifier: "GoToCreateContract", sender: Estate)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 121
    }
  
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let estate = sender as? EstateObject{
            if let next = segue.destination as? DealVC{
                next.Estate = estate
            }
        }
    }


}
