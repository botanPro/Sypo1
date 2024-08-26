//
//  MapVC.swift
//  RealEstates
//
//  Created by botan pro on 1/27/22.
//

import UIKit
import MapKit



class MapVC: UIViewController ,MKMapViewDelegate ,CLLocationManagerDelegate, UIGestureRecognizerDelegate{
    
    
    @IBAction func Dismiss(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MapDissmised"), object: nil , userInfo: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var MapView: MKMapView!
    
    
    
    var profileIn : [profile] = []
    var AnnotationArray : [Place] = []
    private var locationManager: CLLocationManager!
    private var location: MKAnnotation!
    private var currentLocation: CLLocation?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        gestureRecognizer.delegate = self
        MapView.addGestureRecognizer(gestureRecognizer)
        self.MapView.showsUserLocation = true
        
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        self.cordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        defer { currentLocation = locations.last }

      if currentLocation == nil {
          if let userLocation = locations.last {
              let viewRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 8000, longitudinalMeters: 8000)
              MapView.setRegion(viewRegion, animated: false)
          }
      }
  }
    
    

    
    var cordinate : CLLocationCoordinate2D!
    var latitude : CLLocationDegrees!
    var longtitude : CLLocationDegrees!
    var IsTaped : Bool = false
    var annotation : MKPointAnnotation!
    
    
    @objc func handleTap(_ gestureReconizer: UILongPressGestureRecognizer) {
       if let anno = annotation{
            self.MapView.removeAnnotation(anno)
        }
        let location = gestureReconizer.location(in: MapView)
        let coordinate = MapView.convert(location,toCoordinateFrom: MapView)
        
        annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        MapView.addAnnotation(annotation)

        self.latitude = annotation.coordinate.latitude
        self.longtitude = annotation.coordinate.longitude
        self.IsTaped = true
    }
    
    
    
    @IBAction func Save(_ sender: Any) {
        if IsTaped == true {
             if let lat = self.latitude, let lon = self.longtitude{
                 let Data:[String: CLLocationDegrees] = ["latitude": lat , "longtitude" : lon]
                 NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CordinateComing"), object: nil , userInfo: Data)
                 self.dismiss(animated: true, completion: nil)
             }
         }else{
             if let lat = self.cordinate?.latitude, let long = self.cordinate?.longitude{
                 let Data:[String: CLLocationDegrees] = ["latitude": lat , "longtitude" : long]
                 NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CordinateComing"), object: nil , userInfo: Data)
                 self.dismiss(animated: true, completion: nil)
             }else{
                 var title = ""
                 var message = ""
                 var okText = ""
                     
                     if XLanguage.get() == .Kurdish {
                         title = "شوێنەکە نەدۆزرایەوە"
                         message = "تکایە شوێن هەڵبژێرە"
                         okText = "باشە"
                     }else if XLanguage.get() == .Arabic{
                         title = "لم يتم العثور على الموقع"
                         message = "الرجاء تحديد الموقع"
                         okText = "نعم"
                     }else if XLanguage.get() == .English {
                         title = "Location not found"
                         message = "Please select location"
                         okText = "OK"
                     } else if XLanguage.get() == .French {
                         title = "Emplacement non trouvé"
                         message = "Veuillez sélectionner un emplacement"
                         okText = "OK"
                     } else if XLanguage.get() == .Spanish {
                         title = "Ubicación no encontrada"
                         message = "Por favor, seleccione ubicación"
                         okText = "OK"
                     } else if XLanguage.get() == .German {
                         title = "Standort nicht gefunden"
                         message = "Bitte Standort auswählen"
                         okText = "OK"
                     } else if XLanguage.get() == .Dutch {
                         title = "Locatie niet gevonden"
                         message = "Selecteer alstublieft een locatie"
                         okText = "OK"
                     } else if XLanguage.get() == .Portuguese {
                         title = "Localização não encontrada"
                         message = "Por favor, selecione a localização"
                         okText = "OK"
                     } else if XLanguage.get() == .Russian {
                         title = "Местоположение не найдено"
                         message = "Пожалуйста, выберите местоположение"
                         okText = "ОК"
                     } else if XLanguage.get() == .Chinese {
                         title = "未找到位置"
                         message = "请选择位置"
                         okText = "确定"
                     } else if XLanguage.get() == .Hindi {
                         title = "स्थान नहीं मिला"
                         message = "कृपया स्थान चुनें"
                         okText = "ठीक है"
                     } else if XLanguage.get() == .Swedish {
                         title = "Platsen hittades inte"
                         message = "Vänligen välj plats"
                         okText = "OK"
                     } else if XLanguage.get() == .Greek {
                         title = "Η τοποθεσία δεν βρέθηκε"
                         message = "Επιλέξτε τοποθεσία"
                         okText = "ΟΚ"
                     }
                     
                     let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
                     ac.addAction(UIAlertAction(title: okText, style: .default, handler: { _ in
                         ac.dismiss(animated: true)
                     }))
                     
             }
         }
    }
}





class profile : MKPointAnnotation {
    var profileId = ""
}


class Place :  NSObject , MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var profileId = ""
    var title :String?
    var subtitle: String?
    
    init(coordinate : CLLocationCoordinate2D , profileId : String,title : String? , subtitle :String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.profileId = profileId
    }
    
}
