import UIKit
import MapKit

var deviceUDID: String = ""

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
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
    }
    
    @IBAction func pressedButton(_ sender: AnyObject) {
        requestLocation()
        pinCurrentLocation()
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
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
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
            
            centreMapTo(point: location)
            
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
                
                print("Q: Lat: \(latitude), Long: \(longitude)")
                print("Q: \(deviceUDID)")
                print("Q: \(locationString)")
                
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
        
        if let location = location {
            centreMapTo(point: location)
        }

        view.addSubview(mapView)
    }
    
    func centreMapTo(point: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: point.coordinate.latitude, longitude: point.coordinate.longitude), 3000, 3000)
            mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapAddPinAt(point: CLLocation, withTitle: String) {
        let pinLocation = CLLocationCoordinate2DMake(point.coordinate.latitude, point.coordinate.longitude)
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = pinLocation
        objectAnnotation.title = withTitle
        self.mapView.addAnnotation(objectAnnotation)
    }
    
    func pinCurrentLocation() {
        if isMyLocationPinned {
            self.mapView.removeAnnotation(myLocationAnnotation)
        }
        if let location = location {
            let pinLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            myLocationAnnotation.coordinate = pinLocation
            myLocationAnnotation.title = "Current Location"
            self.mapView.addAnnotation(myLocationAnnotation)
            isMyLocationPinned = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
