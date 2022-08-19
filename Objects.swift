//
//  Objects.swift
//  RealEstates
//
//  Created by botan pro on 4/25/21.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit


///-------------New Firebase Objects----------------
///
import Firebase
import FirebaseStorage
import FirebaseFirestore

class EstateObject{
    
    
    var name : String?
    var id : String?
    var Stamp : TimeInterval?
    var RentOrSell : String?
    var office_id : String?
    var fire_id : String?
    var city_name: String?
    var city_id: String?
    var address : String?
    var lat : String?
    var long : String?
    var price : Double?
    var desc : String?
    var ImageURL : [String]?
    
    var estate_type_id :String?
    var Direction : String?
    var floor : String?
    var Building : String?
    var Year :String?
    var Furnished : String?
    var bound_id : String?
    var MonthlyService : String?
    var video_link : String?
    var RoomNo : String?
    var WashNo : String?
    var space : String?
    var propertyNo : String?
    var state : String?
    
    var project_id :String?
    
    var archived : String?
    var sold : String?
    init(name : String,id : String , stamp : TimeInterval ,RentOrSell: String, city_name : String , address : String ,lat : String , long : String , price: Double, desc:String , office_id : String ,fire_id : String, ImageURL : [String] , city_id : String
         
         , estate_type_id : String ,Direction : String , floor : String ,Building : String, Year: String, Furnished : String , bound_id:String , MonthlyService : String, RoomNo : String ,WashNo:String, space : String , propertyNo : String, state : String, project_id : String, video_link : String,archived : String , sold : String) {
        
        self.name               = name
        self.id                 = id
        self.address            = address
        self.city_name          = city_name
        self.ImageURL           = ImageURL
        self.lat                = lat
        self.long               = long
        self.city_id            = city_id
        self.price              = price
        self.desc               = desc
        self.office_id          = office_id
        self.fire_id            = fire_id
        self.RentOrSell         = RentOrSell
        self.estate_type_id     = estate_type_id
        self.Direction          = Direction
        self.floor              = floor
        self.Building           = Building
        self.Year               = Year
        self.Furnished          = Furnished
        self.bound_id           = bound_id
        self.MonthlyService     = MonthlyService
        self.RoomNo             = RoomNo
        self.WashNo             = WashNo
        self.space              = space
        self.propertyNo         = propertyNo
        self.Stamp              = stamp
        self.state              = state
        self.video_link         = video_link
        self.project_id         = project_id
        self.archived           = archived
        self.sold               = sold
        
    }
    
    
    
    init(Dictionary : [String : AnyObject]) {
        self.id             = Dictionary[ "id"              ] as? String
        self.Stamp          = Dictionary[ "stamp"           ] as? TimeInterval
        self.state          = Dictionary[ "state"           ] as? String
        self.name           = Dictionary[ "name"            ] as? String
        self.RentOrSell     = Dictionary[ "rent_or_sell"    ] as? String
        self.desc           = Dictionary[ "description"     ] as? String
        self.price          = Dictionary[ "price"           ] as? Double
        self.lat            = Dictionary[ "lat"             ] as? String
        self.long           = Dictionary[ "long"            ] as? String
        self.office_id      = Dictionary[ "office_id"       ] as? String
        self.fire_id        = Dictionary[ "fire_id"       ] as? String
        self.ImageURL       = Dictionary[ "ImageURL"        ] as? [String]
        self.address        = Dictionary[ "address"         ] as? String
        self.city_id        = Dictionary[ "city_id"         ] as? String
        self.city_name      = Dictionary[ "city_name"       ] as? String
        self.Building       = Dictionary[ "building"        ] as? String
        self.estate_type_id = Dictionary[ "estate_type_id" ] as? String
        self.Direction      = Dictionary[ "direction"       ] as? String
        self.floor          = Dictionary[ "floor"           ] as? String
        self.Year           = Dictionary[ "year"            ] as? String
        self.Furnished      = Dictionary[ "furnished"       ] as? String
        self.bound_id       = Dictionary[ "bound_id"       ] as? String
        self.MonthlyService = Dictionary[ "monthly_service" ] as? String
        self.RoomNo         = Dictionary[ "room_number"     ] as? String
        self.WashNo         = Dictionary[ "wash_number"     ] as? String
        self.space          = Dictionary[ "space"           ] as? String
        self.propertyNo     = Dictionary[ "property_number" ] as? String
        self.video_link     = Dictionary[ "video_link"      ] as? String
        self.project_id     = Dictionary[ "project_id"      ] as? String
        self.archived       = Dictionary[ "archived"        ] as? String
        self.sold           = Dictionary[ "sold"            ] as? String
    }
    
    
    
    //data -> dictionary
    func MakeDictionary() -> [String : AnyObject] {
        var New  : [String : AnyObject] = [:]
        New["id"               ] = self.id             as AnyObject
        New["stamp"            ] = self.Stamp          as AnyObject
        New["state"            ] = self.state          as AnyObject
        New["name"             ] = self.name           as AnyObject
        New["rent_or_sell"     ] = self.RentOrSell     as AnyObject
        New["description"      ] = self.desc           as AnyObject
        New["price"            ] = self.price          as AnyObject
        New["lat"              ] = self.lat            as AnyObject
        New["long"             ] = self.long           as AnyObject
        New["office_id"        ] = self.office_id      as AnyObject
        New["fire_id"          ] = self.fire_id      as AnyObject
        New["ImageURL"         ] = self.ImageURL       as AnyObject
        New["address"          ] = self.address        as AnyObject
        New["city_id"          ] = self.city_id        as AnyObject
        New["city_name"        ] = self.city_name      as AnyObject
        New["building"         ] = self.Building       as AnyObject
        New["estate_type_id"   ] = self.estate_type_id as AnyObject
        New["direction"        ] = self.Direction      as AnyObject
        New["floor"            ] = self.floor          as AnyObject
        New["year"             ] = self.Year           as AnyObject
        New["furnished"        ] = self.Furnished      as AnyObject
        New["bound_id"         ] = self.bound_id       as AnyObject
        New["monthly_service"  ] = self.MonthlyService as AnyObject
        New["room_number"      ] = self.RoomNo         as AnyObject
        New["wash_number"      ] = self.WashNo         as AnyObject
        New["space"            ] = self.space          as AnyObject
        New["property_number"  ] = self.propertyNo     as AnyObject
        New["video_link"       ] = self.video_link     as AnyObject
        New["project_id"       ] = self.project_id     as AnyObject
        New["archived"         ] = self.archived     as AnyObject
        New["sold"             ] = self.sold           as AnyObject
        return New
    }
    
    
    
