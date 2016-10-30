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
    var headerheight: CGFloat = 0.0
    
    var myLocationAnnotation = MKPointAnnotation()
    var isMyLocationPinned = false
    
    var mapView = MKMapView()
    
    let locationLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = view.frame.width
        height = view.frame.height
        headerheight = UIApplication.shared.statusBarFrame.height + self.navigationController!.navigationBar.frame.height
        
        requestLocation()
        mapInit()
        formInit()
        
        deviceUDID = (UIDevice.current.identifierForVendor?.uuidString)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func updateMyLocation(_ sender: AnyObject) {
        requestLocation()
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
        
        return address
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError \(error)")
        stopLocationManager()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last!
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
                locationLabel.text = locationString
                focusMapAt(point: location)
                stopLocationManager()
                print(locationString)
            } else {
                locationString = "No address for current location."
            }
        }
    }
    
    func mapInit() {
        mapView.frame = CGRect(x: 15, y: headerheight + 15, width: width - 30, height: height * 0.4)
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
        
        view.addSubview(mapView)
        
        if let location = location {
            focusMapAt(point: location)
        }
    }
    
    func formInit() {
        let iconSize = width * 0.1
        
        let locationIcon = UIImage(named: "location.png")
        let locationImage = UIImageView(image: locationIcon)
        locationImage.frame = CGRect(x: 25, y: headerheight + (height * 0.4) + 30, width: iconSize, height: iconSize)
        view.addSubview(locationImage)
    
        locationLabel.frame = CGRect(x: 40 + iconSize, y: headerheight + (height * 0.4) + 30, width: width - 65 - iconSize, height: iconSize)
        locationLabel.textAlignment = .left
        locationLabel.text = locationString
        view.addSubview(locationLabel)
        
        let userIcon = UIImage(named: "user.png")
        let userImage = UIImageView(image: userIcon)
        userImage.frame = CGRect(x: 25, y: headerheight + (height * 0.4) + 45 + iconSize, width: iconSize, height: iconSize)
        view.addSubview(userImage)
        
        let phoneIcon = UIImage(named: "phone.png")
        let phoneImage = UIImageView(image: phoneIcon)
        phoneImage.frame = CGRect(x: 25, y: headerheight + (height * 0.4) + 60 + (2 * iconSize), width: iconSize, height: iconSize)
        view.addSubview(phoneImage)
    }
    
    func focusMapAt(point: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: point.coordinate.latitude, longitude: point.coordinate.longitude), 300, 300)
        mapView.setRegion(coordinateRegion, animated: true)
        
        if isMyLocationPinned {
            self.mapView.removeAnnotation(myLocationAnnotation)
        }
        
        let pinLocation = CLLocationCoordinate2DMake(point.coordinate.latitude, point.coordinate.longitude)
        myLocationAnnotation = MKPointAnnotation()
        myLocationAnnotation.coordinate = pinLocation
        self.mapView.addAnnotation(myLocationAnnotation)
        isMyLocationPinned = true
    }
}
