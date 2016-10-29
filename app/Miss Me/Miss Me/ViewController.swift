import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    var location: CLLocation?
    var locationString = ""
    var isUpdatingLocation = false
    
    var longitude: String = ""
    var latitude: String = ""
    
    var geocoder = CLGeocoder()
    var placemark: CLPlacemark?
    var isReverseGeocoding = false
    
    var deviceUDID: String = ""
    
    @IBAction func pressedButton(_ sender: AnyObject) {
        let authStatus = CLLocationManager.authorizationStatus()
        
        if authStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
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
    
    @IBAction func goInside(_ sender: AnyObject) {
        performSegue(withIdentifier: "showMenu", sender: self)
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
    
    func showInsufficientPermissions() {
        let alert = UIAlertController(title: "Location Services Disabled",
                                      message: "Please enable location services for MissMe in Settings to use this feature`.",
                                      preferredStyle: .alert)
        
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(okayAction)
        
        present(alert, animated: true, completion: nil)
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
                
                print("Q: Lat: \(latitude), Long: \(longitude)")
                print("Q: \(deviceUDID)")
                print("Q: \(locationString)")
                
                stopLocationManager()
            } else {
                locationString = "Could not obtain address."
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deviceUDID = (UIDevice.current.identifierForVendor?.uuidString)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