    // breka ve func de data kayna d database da
    func Upload() {
        guard let id = self.id else{return}
        Firestore.firestore().collection("EstateProducts").document(id).setData( MakeDictionary() )
    }
    
    func Update() {
        guard let id = self.id else{return}
        Firestore.firestore().collection("EstateProducts").document(id).updateData( MakeDictionary() )
    }
    

    
    
    // breka ve func de data delete kayn d database da
    func Remov() {
        guard let id = id else{return}
        Firestore.firestore().collection("EstateProducts").document(id).delete()
    }
}

//av classa dshet dataya bo ma j firbaseDatabase bynyt bshewe DealsObject
class ProductAip{
    // ava bas 1 poduct d inyt b ID
    static func  GetProduct(ID :  String , completion : @escaping (_ product : EstateObject)->()){
        Firestore.firestore().collection("EstateProducts").document(ID).addSnapshotListener { ( snopshot :  DocumentSnapshot?, error : Error?) in
            print(error.debugDescription)
            
            if let data = snopshot?.data() as [String: AnyObject ]? {
                let New = EstateObject(Dictionary: data)
                completion(New)
            }
        }
    }
    
    static func updateState(_ EstateId : String , sold : String, completion : @escaping (_ product : EstateObject)->()){
        Firestore.firestore().collection("EstateProducts").document(EstateId).setData( ["sold": sold], merge: true)
        completion(EstateObject(Dictionary: [:]))
    }
    
    
    static func Remov(id : String, completion : @escaping (_ product : EstateObject)->()){
        Firestore.firestore().collection("EstateProducts").document(id).setData( ["archived": "1"], merge: true)
        completion(EstateObject(Dictionary: [:]))
    }
                   
    
    // ava hamy product d inyty
    static func GetAllProducts(completion : @escaping (_ Product : [EstateObject])->()){
        var New : [EstateObject] = []
        Firestore.firestore().collection("EstateProducts").getDocuments { (Snapshot, error) in
            if error != nil { print("Error") ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    New.append(EstateObject(Dictionary: data))
                }
            }
            completion(New)
        }
    }
    
    static func GetAllSectionProducts(TypeId : String , completion : @escaping (_ Product : EstateObject)->()){
        Firestore.firestore().collection("EstateProducts").whereField("estate_type_id", isEqualTo: TypeId).getDocuments { (Snapshot, error) in
            if error != nil { print(error.debugDescription) ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    let New = EstateObject(Dictionary: data)
                    completion(New)
                }
            }
        }
    }
    
    
    static func GetAllEstateForNeighburs(TypeId : String , completion : @escaping (_ Product : [EstateObject])->()){
        var New : [EstateObject] = []
        Firestore.firestore().collection("EstateProducts").whereField("estate_type_id", isEqualTo: TypeId).getDocuments { (Snapshot, error) in
            if error != nil { print(error.debugDescription) ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    New.append(EstateObject(Dictionary: data))
                }
            }
            completion(New)
        }
    }
    
    
    static func GetMyEstates(office_id : String , completion : @escaping (_ Product : EstateObject)->()){
        Firestore.firestore().collection("EstateProducts").whereField("office_id", isEqualTo: office_id).getDocuments { (Snapshot, error) in
            if error != nil { print(error.debugDescription) ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    let New = EstateObject(Dictionary: data)
                    print("[]][[][][]][][][][]")
                    print(JSON(data))
                    completion(New)
                }
            }
        }
    }
    
    
    static func GetAllMyEstates(office_id : String , completion : @escaping (_ Product : [EstateObject])->()){
        var New : [EstateObject] = []
        Firestore.firestore().collection("EstateProducts").whereField("office_id", isEqualTo: office_id).getDocuments { (Snapshot, error) in
            if error != nil { print(error.debugDescription) ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    New.append(EstateObject(Dictionary: data))
                    print("[]][[][][]][][][][]")
                }
            }
            completion(New)
        }
    }
    
    
    static func GetProjectsById(project_id : String , completion : @escaping (_ Product : EstateObject)->()){
        Firestore.firestore().collection("EstateProducts").whereField("project_id", isEqualTo: project_id).getDocuments { (Snapshot, error) in
            if error != nil { print(error.debugDescription) ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    let New = EstateObject(Dictionary: data)
                    print("[]][[][][]][][][][]")
                    print(JSON(data))
                    completion(New)
                }
            }
        }
    }
    
}



///----------OfficesObject---------
///
///
class OfficesObject{
    
    var id : String?
    var name : String?
    var fire_id : String?
    var address : String?
    var phone1 : String?
    var phone2 : String?
    var about : String?
    var ImageURL : String?
    var type_id : String?
    var archived : String?
    
    init(name : String,id : String ,fire_id : String , address : String , about : String,phone1:String , phone2 : String , ImageURL : String , type_id : String, archived : String) {
        self.name               = name
        self.id                 = id
        self.fire_id            = fire_id
        self.address            = address
        self.phone2             = phone2
        self.ImageURL           = ImageURL
        self.phone1             = phone1
        self.about              = about
        self.address            = address
        self.type_id            = type_id
        self.archived           = archived
    }
    
    
    
