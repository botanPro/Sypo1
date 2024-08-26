//
//  ArchivedContractsVc.swift
//  RealEstates
//
//  Created by Botan Amedi on 01/06/2023.
//

import UIKit
import CRRefresh
import PDFReader
class ArchivedContractsVc: UIViewController {
    var ContractsArray : [ContracsObject] = []
    
    var Estate : EstateObject?
    @IBOutlet weak var TableView: UITableView!{didSet{self.TableView.delegate = self; self.TableView.dataSource = self}}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    if XLanguage.get() == .Arabic{
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "PeshangDes2", size: 16)!,.foregroundColor: #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)]
            
        }else if XLanguage.get() == .Kurdish{
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "PeshangDes2", size: 16)!,.foregroundColor: #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)]
        }else{
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 16)!,.foregroundColor: #colorLiteral(red: 0.07602687925, green: 0.2268401682, blue: 0.3553599715, alpha: 1)]

        }
        
        TableView.register(UINib(nibName: "ContractsTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        
        if let id = UserDefaults.standard.string(forKey: "OfficeId"){
            ContracsObjectAip.GetContracts() { [self] Item in
                for i in Item{
                    if i.archived == "1" && (i.buyer_id == id || i.seller_id == id){
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
                        if i.archived == "1" && (i.buyer_id == id || i.seller_id == id){
                            self.ContractsArray.append(i)
                        }
                    }
                    self.TableView.cr.endHeaderRefresh()
                    self.TableView.reloadData()
                }
            }
        }
    }
}



