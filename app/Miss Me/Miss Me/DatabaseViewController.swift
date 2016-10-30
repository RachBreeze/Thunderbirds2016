import UIKit
import MapKit
import CoreLocation

class DatabaseViewController: UITableViewController {
    
    var geocoder = CLGeocoder()
    var placemark: CLPlacemark?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableView.contentInset = UIEdgeInsetsMake(64, -5, 49, 0);
    }
    
    @IBAction func refreshNearby(_ sender: AnyObject) {
        readJSON()
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tempCell", for: indexPath)
        
        let i = indexPath.row
        
        let profileImage = cell.viewWithTag(100)! as! UIImageView
        if let url = NSURL(string: people[i].profileURL) {
            if let data = NSData(contentsOf: url as URL) {
                profileImage.image = UIImage(data: data as Data)
                profileImage.contentMode = .scaleAspectFit
            }        
        }
        
        let profileNameAge = cell.viewWithTag(101)! as! UILabel
        var name = people[i].surname
        
        let age = people[i].age
        if age != 0 {
            name += ", " + String(age)
        }
        profileNameAge.text = name
        
        if people[i].isDangerous == true {
            profileNameAge.textColor = UIColor.red
        }
        
        let profileLocation = cell.viewWithTag(102)! as! UILabel
        let location = "Lat: " + String(people[i].latitude) + ", Long: " + String(people[i].longtitude)
        profileLocation.text = location
        
        let profileDateTime = cell.viewWithTag(103)! as! UILabel
        let dateTime = "On " + people[i].lastSeenDate
        let fixedDTString = dateTime.replacingOccurrences(of: "T", with: " at ", options: .literal, range: nil)
        profileDateTime.text = fixedDTString

        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