    init(Dictionary : [String : AnyObject]) {
        self.id             = Dictionary[ "id"               ] as? String
        self.fire_id        = Dictionary[ "fire_id"               ] as? String
        self.name           = Dictionary[ "name"             ] as? String
        self.phone2         = Dictionary[ "second_phone_number"] as? String
        self.about          = Dictionary[ "about"            ] as? String
        self.phone1         = Dictionary[ "first_phone_number" ] as? String
        self.ImageURL       = Dictionary[ "image"            ] as? String
        self.address        = Dictionary[ "address"          ] as? String
        self.type_id        = Dictionary[ "type_id"          ] as? String
        self.archived       = Dictionary[ "archived"         ] as? String
    }
    
    
    //data -> dictionary
    func MakeDictionary() -> [String : AnyObject] {
        var New  : [String : AnyObject]  = [:]
        New["id"               ] = self.id        as AnyObject
        New["fire_id"          ] = self.fire_id        as AnyObject
        New["name"             ] = self.name      as AnyObject
        New["second_phone_number"] = self.phone2    as AnyObject
        New["about"            ] = self.about     as AnyObject
        New["first_phone_number" ] = self.phone1    as AnyObject
        New["image"            ] = self.ImageURL  as AnyObject
        New["address"          ] = self.address   as AnyObject
        New["type_id"          ] = self.type_id    as AnyObject
        New["archived"         ] = self.archived   as AnyObject
        return New
    }
    
    
    
    // breka ve func de data kayna d database da
    func Upload() {
        guard let id = self.id else{print("Offices not uploaded"); return }
        Firestore.firestore().collection("OfficesProfile").document(id).setData( MakeDictionary() )
    }
    
    func Update() {
        guard let id = self.id else{print("Offices not Updated"); return }
        Firestore.firestore().collection("OfficesProfile").document(id).updateData( MakeDictionary() )
    }
    

}

//av classa dshet dataya bo ma j firbaseDatabase bynyt bshewe DealsObject
class OfficeAip{
    static func  GetOffice(ID :  String , completion : @escaping (_ office : OfficesObject)->()){
        print(ID)
        Firestore.firestore().collection("OfficesProfile").document(ID).addSnapshotListener { ( snopshot :  DocumentSnapshot?, error : Error?) in
            if let data = snopshot?.data() as [String: AnyObject ]? {
                let New = OfficesObject(Dictionary: data)
                completion(New)
            }
        }
    }
    
    static func Remov(id : String, completion : @escaping (_ product : OfficesObject)->()){
        Firestore.firestore().collection("OfficesProfile").document(id).setData( ["archived": "1"], merge: true)
        completion(OfficesObject(Dictionary: [:]))
    }
    
    
    // ava hamy product d inyty
    static func GetAllOffice(completion : @escaping (_ Product : [OfficesObject])->()){
        var New : [OfficesObject] = []
        Firestore.firestore().collection("OfficesProfile").getDocuments { (Snapshot, error) in
            if error != nil { print("Error") ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    New.append(OfficesObject(Dictionary: data))
                }
            }
            completion(New)
        }
    }
    
    static func GetOfficeById(Id : String , completion : @escaping (_ Product : OfficesObject)->()){
        Firestore.firestore().collection("OfficesProfile").whereField("fire_id", isEqualTo: Id).getDocuments { (Snapshot, error) in
            if error != nil { print(error.debugDescription) ; return }
            guard let documents = Snapshot?.documents else { return }
            if documents != []{
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    let New = OfficesObject(Dictionary: data)
                    print(JSON(data))
                    completion(New)
                }
            }
            }else{
                completion(OfficesObject.init(name: "", id: "", fire_id: "", address: "", about: "", phone1: "", phone2: "", ImageURL: "", type_id: "", archived: ""))
            }
        }
    }
    
}






class OfficeRatingObject{
    
    var rate : Double?
    var rater_fire_id : String?
    var office_id : String?
    var id : String?
    
    init(rate : Double,rater_fire_id : String,office_id : String,id :String) {
        self.rate               = rate
        self.rater_fire_id      = rater_fire_id
        self.office_id          = office_id
        self.id                 = id
    }
    
    init(Dictionary : [String : AnyObject]) {
        self.rate          = Dictionary[ "rate" ]          as? Double
        self.rater_fire_id = Dictionary[ "rater_fire_id" ] as? String
        self.office_id     = Dictionary[ "office_id" ]     as? String
        self.id            = Dictionary[ "id" ]            as? String
    }
    
    func MakeDictionary() -> [String : AnyObject] {
        var New  : [String : AnyObject]  = [:]
        New["rate"]          = self.rate              as AnyObject
        New["rater_fire_id"] = self.rater_fire_id     as AnyObject
        New["office_id"]     = self.office_id         as AnyObject
        New["id"]            = self.id                as AnyObject
        return New
    }
    
    func Upload() {
        guard let id = self.id else{print("rating not uploaded"); return }
        Firestore.firestore().collection("OfficeRatings").document(id).setData( MakeDictionary() )
    }
    
}


class OfficeRatingAip{
    
    static func GetAllRating(completion : @escaping (_ Product : [OfficeRatingObject])->()){
        var New : [OfficeRatingObject] = []
        Firestore.firestore().collection("OfficeRatings").getDocuments { (Snapshot, error) in
            if error != nil { print("Error") ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    New.append(OfficeRatingObject(Dictionary: data))
                }
            }
            completion(New)
        }
    }
    
    
    static func GetRatingByOfficeId(office_id : String,completion : @escaping (_ Product : OfficeRatingObject)->()){
        Firestore.firestore().collection("OfficeRatings").whereField("office_id", isEqualTo: office_id).getDocuments { (Snapshot, error) in
            if error != nil { print(error.debugDescription) ; return }
            guard let documents = Snapshot?.documents else { return }
            if documents != []{
                for P in documents {
                    if let data = P.data() as [String : AnyObject]? {
                        let New = OfficeRatingObject(Dictionary: data)
                        completion(New)
                    }
                }
            }
        }
    }
}








class UserTypeObject{
    
    var fire_id : String?
    var id : String?
    var type : String?
    var phone : String?
    
    init(fire_id : String,id : String,type : String , phone : String) {
        self.fire_id            = fire_id
        self.id                 = id
        self.type               = type
        self.phone              = phone
    }
    
    
    
