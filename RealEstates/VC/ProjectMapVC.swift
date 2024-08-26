//
//  ProjectMapVC.swift
//  RealEstates
//
//  Created by Botan Amedi on 10/08/2022.
//

import UIKit
import MapKit
import NVActivityIndicatorView
import Drops
class ProjectMapVC: UIViewController , MKMapViewDelegate, CLLocationManagerDelegate{

    
    @IBOutlet weak var MapView: MKMapView!
    var Locations : [Place] = []
    private var locationManager: CLLocationManager!
    private var location: MKAnnotation!
    private var currentLocation: CLLocation?
    var lat = ""
    var long = ""
    
    
    @IBOutlet weak var NVLoaderView: NVActivityIndicatorView!
    @IBAction func Dismiss(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        XLocations.Shared.GetUserLocation()
        XLocations.Shared.GotLocation = {
           self.lat =  String(XLocations.Shared.latitude)
           self.long =  String(XLocations.Shared.longtude)
       }
        self.MapView.showsUserLocation = true


        DispatchQueue.main.async {
            XLocations.Shared.LocationManager.startUpdatingHeading()
        }
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        self.MapView.delegate = self
        GetEProjects()
    }
    
    
    var AllProjects : [ProjectObject] = []
    func GetEProjects(){
        self.NVLoaderView.startAnimating()
            if AllProjects.count == 0{
                var title = "Empty"
                var message = "No projects are found"
                
                if XLanguage.get() == .Kurdish{
                    title = "بەتاڵ"
                    message = "هیچ پرۆژەیەک نەدۆزراوەتەوە"
                } else if XLanguage.get() == .Arabic{
                    title = "فارغة"
                    message = "لم يتم العثور على مشاريع"
                } else if XLanguage.get() == .English {
                    title = "Empty"
                    message = "No projects are found"
                } else if XLanguage.get() == .Dutch {
                    title = "Leeg"
                    message = "Geen projecten gevonden"
                } else if XLanguage.get() == .French {
                    title = "Vide"
                    message = "Aucun projet trouvé"
                } else if XLanguage.get() == .Spanish {
                    title = "Vacío"
                    message = "No se encontraron proyectos"
                } else if XLanguage.get() == .German {
                    title = "Leer"
                    message = "Keine Projekte gefunden"
                } else if XLanguage.get() == .Hebrew {
                    title = "ריק"
                    message = "לא נמצאו פרויקטים"
                } else if XLanguage.get() == .Chinese {
                    title = "空的"
                    message = "未找到任何项目"
                } else if XLanguage.get() == .Hindi {
                    title = "खाली"
                    message = "कोई परियोजनाएं नहीं मिलीं"
                } else if XLanguage.get() == .Portuguese {
                    title = "Vazio"
                    message = "Nenhum projeto encontrado"
                } else if XLanguage.get() == .Russian {
                    title = "Пусто"
                    message = "Проекты не найдены"
                } else if XLanguage.get() == .Swedish {
                    title = "Tomt"
                    message = "Inga projekt hittades"
                } else if XLanguage.get() == .Greek {
                    title = "Άδειο"
                    message = "Δεν βρέθηκαν έργα"
                }
                let drop = Drop(
                    title: title,
                    subtitle: message,
                    icon: UIImage(named: "attention"),
                    action: .init {
                        print("Drop tapped")
                        Drops.hideCurrent()
                    },
                    position: .bottom,
                    duration: 3.0,
                    accessibility: "Alert: Title, Subtitle"
                )
                Drops.show(drop)
            }
            for pro in AllProjects{
                let lat = Double(pro.latitude ?? "")
                let long = Double(pro.longitude ?? "")
                self.Locations.append(Place(coordinate: CLLocationCoordinate2D(latitude: lat ?? 0.0, longitude: long ?? 0.0), profileId: pro.id ?? "", title: pro.project_name ?? "", subtitle: pro.address ?? ""))
                
            }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.NVLoaderView.stopAnimating()
        }
            
            self.MapView.addAnnotations(self.Locations)
    }
    
    var selectedAnnotation: Place?
    var selectedPro: ProjectObject?
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.selectedAnnotation = view.annotation as? Place
        for pro in AllProjects {
            if pro.id == selectedAnnotation?.profileId{
                self.selectedPro = pro
            }
        }
    }
       
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      defer { currentLocation = locations.last }

      if currentLocation == nil {
          if let userLocation = locations.last {
              let viewRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 8000, longitudinalMeters:8000)
              MapView.setRegion(viewRegion, animated: false)
          }
      }
  }
    
    
    
    
    var Count = 0
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Place else {return nil }

           let identifier = "Capital"
           var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

           if annotationView == nil {
               annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
               annotationView?.canShowCallout = true
               annotationView?.image = UIImage(named: "pin")
               let btn = UIButton(type: .detailDisclosure)
               btn.addTarget(self, action: #selector(callSegueFromCell(_:)), for: .touchUpInside)
               annotationView?.rightCalloutAccessoryView = btn
           } else {
               annotationView?.annotation = annotation
           }
           return annotationView
    }
    
    
    @objc  func callSegueFromCell(_ sender:UIButton) {
        self.performSegue(withIdentifier: "Next", sender: self.selectedPro)
    }
    


override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if let pro = sender as? ProjectObject{
        if let next = segue.destination as? ProjectDetailsVC{
            next.ProjectEstate = pro
        }
    }
}
    
    

}
