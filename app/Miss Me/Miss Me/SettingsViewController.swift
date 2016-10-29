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

var people : [person] = []

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readJSON()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func readJSON() {
//        let url = NSURL(string: "http://192.168.226.201:54621/api/Profiles/")!
//        let data = NSData(contentsOf: url as URL)
        
        let jsonString = "[{\"UserID\":\"383A353A3936393A3139\",\"Latitude\":53.43675,\"Longitude\":-2.277126,\"LastSeen\":\"2016-06-18T14:30:00\",\"ProfileURL\":\"tbd\",\"Forename\":\"PeachPuff1027237\",\"Surname\":\"DeepPink\",\"Age\":51,\"IsDangerous\":false},{\"UserID\":\"383A353A39363A3A3139\",\"Latitude\":53.42865,\"Longitude\":-2.175895,\"LastSeen\":\"2013-12-07T12:39:00\",\"ProfileURL\":\"tbd\",\"Forename\":\"Magenta1025217\",\"Surname\":\"DarkSalmon\",\"Age\":12,\"IsDangerous\":false},{\"UserID\":\"383A353A3A36383A3239\",\"Latitude\":53.53257,\"Longitude\":-2.406005,\"LastSeen\":\"2013-09-04T14:00:00\",\"ProfileURL\":\"tbd\",\"Forename\":\"BlanchedAlmond1012596\",\"Surname\":\"Tan\",\"Age\":30,\"IsDangerous\":false},{\"UserID\":\"383A353A3A36393A3239\",\"Latitude\":53.5938,\"Longitude\":-2.386993,\"LastSeen\":\"2013-10-22T13:41:00\",\"ProfileURL\":\"tbd\",\"Forename\":\"PaleGreen1027786\",\"Surname\":\"RosyBrown\",\"Age\":16,\"IsDangerous\":false},{\"UserID\":\"383A353A3A363A3A3239\",\"Latitude\":53.54896,\"Longitude\":-2.13031,\"LastSeen\":\"2013-12-11T20:00:00\",\"ProfileURL\":\"tbd\",\"Forename\":\"Teal1005434\",\"Surname\":\"GhostWhite\",\"Age\":0,\"IsDangerous\":false},{\"UserID\":\"383A353A3B36383A3339\",\"Latitude\":53.49519,\"Longitude\":-2.273497,\"LastSeen\":\"2013-09-11T03:36:00\",\"ProfileURL\":\"tbd\",\"Forename\":\"Red1055906\",\"Surname\":\"MediumSlateBlue\",\"Age\":23,\"IsDangerous\":false},{\"UserID\":\"383A353A3C36393A3439\",\"Latitude\":53.44915,\"Longitude\":-2.114283,\"LastSeen\":\"2013-10-31T00:00:00\",\"ProfileURL\":\"tbd\",\"Forename\":\"MediumAquamarine1020588\",\"Surname\":\"PaleGreen\",\"Age\":44,\"IsDangerous\":false},{\"UserID\":\"383A353A3C363A3A3439\",\"Latitude\":53.53364,\"Longitude\":-2.558174,\"LastSeen\":\"2014-01-18T16:45:00\",\"ProfileURL\":\"tbd\",\"Forename\":\"DarkSeaGreen1043781\",\"Surname\":\"Brown\",\"Age\":18,\"IsDangerous\":false},{\"UserID\":\"383A353A3D36393A3539\",\"Latitude\":53.39443,\"Longitude\":-2.286236,\"LastSeen\":\"2013-11-07T17:48:00\",\"ProfileURL\":\"tbd\",\"Forename\":\"LightSlateGray1014295\",\"Surname\":\"Yellow\",\"Age\":18,\"IsDangerous\":false},{\"UserID\":\"383A353A3E36383A3639\",\"Latitude\":53.54176,\"Longitude\":-2.517215,\"LastSeen\":\"2013-09-25T20:00:00\",\"ProfileURL\":\"tbd\",\"Forename\":\"OldLace1012639\",\"Surname\":\"OliveDrab\",\"Age\":40,\"IsDangerous\":false},{\"UserID\":\"383A353A3E36393A3639\",\"Latitude\":53.55485,\"Longitude\":-2.425194,\"LastSeen\":\"2013-11-12T21:30:00\",\"ProfileURL\":\"tbd\",\"Forename\":\"DarkViolet1013082\",\"Surname\":\"MediumPurple\",\"Age\":52,\"IsDangerous\":false}]"
        
        let data = jsonString.data(using: .utf8, allowLossyConversion: false)
        
        let urlContent = NSString(data: data!, encoding: String.Encoding.ascii.rawValue) as NSString!
        print(urlContent)
        
        let jsonObject = try? JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments)
        
        if let users = jsonObject as? [[String: Any]] {
            for user in users {
                let userID = user["UserID"] as! String
                let latitude = user["Latitude"] as! Double
                let longtitude = user["Longitude"] as! Double
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
//        for i in (1 ..< people.count) {
//            print(people[i])
//        }
    }
}