    init(Dictionary : [String : AnyObject]) {
        self.id   = Dictionary[ "ld" ]         as? String
        self.fire_id = Dictionary[ "fire_id" ] as? String
        self.type = Dictionary[ "type" ]       as? String
        self.phone = Dictionary[ "phone" ]     as? String
    }
    

    func MakeDictionary() -> [String : AnyObject] {
        var New  : [String : AnyObject]  = [:]
        New["id"]   = self.id             as AnyObject
        New["fire_id"] = self.fire_id     as AnyObject
        New["type"] = self.type           as AnyObject
        New["phone"] = self.phone         as AnyObject
        return New
    }
    
    
    
    func Upload() {
        guard let id = self.id else{print("Users not uploaded"); return }
        Firestore.firestore().collection("Users").document(id).setData( MakeDictionary() )
    }
}

class UserTypeObjectAip{
    static func GetAllUsers(completion : @escaping (_ Product : [UserTypeObject])->()){
        var New : [UserTypeObject] = []
        Firestore.firestore().collection("Users").getDocuments { (Snapshot, error) in
            if error != nil { print("Error") ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    New.append(UserTypeObject(Dictionary: data))
                }
            }
            completion(New)
        }
    }
    
    
    
    static func GeUserTypeByFireId(fire_id : String , completion : @escaping (_ Product : UserTypeObject)->()){
        Firestore.firestore().collection("Users").whereField("fire_id", isEqualTo: fire_id).getDocuments { (Snapshot, error) in
            if error != nil { print(error.debugDescription) ; return }
            guard let documents = Snapshot?.documents else { return }
            if documents != []{
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    let New = UserTypeObject(Dictionary: data)
                    print(JSON(data))
                    completion(New)
                }
            }
            }else{
                completion(UserTypeObject.init(fire_id: "", id: "", type: "", phone: ""))
            }
        }
    }
    
}

















class SlidesObject{
    
    var image : String?
    var id : String?
    var link : String?
    
    init(image : String,id : String,link : String) {
        self.image               = image
        self.id                 = id
        self.link               = link
    }
    
    
    
    init(Dictionary : [String : AnyObject]) {
        self.id   = Dictionary[ "ld" ]   as? String
        self.image = Dictionary[ "image" ] as? String
        self.link = Dictionary[ "link" ] as? String
    }
    

    func MakeDictionary() -> [String : AnyObject] {
        var New  : [String : AnyObject]  = [:]
        New["id"]   = self.id        as AnyObject
        New["image"] = self.image     as AnyObject
        New["link"] = self.link      as AnyObject
        return New
    }
    
    
}

class SlidesAip{
    static func GetAllSlides(completion : @escaping (_ Product : [SlidesObject])->()){
        var New : [SlidesObject] = []
        Firestore.firestore().collection("Slides").getDocuments { (Snapshot, error) in
            if error != nil { print("Error") ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    New.append(SlidesObject(Dictionary: data))
                }
            }
            completion(New)
        }
    }
    
    
    
    static func GetProjectSlides(completion : @escaping (_ Product : [SlidesObject])->()){
        var New : [SlidesObject] = []
        Firestore.firestore().collection("ProjectSlides").getDocuments { (Snapshot, error) in
            if error != nil { print("Error") ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    New.append(SlidesObject(Dictionary: data))
                }
            }
            completion(New)
        }
    }
    
}




class EstateTypeObject{
    
    var ku_name : String?
    var ar_name : String?
    var name : String?
    var id : String?
    
    init(name : String,id : String , ar_name : String , ku_name : String) {
        self.name               = name
        self.id                 = id
        self.ku_name            = ku_name
        self.ar_name            = ar_name
    }
    
    
    
    init(Dictionary : [String : AnyObject]) {
        self.id   = Dictionary[ "Id" ]   as? String
        self.name = Dictionary[ "Name" ] as? String
        self.ku_name = Dictionary[ "ku_name" ] as? String
        self.ar_name = Dictionary[ "ar_name" ] as? String
    }
    

    func MakeDictionary() -> [String : AnyObject] {
        var New  : [String : AnyObject]  = [:]
        New["Id"]   = self.id       as AnyObject
        New["Name"] = self.name     as AnyObject
        New["ku_name"] = self.ku_name     as AnyObject
        New["ar_name"] = self.ar_name     as AnyObject
        return New
    }
    
    
}

class EstateTypeAip{
    static func GetEstateType(completion : @escaping (_ Product : [EstateTypeObject])->()){
        var New : [EstateTypeObject] = []
        Firestore.firestore().collection("EstateType").getDocuments { (Snapshot, error) in
            if error != nil { print("Error") ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    New.append(EstateTypeObject(Dictionary: data))
                }
            }
            completion(New)
        }
    }
    
    
    
    static func GeEstateTypeNameById(id : String , completion : @escaping (_ Product : EstateTypeObject)->()){
        Firestore.firestore().collection("EstateType").whereField("Id", isEqualTo: id).getDocuments { (Snapshot, error) in
            if error != nil { print(error.debugDescription) ; return }
            guard let documents = Snapshot?.documents else { return }
            if documents != []{
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    let New = EstateTypeObject(Dictionary: data)
                    print(JSON(data))
                    completion(New)
                }
            }
            }else{
                completion(EstateTypeObject.init(name: "", id: "",ar_name : "" ,ku_name : ""))
            }
        }
    }
    
}



class CityObject{
    var ku_name : String?
    var ar_name : String?
    var name : String?
    var id : String?
    var country_id : String?
    init(name : String,id : String , country_id : String, ar_name : String , ku_name : String) {
        self.name               = name
        self.id                 = id
        self.country_id         = country_id
        self.ku_name            = ku_name
        self.ar_name            = ar_name
    }
    
    
    
    init(Dictionary : [String : AnyObject]) {
        self.id   = Dictionary[ "Id" ]   as? String
        self.name = Dictionary[ "Name" ] as? String
        self.country_id = Dictionary["country_id"] as? String
        self.ku_name = Dictionary[ "ku_name" ] as? String
        self.ar_name = Dictionary[ "ar_name" ] as? String
    }
    

