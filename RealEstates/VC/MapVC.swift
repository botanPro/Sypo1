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
                 if XLanguage.get() == .English{
                     let ac = UIAlertController(title: "Location not found", message: "Please select location", preferredStyle: .alert)
                     ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                         ac.dismiss(animated: true)
                     }))
                     present(ac, animated: true)
                 }else if XLanguage.get() == .Arabic{
                     let ac = UIAlertController(title: "لم يتم العثور على الموقع", message: "الرجاء تحديد الموقع", preferredStyle: .alert)
                     ac.addAction(UIAlertAction(title: "نعم", style: .default, handler: { _ in
                         ac.dismiss(animated: true)
                     }))
                     present(ac, animated: true)
                 }else{
                     let ac = UIAlertController(title: "شوێنەکە نەدۆزرایەوە", message: "تکایە شوێن هەڵبژێرە", preferredStyle: .alert)
                     ac.addAction(UIAlertAction(title: "باشە", style: .default, handler: { _ in
                         ac.dismiss(animated: true)
                     }))
                     present(ac, animated: true)
                 }
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
