import Foundation
import UIKit
import MapKit
import CoreLocation

var selectedID = ""
var selectedSurname = ""

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
    let userLabel = UILabel()
    let phoneLabel = UILabel()
    
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
            address += streetName
        }
        
        if address == "" {
            address = "No address available."
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
        locationLabel.font = UIFont(name: "SourceSansPro-Regular", size: 17.0)
        view.addSubview(locationLabel)
        
        let userIcon = UIImage(named: "user.png")
        let userImage = UIImageView(image: userIcon)
        userImage.frame = CGRect(x: 25, y: headerheight + (height * 0.4) + 45 + iconSize, width: iconSize, height: iconSize)
        view.addSubview(userImage)
        
        userLabel.frame = CGRect(x: 40 + iconSize, y: headerheight + (height * 0.4) + 45 + iconSize, width: width - 65 - iconSize, height: iconSize)
        userLabel.textAlignment = .left
        userLabel.text = (selectedSurname == "") ? "No profile selected" : selectedSurname
        userLabel.font = UIFont(name: "SourceSansPro-Regular", size: 17.0)
        view.addSubview(userLabel)
        
        let phoneIcon = UIImage(named: "phone.png")
        let phoneImage = UIImageView(image: phoneIcon)
        phoneImage.frame = CGRect(x: 25, y: headerheight + (height * 0.4) + 60 + (2 * iconSize), width: iconSize, height: iconSize)
        view.addSubview(phoneImage)
        
        phoneLabel.frame = CGRect(x: 40 + iconSize, y: headerheight + (height * 0.4) + 60 + (2 * iconSize), width: width - 65 - iconSize, height: iconSize)
        phoneLabel.textAlignment = .left
        phoneLabel.text = "+44 7502346229"
        phoneLabel.font = UIFont(name: "SourceSansPro-Regular", size: 17.0)
        view.addSubview(phoneLabel)
        
        let submitButton = UIButton()
        submitButton.setTitle("Submit Sighting", for: .normal)
        submitButton.setTitleColor(UIColor(red: 0.227, green: 0.741, blue: 0.686, alpha: 1), for: .normal)
        submitButton.titleLabel!.font = UIFont(name: "SourceSansPro-Semibold", size: 18)
        submitButton.addTarget(self, action: #selector(ReportViewController.submitSighting), for: .touchUpInside)
        submitButton.frame = CGRect(x: width / 4, y: headerheight + (height * 0.4) + 83 + (3 * iconSize), width: width / 2, height: 12)
        view.addSubview(submitButton)
    }
    
    func submitSighting() {
        if userLabel.text != "No profile selected" {
            if let location = location {
                postJSON(userID: selectedID, lat: location.coordinate.latitude, long: location.coordinate.longitude, contactNo: phoneLabel.text!, deviceID: deviceUDID)
            }
        } else {
            let alert = UIAlertController(title: "No Profile Selected",
                                          message: "Please select a profile from 'Database' first.",
                                          preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(okayAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func postJSON(userID: String, lat: Double,
                        long: Double, contactNo: String, deviceID: String) {
        
        let todayDate = NSDate()
        let formattedDate = DateFormatter()
        formattedDate.dateFormat = "yyyy-MM-dd"
        let formattedTime = DateFormatter()
        formattedTime.dateFormat = "HH:mm:ss"
        
        let prefix = formattedDate.string(from: todayDate as Date)
        let suffix = formattedTime.string(from: todayDate as Date)
        let dateTime = prefix + "T" + suffix
        
        var requestText = "{\"IsVerified\":false,\"DateTime\":"
        requestText += "\"\(dateTime)\",\"LocationType\":\"App Sighting\",\"UserID\":\""
        requestText += userID + "\",\"Latitude\":" + String(lat) + ",\"Longitude\":" + String(long)
        requestText += ",\"ContactNumber\":\"" + contactNo + "\",\"DeviceID\":\"" + deviceID + "\"}"
        
        print(requestText)
        
        let myUrl = URL(string: "http://192.168.226.201:54621/api/Sightings/")
        
        var request = URLRequest(url:myUrl!)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        request.httpBody = requestText.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil
            {
                print("error=\(error)")
                return
            }
            print("response = \(response)")
        }
        task.resume()
        
        let alert = UIAlertController(title: "Submit Successful",
                                      message: "Thank you for your submission.",
                                      preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "No problem. 😄", style: .default, handler: nil)
        alert.addAction(okayAction)
        present(alert, animated: true, completion: nil)
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