    func MakeDictionary() -> [String : AnyObject] {
        var New  : [String : AnyObject]  = [:]
        New["Id"]   = self.id       as AnyObject
        New["Name"] = self.name     as AnyObject
        New["country_id"] = self.country_id  as AnyObject
        New["ku_name"] = self.ku_name     as AnyObject
        New["ar_name"] = self.ar_name     as AnyObject
        return New
    }
    
    
}

class CityObjectAip{
    static func GetCities(completion : @escaping (_ Product : [CityObject])->()){
        var New : [CityObject] = []
        Firestore.firestore().collection("Cities").getDocuments { (Snapshot, error) in
            if error != nil { print("Error") ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    New.append(CityObject(Dictionary: data))
                }
            }
            completion(New)
        }
    }
}





class CountryObject{
    var ku_name : String?
    var ar_name : String?
    var name : String?
    var id : String?
    init(name : String,id : String , ar_name : String , ku_name : String) {
        self.name               = name
        self.id                 = id
        self.ku_name            = ku_name
        self.ar_name            = ar_name
    }
    
    
    
    init(Dictionary : [String : AnyObject]) {
        self.id   = Dictionary[ "id" ]   as? String
        self.name = Dictionary[ "name" ] as? String
        self.ku_name = Dictionary[ "ku_name" ] as? String
        self.ar_name = Dictionary[ "ar_name" ] as? String
    }
    

    func MakeDictionary() -> [String : AnyObject] {
        var New  : [String : AnyObject]  = [:]
        New["id"]   = self.id       as AnyObject
        New["name"] = self.name     as AnyObject
        New["ku_name"] = self.ku_name     as AnyObject
        New["ar_name"] = self.ar_name     as AnyObject
        return New
    }
    
    
}

class CountryObjectAip{
    static func GetCountries(completion : @escaping (_ Product : [CountryObject])->()){
        var New : [CountryObject] = []
        Firestore.firestore().collection("Countries").getDocuments { (Snapshot, error) in
            if error != nil { print("Error") ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    New.append(CountryObject(Dictionary: data))
                }
            }
            completion(New)
        }
    }
    
    
    static func GeCountryById(id : String , completion : @escaping (_ Product : CountryObject)->()){
        Firestore.firestore().collection("Countries").whereField("id", isEqualTo: id).getDocuments { (Snapshot, error) in
            if error != nil { print(error.debugDescription) ; return }
            guard let documents = Snapshot?.documents else { return }
            if documents != []{
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    let New = CountryObject(Dictionary: data)
                    print(JSON(data))
                    completion(New)
                }
            }
            }else{
                completion(CountryObject.init(name: "", id: "",ar_name : "" ,ku_name : ""))
            }
        }
    }
}






class TypesObject{
    var ku_name : String?
    var ar_name : String?
    var name : String?
    var id : String?
    
    init(name : String,id : String, ar_name : String , ku_name : String) {
        self.name               = name
        self.id                 = id
        self.ku_name            = ku_name
        self.ar_name            = ar_name
    }
    
    
    
    init(Dictionary : [String : AnyObject]) {
        self.id   = Dictionary[ "id" ]   as? String
        self.name = Dictionary[ "name" ] as? String
        self.ku_name = Dictionary[ "ku_name" ] as? String
        self.ar_name = Dictionary[ "ar_name" ] as? String
    }
    

    func MakeDictionary() -> [String : AnyObject] {
        var New  : [String : AnyObject]  = [:]
        New["id"]   = self.id       as AnyObject
        New["name"] = self.name     as AnyObject
        New["ku_name"] = self.ku_name     as AnyObject
        New["ar_name"] = self.ar_name     as AnyObject
        return New
    }
    
    
}

class TypesObjectAip{
    static func GetTypes(completion : @escaping (_ Product : [TypesObject])->()){
        var New : [TypesObject] = []
        Firestore.firestore().collection("Types").getDocuments { (Snapshot, error) in
            if error != nil { print("Error") ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    New.append(TypesObject(Dictionary: data))
                }
            }
            completion(New)
        }
    }
}







class ViewdItemsObject{
    var id : String?
    var fire_id : String?
    var estate_id : String?
    
    init(fire_id : String,estate_id : String, id : String) {
        self.id                    = id
        self.fire_id               = fire_id
        self.estate_id             = estate_id
    }
    
    
    
    init(Dictionary : [String : AnyObject]) {
        self.id          = Dictionary[ "id" ]          as? String
        self.estate_id   = Dictionary[ "estate_id" ]   as? String
        self.fire_id     = Dictionary[ "fire_id" ]     as? String
    }
    

    func MakeDictionary() -> [String : AnyObject] {
        var New  : [String : AnyObject]  = [:]
        New["id"]        = self.id            as AnyObject
        New["fire_id"]   = self.fire_id       as AnyObject
        New["estate_id"] = self.estate_id     as AnyObject
        return New
    }
    
    
    func Upload() {
        guard let id = self.id else{ return }
        Firestore.firestore().collection("ViewdItems").document(id).setData( MakeDictionary() )
    }
    
    
    func Remov() {
        guard let id = self.id else{ return }
        Firestore.firestore().collection("ViewdItems").document(id).delete()
    }
    
}

