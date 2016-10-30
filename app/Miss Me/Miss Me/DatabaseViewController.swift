import UIKit

class DatabaseViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func refreshNearby(_ sender: AnyObject) {
        readJSON()
    }
    
//    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell {
////        let cell = tableView.dequeueReusableCell(withIdentifier: "tempCell", for: indexPath as IndexPath) as UITableViewCell
////        
////        let i = indexPath.row
////        
////        var profileImage = cell.viewWithTag(100)! as! UIImageView
////        
////        
////        var profileNameAge = cell.viewWithTag(101)! as! UILabel
////        let nameAge = people[i].forename + " " + people[i].surname
////        
////        var profileLocation = cell.viewWithTag(102)! as! UILabel
////        
////        var profileDateTime = cell.viewWithTag(103)! as! UILabel
////        let dateTime = "On " + people[i].lastSeenDate
////        let fixedDTString = dateTime.replacingOccurrences(of: "T", with: " at ", options: .literal, range: nil)
////        profileDateTime.text = fixedDTString
////        
////        return cell
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
