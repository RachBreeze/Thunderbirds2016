import Foundation
import UIKit

struct person {
    var userID: String
    var latitude: Double
    var longtitude: Double
    var lastSeenDate: String
    var profileURL: String
    var forename: String
    var surname: String
    var age: Int
    var isDangerous: Bool
    
    init(userID: String, latitude: Double, longtitude: Double, lastSeenDate: String,
         profileURL: String, forename: String, surname: String, age: Int, isDangerous: Bool) {
        self.userID = userID
        self.latitude = latitude
        self.longtitude = longtitude
        self.lastSeenDate = lastSeenDate
        self.profileURL = profileURL
        self.forename = forename
        self.surname = surname
        self.age = age
        self.isDangerous = isDangerous
    }
}

var people = [person]()

func readJSON(lat: Double?, long: Double?) {
    var url = NSURL()
    if let lat = lat, let long = long {
        url = NSURL(string: "http://192.168.226.201:54621/api/Profiles?latitude=" + String(lat) + "&longitude=" + String(long) + "&distanceKM=1")!
    } else {
        url = NSURL(string: "http://192.168.226.201:54621/api/Profiles?latitude=53.51766&longitude=-2.228723&distanceKM=1")!
    }
    let data = NSData(contentsOf: url as URL)
    
    let urlContent = NSString(data: data! as Data, encoding: String.Encoding.ascii.rawValue) as NSString!
    print(urlContent)
    
    let jsonObject = try? JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments)
    
    if let users = jsonObject as? [[String: Any]] {
        people = [person]()
        for user in users {
            let rawLatitude = user["Latitude"] as! Double
            let rawLongtitude = user["Longitude"] as! Double
            
            let userID = user["UserID"] as! String
            let latitude = Double(round(1000000 * rawLatitude) / 1000000)
            let longtitude = Double(round(1000000 * rawLongtitude) / 1000000)
            let lastSeenDate = user["LastSeen"] as! String
            let profileURL = user["ProfileURL"] as! String
            let forename = user["Forename"] as! String
            let surname = user["Surname"] as! String
            let age = user["Age"] as! Int
            let isDangerous = user["IsDangerous"] as! Bool
            
            let newPerson = person(userID: userID, latitude: latitude, longtitude: longtitude, lastSeenDate: lastSeenDate, profileURL: profileURL, forename: forename, surname: surname, age: age, isDangerous: isDangerous)
            
            people.append(newPerson)
        }
    }
    
    for i in 1 ..< people.count {
        print("Q: \(people[i])")
    }
}

class InstagramViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