class ViewdItemsObjectAip{
    
    
    static func GetAllViewd(completion : @escaping (_ Product : [ViewdItemsObject])->()){
        var New : [ViewdItemsObject] = []
        Firestore.firestore().collection("ViewdItems").getDocuments { (Snapshot, error) in
            if error != nil { print("Error") ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    New.append(ViewdItemsObject(Dictionary: data))
                }
            }
            completion(New)
        }
    }
    
    
    
    static func  GetViewdItem(fire_id :  String , completion : @escaping (_ office : ViewdItemsObject)->()){
        Firestore.firestore().collection("ViewdItems").document(fire_id).addSnapshotListener { ( snopshot :  DocumentSnapshot?, error : Error?) in
            if let data = snopshot?.data() as [String: AnyObject ]? {
                let New = ViewdItemsObject(Dictionary: data)
                completion(New)
            }
        }
    }
    
    
    
    static func GeViewdItemsById(fire_id : String , completion : @escaping (_ Product : [ViewdItemsObject])->()){
        var New : [ViewdItemsObject] = []
        Firestore.firestore().collection("ViewdItems").whereField("fire_id", isEqualTo: fire_id).getDocuments { (Snapshot, error) in
            if error != nil { print(error.debugDescription) ; return }
            guard let documents = Snapshot?.documents else { return }
            if documents != []{
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    New.append(ViewdItemsObject(Dictionary: data))
                    print(JSON(data))
                }
            }
                completion(New)
            }else{
                completion([ViewdItemsObject.init(fire_id: "", estate_id: "", id: "")])
            }
        }
    }
    
    static func GeViewdItemById(fire_id : String , completion : @escaping (_ Product : ViewdItemsObject)->()){
        Firestore.firestore().collection("ViewdItems").whereField("fire_id", isEqualTo: fire_id).getDocuments { (Snapshot, error) in
            if error != nil { print(error.debugDescription) ; return }
            guard let documents = Snapshot?.documents else { return }
            if documents != []{
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                   let New = ViewdItemsObject(Dictionary: data)
                    print(JSON(data))
                    completion(New)
                }
            }
            }else{
                completion(ViewdItemsObject.init(fire_id: "", estate_id: "", id: ""))
            }
        }
    }
    
}



class FavoriteItemsObject{
    var id : String?
    var fire_id : String?
    var estate_id : String?
    
    init(fire_id : String,estate_id : String, id : String) {
        self.id                    = id
        self.fire_id               = fire_id
        self.estate_id             = estate_id
    }
    
    
    
    init(Dictionary : [String : AnyObject]) {
        self.id = Dictionary[ "id" ] as? String
        self.estate_id   = Dictionary[ "estate_id" ]   as? String
        self.fire_id = Dictionary[ "fire_id" ] as? String
    }
    

    func MakeDictionary() -> [String : AnyObject] {
        var New  : [String : AnyObject]  = [:]
        New["id"]        = self.id       as AnyObject
        New["fire_id"]   = self.fire_id       as AnyObject
        New["estate_id"] = self.estate_id     as AnyObject
        return New
    }
    
    
    
    func Upload() {
        guard let id = self.id else{ return }
        print("-----")
        Firestore.firestore().collection("FavoriteItems").document(id).setData( MakeDictionary() )
    }
    
    func Remov() {
        guard let id = id else{ return }
        Firestore.firestore().collection("FavoriteItems").document(id).delete()
    }
}

class FavoriteItemsObjectAip{
    
    
    
    static func GetAllFavorites(completion : @escaping (_ Product : [FavoriteItemsObject])->()){
        var New : [FavoriteItemsObject] = []
        Firestore.firestore().collection("FavoriteItems").getDocuments { (Snapshot, error) in
            if error != nil { print("Error") ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    New.append(FavoriteItemsObject(Dictionary: data))
                }
            }
            completion(New)
        }
    }
    
    
    
    static func  GetFavItem(fire_id :  String , completion : @escaping (_ office : FavoriteItemsObject)->()){
        Firestore.firestore().collection("FavoriteItems").document(fire_id).addSnapshotListener { ( snopshot :  DocumentSnapshot?, error : Error?) in
            if let data = snopshot?.data() as [String: AnyObject ]? {
                let New = FavoriteItemsObject(Dictionary: data)
                completion(New)
            }
            
            
        }
    }
    
    
    
    static func GetFavoriteItemsById(fire_id : String , completion : @escaping (_ Product : FavoriteItemsObject)->()){
        Firestore.firestore().collection("FavoriteItems").whereField("fire_id", isEqualTo: fire_id).getDocuments { (Snapshot, error) in
            if error != nil { print(error.debugDescription) ; return }
            guard let documents = Snapshot?.documents else { return }
            if documents != []{
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    let New = FavoriteItemsObject(Dictionary: data)
                    print(JSON(data))
                    completion(New)
                }
            }
            }else{
                completion(FavoriteItemsObject.init(fire_id: "", estate_id: "", id:""))
            }
        }
    }
    
}










class ProjectObject{
    
    var project_name : String?
    var project_ar_name : String?
    var project_ku_name : String?
    var id : String?
    var uploaded_date_stamp : TimeInterval?
    var Buildings_count : String?
    var from_price : Double?
    var monthly_fee : String?
    var project_office_phone: String?
    var address : String?
    var latitude : String?
    var longitude : String?
    var to_price : Double?
    var desc : String?
    var ar_desc : String?
    var ku_desc : String?
    var images : [String]?
    var project_state_id : String?
    var year : String?
    var video_link : String?
    var city_id : String?
    
    init(project_name : String,id : String , uploaded_date_stamp : TimeInterval ,Buildings_count: String, from_price : Double , monthly_fee : String , address : String ,latitude : String , longitude : String , to_price: Double, desc:String ,ar_desc : String,ku_desc : String , project_office_phone : String , images : [String] , project_state_id : String, year:String,video_link : String , city_id: String, project_ku_name : String , project_ar_name : String) {
        
        self.project_name        = project_name
        self.id                  = id
        self.address             = address
        self.monthly_fee         = monthly_fee
        self.from_price          = from_price
        self.to_price            = to_price
        self.images              = images
        self.latitude            = latitude
        self.longitude           = longitude
        self.year                = year
        self.uploaded_date_stamp = uploaded_date_stamp
        self.Buildings_count     = Buildings_count
        self.project_state_id    = project_state_id
        self.desc                = desc
        self.ar_desc             = ar_desc
        self.ku_desc             = ku_desc
        self.project_office_phone = project_office_phone
        self.video_link          = video_link
        self.city_id             = city_id
        self.project_ar_name     = project_ar_name
        self.project_ku_name     = project_ku_name
        
    }
    
    
    
