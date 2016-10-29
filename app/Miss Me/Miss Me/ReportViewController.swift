import UIKit
import MapKit
import CoreLocation

class ReportViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    var location: CLLocation?
    var locationString = ""
    var isUpdatingLocation = false
    
    var longitude: String = ""
    var latitude: String = ""
    
    var geocoder = CLGeocoder()
    var placemark: CLPlacemark?
    var isReverseGeocoding = false
    
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    
    var myLocationAnnotation = MKPointAnnotation()
    var isMyLocationPinned = false
    
    var mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = view.frame.width
        height = view.frame.height
        
        requestLocation()
        mapInit()
        
        deviceUDID = (UIDevice.current.identifierForVendor?.uuidString)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func requestLocation() {
        let authStatus = CLLocationManager.authorizationStatus()
        
        if authStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            if authStatus == .authorizedWhenInUse {
                startLocationManager()
            }
        } else if authStatus == .denied || authStatus == .restricted {
            showInsufficientPermissions()
        } else {
            if !isUpdatingLocation {
                startLocationManager()
            } else {
                stopLocationManager()
            }
        }
    }
    
    func showInsufficientPermissions() {
        let alert = UIAlertController(title: "Location Services Disabled",
                                      message: "Please enable location services for MissMe in Settings to use this feature.",
                                      preferredStyle: .alert)
        
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(okayAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func startLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
            isUpdatingLocation = true
        }
    }
    
    func stopLocationManager() {
        if isUpdatingLocation {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            
            isUpdatingLocation = false
        }
    }
    
    func obtainAddress(placemark: CLPlacemark) -> String {
        var address = ""
        
        if let houseNum = placemark.subThoroughfare {
            address += houseNum + " "
        }
        
        if let streetName = placemark.thoroughfare {
            address += streetName + ", "
        }
        
        if let city = placemark.locality {
            address += city + ", "
        }
        
        if let state = placemark.administrativeArea {
            address += state + ", "
        }
        
        if let postcode = placemark.postalCode {
            address += postcode + "."
        }
        
        return address
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError \(error)")
        stopLocationManager()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last!
        print("didUpdateLocations \(newLocation)")
        location = newLocation
        
        if let location = location {
            longitude = String(format: "%.8f", location.coordinate.longitude)
            latitude = String(format: "%.8f", location.coordinate.latitude)

            if !isReverseGeocoding {
                isReverseGeocoding = true
                geocoder.reverseGeocodeLocation(location, completionHandler: {
                    placemarks, error in
                    if error == nil, let p = placemarks, !p.isEmpty {
                        self.placemark = p.last!
                    }
                    self.isReverseGeocoding = false
                })
            }
            
            if let placemark = placemark {
                locationString = obtainAddress(placemark: placemark)
                stopLocationManager()
            } else {
                locationString = "Could not obtain address."
            }
        }
    }
    
    func mapInit() {
        mapView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        view.addSubview(mapView)
        
        if let location = location {
            focusMapAt(point: location)
        }
    }
    
    func focusMapAt(point: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: point.coordinate.latitude, longitude: point.coordinate.longitude), 1000, 1000)
        mapView.setRegion(coordinateRegion, animated: true)
        
        let pinLocation = CLLocationCoordinate2DMake(point.coordinate.latitude, point.coordinate.longitude)
        let pinAnnotation = MKPointAnnotation()
        pinAnnotation.coordinate = pinLocation
        self.mapView.addAnnotation(pinAnnotation)
    }
}