extension ArchivedContractsVc : UITableViewDelegate , UITableViewDataSource{
    
    
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
            cell.update(self.ContractsArray[indexPath.row])
            if let id = UserDefaults.standard.string(forKey: "OfficeId"){
                if self.ContractsArray[indexPath.row].buyer_id == id{
                    cell.SellBuyLable.textColor = #colorLiteral(red: 0.8972261548, green: 0.212166369, blue: 0.206838727, alpha: 1)
                   if XLanguage.get() == .Arabic{
                        cell.SellBuyLable.text = "اشتريت"
                        cell.SellBuyLable.font = UIFont(name: "PeshangDes2", size: 17)!
                    }else if XLanguage.get() == .Kurdish{
                        cell.SellBuyLable.text = "کڕیوە"
                        cell.SellBuyLable.font = UIFont(name: "PeshangDes2", size: 17)!
                    }else if XLanguage.get() == .English {
                        cell.SellBuyLable.text = "Bought"
                        cell.SellBuyLable.font = UIFont(name: "ArialRoundedMTBold", size: 20)!
                    } else if XLanguage.get() == .Dutch {
                        cell.SellBuyLable.text = "Gekocht"
                        cell.SellBuyLable.font = UIFont(name: "ArialRoundedMTBold", size: 20)!
                    } else if XLanguage.get() == .French {
                        cell.SellBuyLable.text = "Acheté"
                        cell.SellBuyLable.font = UIFont(name: "ArialRoundedMTBold", size: 20)!
                    } else if XLanguage.get() == .Spanish {
                        cell.SellBuyLable.text = "Comprado"
                        cell.SellBuyLable.font = UIFont(name: "ArialRoundedMTBold", size: 20)!
                    } else if XLanguage.get() == .German {
                        cell.SellBuyLable.text = "Gekauft"
                        cell.SellBuyLable.font = UIFont(name: "ArialRoundedMTBold", size: 20)!
                    } else if XLanguage.get() == .Hebrew {
                        cell.SellBuyLable.text = "נקנה"
                        cell.SellBuyLable.font = UIFont(name: "ArialRoundedMTBold", size: 20)!
                    } else if XLanguage.get() == .Chinese {
                        cell.SellBuyLable.text = "已购买"
                        cell.SellBuyLable.font = UIFont(name: "ArialRoundedMTBold", size: 20)!
                    } else if XLanguage.get() == .Hindi {
                        cell.SellBuyLable.text = "खरीदा गया"
                        cell.SellBuyLable.font = UIFont(name: "ArialRoundedMTBold", size: 20)!
                    } else if XLanguage.get() == .Portuguese {
                        cell.SellBuyLable.text = "Comprado"
                        cell.SellBuyLable.font = UIFont(name: "ArialRoundedMTBold", size: 20)!
                    } else if XLanguage.get() == .Russian {
                        cell.SellBuyLable.text = "Куплено"
                        cell.SellBuyLable.font = UIFont(name: "ArialRoundedMTBold", size: 20)!
                    }
                }else{
                    cell.SellBuyLable.textColor = #colorLiteral(red: 0, green: 0.7561545968, blue: 0.1472039223, alpha: 1)
                     if XLanguage.get() == .Arabic{
                        cell.SellBuyLable.text = "تم البيع"
                        cell.SellBuyLable.font = UIFont(name: "PeshangDes2", size: 17)!
                    }else if XLanguage.get() == .Kurdish{
                        cell.SellBuyLable.text = "فرۆشرا"
                        cell.SellBuyLable.font = UIFont(name: "PeshangDes2", size: 17)!
                    }else if XLanguage.get() == .English {
                        cell.SellBuyLable.text = "Sold"
                        cell.SellBuyLable.font = UIFont(name: "ArialRoundedMTBold", size: 20)!
                    } else if XLanguage.get() == .Dutch {
                        cell.SellBuyLable.text = "Verkocht"
                        cell.SellBuyLable.font = UIFont(name: "ArialRoundedMTBold", size: 20)!
                    } else if XLanguage.get() == .French {
                        cell.SellBuyLable.text = "Vendu"
                        cell.SellBuyLable.font = UIFont(name: "ArialRoundedMTBold", size: 20)!
                    } else if XLanguage.get() == .Spanish {
                        cell.SellBuyLable.text = "Vendido"
                        cell.SellBuyLable.font = UIFont(name: "ArialRoundedMTBold", size: 20)!
                    } else if XLanguage.get() == .German {
                        cell.SellBuyLable.text = "Verkauft"
                        cell.SellBuyLable.font = UIFont(name: "ArialRoundedMTBold", size: 20)!
                    } else if XLanguage.get() == .Hebrew {
                        cell.SellBuyLable.text = "נמכר"
                        cell.SellBuyLable.font = UIFont(name: "ArialRoundedMTBold", size: 20)!
                    } else if XLanguage.get() == .Chinese {
                        cell.SellBuyLable.text = "已售"
                        cell.SellBuyLable.font = UIFont(name: "ArialRoundedMTBold", size: 20)!
                    } else if XLanguage.get() == .Hindi {
                        cell.SellBuyLable.text = "बिक गया"
                        cell.SellBuyLable.font = UIFont(name: "ArialRoundedMTBold", size: 20)!
                    } else if XLanguage.get() == .Portuguese {
                        cell.SellBuyLable.text = "Vendido"
                        cell.SellBuyLable.font = UIFont(name: "ArialRoundedMTBold", size: 20)!
                    } else if XLanguage.get() == .Russian {
                        cell.SellBuyLable.text = "Продано"
                        cell.SellBuyLable.font = UIFont(name: "ArialRoundedMTBold", size: 20)!
                    }
                }
            }
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if ContractsArray.count != 0 && indexPath.row <= ContractsArray.count{
            let remotePDFDocumentURLPath = "https://sypo-realestate.com/panel/assest/pdfs/\(self.ContractsArray[indexPath.row].id ?? "empty").pdf"
            print(remotePDFDocumentURLPath)
            let remotePDFDocumentURL = URL(string: remotePDFDocumentURLPath)!
            let document = PDFDocument(url: remotePDFDocumentURL)!
            
            let readerController = PDFViewController.createNew(with: document)
            navigationController?.pushViewController(readerController, animated: true)
        }
    }
    
    
}