    init(Dictionary : [String : AnyObject]) {
        self.project_name         = Dictionary[ "project_name"         ] as? String
        self.id                   = Dictionary[ "id"                   ] as? String
        self.address              = Dictionary[ "address"              ] as? String
        self.monthly_fee          = Dictionary[ "monthly_fee"          ] as? String
        self.from_price           = Dictionary[ "from_price"           ] as? Double
        self.to_price             = Dictionary[ "to_price"             ] as? Double
        self.images               = Dictionary[ "images"               ] as? [String]
        self.latitude             = Dictionary[ "latitude"             ] as? String
        self.longitude            = Dictionary[ "longitude"            ] as? String
        self.desc                 = Dictionary[ "desc"                 ] as? String
        self.ar_desc              = Dictionary[ "ar_desc"                 ] as? String
        self.ku_desc              = Dictionary[ "ku_desc"                 ] as? String
        self.year                 = Dictionary[ "year"                 ] as? String
        self.video_link           = Dictionary[ "youtube_link_id"      ] as? String
        self.uploaded_date_stamp  = Dictionary[ "uploaded_date_stamp"  ] as? TimeInterval
        self.project_state_id     = Dictionary[ "project_state_id"     ] as? String
        self.Buildings_count      = Dictionary[ "Buildings_count"      ] as? String
        self.project_ku_name      = Dictionary[ "project_ku_name"     ] as? String
        self.project_ar_name      = Dictionary[ "project_ar_name"      ] as? String
        self.city_id              = Dictionary[ "city_id"      ] as? String
        self.project_office_phone = Dictionary[ "project_office_phone" ] as? String
        
    }
    
}



class GetAllProjectsAip{
    static func GetAllProducts(completion : @escaping (_ Product : [ProjectObject])->()){
        var New : [ProjectObject] = []
        Firestore.firestore().collection("AllProjects").getDocuments { (Snapshot, error) in
            if error != nil { print("Error") ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    New.append(ProjectObject(Dictionary: data))
                }
            }
            completion(New)
        }
    }
    
    
    
    
    static func GeeProjectById(fire_id : String , completion : @escaping (_ Product : ProjectObject)->()){
        Firestore.firestore().collection("AllProjects").whereField("id", isEqualTo: fire_id).getDocuments { (Snapshot, error) in
            if error != nil { print(error.debugDescription) ; return }
            guard let documents = Snapshot?.documents else { return }
            if documents != []{
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    let New = ProjectObject(Dictionary: data)
                    print(JSON(data))
                    completion(New)
                }
            }
            }else{
                completion(ProjectObject(Dictionary: [:]))
            }
        }
    }
    
    
}





class UsersTypeObject{
    
    var type : String?
    var id : String?
    
    init(type : String,id : String) {
        self.type               = type
        self.id                 = id
    }
    
    
    
    init(Dictionary : [String : AnyObject]) {
        self.id   = Dictionary[ "Id" ]   as? String
        self.type = Dictionary[ "type" ] as? String
    }
    

    func MakeDictionary() -> [String : AnyObject] {
        var New  : [String : AnyObject]  = [:]
        New["Id"]   = self.id       as AnyObject
        New["type"] = self.type     as AnyObject
        return New
    }
    
    
}

class UsersTypeAip{
    static func GetEstateType(completion : @escaping (_ Product : [UsersTypeObject])->()){
        var New : [UsersTypeObject] = []
        Firestore.firestore().collection("UserTypes").getDocuments { (Snapshot, error) in
            if error != nil { print("Error") ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    New.append(UsersTypeObject(Dictionary: data))
                }
            }
            completion(New)
        }
    }
    
}




class SubscriptionsObject{
    
    var end_date : TimeInterval?
    var start_date : TimeInterval?
    var subscription_type_id : String?
    var user_id : String?
    var id : String?
    
    init(end_date : TimeInterval,start_date : TimeInterval,subscription_type_id : String,user_id : String,id : String) {
        self.end_date           = end_date
        self.start_date           = start_date
        self.subscription_type_id           = subscription_type_id
        self.user_id           = user_id
        self.id                 = id
    }
    
    
    
    init(Dictionary : [String : AnyObject]) {
        self.id   = Dictionary[ "Id" ]   as? String
        self.end_date = Dictionary[ "end_date" ] as? TimeInterval
        self.start_date = Dictionary[ "start_date" ] as? TimeInterval
        self.subscription_type_id = Dictionary[ "subscription_type_id" ] as? String
        self.user_id = Dictionary[ "user_id" ] as? String
    }
    

    func MakeDictionary() -> [String : AnyObject] {
        var New  : [String : AnyObject]  = [:]
        New["Id"]   = self.id       as AnyObject
        New["end_date"] = self.end_date     as AnyObject
        New["start_date"] = self.start_date     as AnyObject
        New["subscription_type_id"] = self.subscription_type_id     as AnyObject
        New["user_id"] = self.user_id     as AnyObject
        return New
    }
    
    
}

class SubscriptionAip{
    static func GetAllSubscriptionsType(completion : @escaping (_ Product : [SubscriptionsObject])->()){
        var New : [SubscriptionsObject] = []
        Firestore.firestore().collection("Subscription").getDocuments { (Snapshot, error) in
            if error != nil { print("Error") ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    New.append(SubscriptionsObject(Dictionary: data))
                }
            }
            completion(New)
        }
    }
    
    
    
    
    static func GetSubscriptionsByOfficeId(Office_id : String , completion : @escaping (_ Product : SubscriptionsObject)->()){
        Firestore.firestore().collection("Subscription").whereField("user_id", isEqualTo: Office_id).getDocuments { (Snapshot, error) in
            if error != nil { print(error.debugDescription) ; return }
            guard let documents = Snapshot?.documents else { return }
            if documents != []{
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    let New = SubscriptionsObject(Dictionary: data)
                    completion(New)
                }
            }
            }else{
                completion(SubscriptionsObject.init(end_date: 0.0, start_date: 0.0, subscription_type_id: "", user_id: "", id: ""))
            }
        }
    }
    
    
    
    
}


class SubscriptionsTypeObject{
    
    var title : String?
    var number_of_post : String?
    var id : String?
    
