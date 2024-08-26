//
//  CityVC.swift
//  RealEstates
//
//  Created by botan pro on 4/26/21.
//

import UIKit
import CRRefresh
import Drops
class CityVC: UIViewController {
    var City : [CityObject] = []
    var CountryId = ""
    var IsFromHome = false
    var EstateInTheCity = false

    @IBOutlet weak var TableView: UITableView!{didSet{self.TableView.delegate = self; self.TableView.dataSource = self ; self.GetCity()}}
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.register(UINib(nibName: "CuntryAndCityTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        self.TableView.cr.addHeadRefresh(animator: FastAnimator()) {
            self.GetCity()
        }
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
}
    
    func GetCity(){
        self.City.removeAll()
        CityObjectAip.GetCities { citys in
            for city in citys{
                if city.country_id == self.CountryId{
                    self.City.append(city)
                }
            }
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
            cell.Name.font =  UIFont(name: "ArialRoundedMTBold", size: 13)!
        
        return cell
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if City.count != 0{
            print(self.City[indexPath.row].id ?? "")
            if IsFromHome == false{
                let CityName : [String : String] = ["City" : self.City[indexPath.row].name ?? "" ,"CityId":self.City[indexPath.row].id ?? ""]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CityName"), object: nil ,userInfo:CityName)
            }else{
                ProductAip.GetAllProducts { Estates in
                    for estate in Estates{
                        if estate.city_id == self.City[indexPath.row].id && estate.archived == "0"{
                            self.EstateInTheCity = true
                        }
                    }
                    print(self.IsFromHome)
                    print(self.City[indexPath.row].id ?? "")
                    print(self.EstateInTheCity )
                    if   self.EstateInTheCity == true{print("[[[[")
                        UserDefaults.standard.setValue(self.City[indexPath.row].id ?? "", forKey: "CityId")
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LocationChangedS"), object: nil)
                        self.popBack(3)
                    }else{print("[pppp[[")
                        var title = "Empty"
                        var message = "No Estates are found"
                        
                      
                        if XLanguage.get() == .Kurdish{
                            title = "بەتاڵ"
                            message = "هیچ خانوبەرێک نەدۆزراوەتەوە"
                        } else if XLanguage.get() == .Arabic{
                            title = "فارغة"
                            message = "لم يتم العثور على عقار"
                        } else if XLanguage.get() == .English {
                            title = "Empty"
                            message = "No Estates are found"
                        } else if XLanguage.get() == .Dutch {
                            title = "Leeg"
                            message = "Geen vastgoed gevonden"
                        } else if XLanguage.get() == .French {
                            title = "Vide"
                            message = "Aucune propriété trouvée"
                        } else if XLanguage.get() == .Spanish {
                            title = "Vacío"
                            message = "No se encontraron propiedades"
                        } else if XLanguage.get() == .German {
                            title = "Leer"
                            message = "Keine Immobilien gefunden"
                        } else if XLanguage.get() == .Hebrew {
                            title = "ריק"
                            message = "לא נמצאו נכסים"
                        } else if XLanguage.get() == .Chinese {
                            title = "空的"
                            message = "未找到任何房产"
                        } else if XLanguage.get() == .Hindi {
                            title = "खाली"
                            message = "कोई भी बेस्तकी पाया नहीं गया"
                        } else if XLanguage.get() == .Portuguese {
                            title = "Vazio"
                            message = "Nenhum imóvel encontrado"
                        } else if XLanguage.get() == .Russian {
                            title = "Пусто"
                            message = "Недвижимость не найдена"
                        } else if XLanguage.get() == .Swedish {
                            title = "Tomt"
                            message = "Inga fastigheter hittades"
                        } else if XLanguage.get() == .Greek {
                            title = "Άδειο"
                            message = "Δεν βρέθηκαν ακίνητα"
                        }
                        
                        let drop = Drop(
                            title: title,
                            subtitle: message,
                            icon: UIImage(named: "attention"),
                            action: .init {
                                print("Drop tapped")
                                Drops.hideCurrent()
                            },
                            position: .top,
                            duration: 3.0,
                            accessibility: "Alert: Title, Subtitle"
                        )
                        Drops.show(drop)
                        self.popBack(3)
                    }
                    
                }
               
            }
            self.popBack(3)
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
