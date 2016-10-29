import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    var location: CLLocation?
    var updatingLocation = false
    
    var longitude: String = ""
    var latitude: String = ""
    
    var deviceUDID: String = ""
    
    @IBAction func pressedButton(_ sender: AnyObject) {
        let authStatus = CLLocationManager.authorizationStatus()
        
        if authStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if authStatus == .denied || authStatus == .restricted {
            showInsufficientPermissions()
        } else {
            if !updatingLocation {
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
        
            updatingLocation = true
        }
    }
    
    func stopLocationManager() {
        if updatingLocation {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            
            updatingLocation = false
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
            print("Q: Lat: \(latitude), Long: \(longitude)")
            print("Q: \(deviceUDID)")
            stopLocationManager()
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