    init(title : String,id : String , number_of_post : String) {
        self.title               = title
        self.id                 = id
        self.number_of_post      = number_of_post
    }
    
    
    
    init(Dictionary : [String : AnyObject]) {
        self.id   = Dictionary[ "Id" ]   as? String
        self.title = Dictionary[ "title" ] as? String
        self.number_of_post = Dictionary[ "number_of_post" ] as? String
    }
    

    func MakeDictionary() -> [String : AnyObject] {
        var New  : [String : AnyObject]  = [:]
        New["Id"]   = self.id       as AnyObject
        New["type"] = self.title     as AnyObject
        New["number_of_post"] = self.number_of_post  as AnyObject
        return New
    }
    
    
}

class SubscriptionsTypeAip{
    static func GetAllSubscriptionsTypeType(completion : @escaping (_ Product : [SubscriptionsTypeObject])->()){
        var New : [SubscriptionsTypeObject] = []
        Firestore.firestore().collection("SubscriptionTypes").getDocuments { (Snapshot, error) in
            if error != nil { print("Error") ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    New.append(SubscriptionsTypeObject(Dictionary: data))
                }
            }
            completion(New)
        }
    }
    
    
    static func GetSubscriptionsTypeByOfficeId(id : String , completion : @escaping (_ Product : SubscriptionsTypeObject)->()){
        Firestore.firestore().collection("SubscriptionTypes").whereField("id", isEqualTo: id).getDocuments { (Snapshot, error) in
            if error != nil { print(error.debugDescription) ; return }
            guard let documents = Snapshot?.documents else { return }
            if documents != []{
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    let New = SubscriptionsTypeObject(Dictionary: data)
                    completion(New)
                }
            }
            }else{
                completion(SubscriptionsTypeObject.init(title: "", id: "", number_of_post: ""))
            }
        }
    }
    
}








class BoundTypeObject{
    
    var en_title : String?
    var ar_title : String?
    var ku_title : String?
    var id : String?
    
    init(en_title : String,id : String , ar_title : String, ku_title : String) {
        self.en_title           = en_title
        self.id                 = id
        self.ar_title           = ar_title
        self.ku_title           = ku_title
    }
    
    
    
    init(Dictionary : [String : AnyObject]) {
        self.id   = Dictionary[ "id" ]   as? String
        self.en_title = Dictionary[ "en_title" ] as? String
        self.ar_title   = Dictionary[ "ar_title" ]   as? String
        self.ku_title = Dictionary[ "ku_title" ] as? String
    }
    

    func MakeDictionary() -> [String : AnyObject] {
        var New  : [String : AnyObject]  = [:]
        New["id"]   = self.id       as AnyObject
        New["en_title"] = self.en_title     as AnyObject
        New["ar_title"]   = self.ar_title       as AnyObject
        New["ku_title"] = self.ku_title     as AnyObject
        return New
    }
    
    
}

class BoundTypeAip{
    static func GetAllBoundType(completion : @escaping (_ Product : [BoundTypeObject])->()){
        var New : [BoundTypeObject] = []
        Firestore.firestore().collection("BoundTypes").getDocuments { (Snapshot, error) in
            if error != nil { print("Error") ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    New.append(BoundTypeObject(Dictionary: data))
                }
            }
            completion(New)
        }
    }
    
    
    static func GetBoundTypeByOfficeId(id : String , completion : @escaping (_ Product : BoundTypeObject)->()){
        Firestore.firestore().collection("BoundTypes").whereField("id", isEqualTo: id).getDocuments { (Snapshot, error) in
            if error != nil { print(error.debugDescription) ; return }
            guard let documents = Snapshot?.documents else { return }
            if documents != []{
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    let New = BoundTypeObject(Dictionary: data)
                    completion(New)
                }
            }
            }else{
                completion(BoundTypeObject.init(en_title: "", id: "",ar_title: "" , ku_title: ""))
            }
        }
    }
    
}





class ProjectStatesObject{
    
    
    var ar_title : String?
    var ku_title : String?
    var title : String?
    var id : String?
    
    
    init(title : String,id : String , ar_title : String, ku_title: String) {
        self.title           = title
        self.id              = id
        
        self.ar_title           = ar_title
        self.ku_title           = ku_title
    }

    
    init(Dictionary : [String : AnyObject]) {
        self.id    = Dictionary[ "id" ]   as? String
        self.title = Dictionary[ "title" ] as? String
        
        self.ar_title    = Dictionary[ "ar_title" ]   as? String
        self.ku_title = Dictionary[ "ku_title" ] as? String
    }
    

    func MakeDictionary() -> [String : AnyObject] {
        var New  : [String : AnyObject]  = [:]
        New["id"]    = self.id       as AnyObject
        New["title"] = self.title     as AnyObject
        
        New["ar_title"]    = self.ar_title       as AnyObject
        New["ku_title"] = self.ku_title     as AnyObject
        return New
    }
    
    
}

class ProjectStatesAip{
    static func GetAllProjectStates(completion : @escaping (_ Product : [ProjectStatesObject])->()){
        var New : [ProjectStatesObject] = []
        Firestore.firestore().collection("ProjectStates").getDocuments { (Snapshot, error) in
            if error != nil { print("Error") ; return }
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    New.append(ProjectStatesObject(Dictionary: data))
                }
            }
            completion(New)
        }
    }
    
    
    static func GetProjectStatesId(id : String , completion : @escaping (_ Product : ProjectStatesObject)->()){
        Firestore.firestore().collection("ProjectStates").whereField("id", isEqualTo: id).getDocuments { (Snapshot, error) in
            if error != nil { print(error.debugDescription) ; return }
            guard let documents = Snapshot?.documents else { return }
            if documents != []{
            for P in documents {
                if let data = P.data() as [String : AnyObject]? {
                    let New = ProjectStatesObject(Dictionary: data)
                    completion(New)
                }
            }
            }else{
                completion(ProjectStatesObject.init(title: "", id: "",ar_title: "", ku_title: ""))
            }
        }
    }
    
}


