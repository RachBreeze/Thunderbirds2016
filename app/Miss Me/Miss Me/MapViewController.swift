import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    
    var mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = view.frame.width
        height = view.frame.height
        
        mapView.frame = CGRect(x: width * 0.05, y: width * 0.25, width: width * 0.9, height: height * 0.3)
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        view.addSubview(mapView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
