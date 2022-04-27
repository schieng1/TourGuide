//
//  MasterViewController.swift
//  TourGuide
//
//  Created by Stacy Chieng  on 11/14/21.
//

import Foundation
import UIKit

class MasterViewController: UITableViewController {
    var TGObjectArray = [TourGuide]()
    
    
    
    func convertToImage(imgURL:String) ->UIImage {
        let imgURL2 = URL(string:imgURL)!
        
        let imgData = try? Data(contentsOf: imgURL2)
        
        print(imgData ?? "Error. Image does not exist at URL \(imgURL)")
        let img = UIImage(data:imgData!)
        return img!
    }
    
    func populateHTFromJSON() {
        // get the End point
        let endPoint = "https://raw.githubusercontent.com/schieng1/JSONProject/main/TourGuide.json"
 
        let jSONURL = URL(string: endPoint)!

        let responseData = try? Data(contentsOf: jSONURL)
        print(responseData ?? "Error. No data to print. responseData is nil")
        print(responseData)
        if(responseData != nil) {
            let dictionary:NSDictionary = (try! JSONSerialization.jsonObject(with: responseData!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            print(dictionary)
            let tgDictionary = dictionary["TourGuide"]! as! [[String:AnyObject]]
            for index in 0...tgDictionary.count - 1 {
                let singleTG = tgDictionary[index]
                let tg = TourGuide()
                tg.ActivityName = singleTG["ActivityName"]! as! String
                tg.ActivityDescription = singleTG["ActivityDescription"]! as! String
                tg.ActivityAddress = singleTG["ActivityAddress"]! as! String
                tg.ActivityPhoneNum = singleTG["ActivityPhoneNum"]! as! String
                tg.ActivityPrice = singleTG["ActivityPrice"]! as! String
                tg.ActivitySite = singleTG["ActivitySite"]! as! String
                tg.ActivityImage = singleTG["ActivityImage"]! as! String
                TGObjectArray.append(tg)
            }
        }
        
    
        
        
    }
    /*
    func populateTourGuideInfo() {
        let tg1 = TourGuide()
        tg1.ActivityName = "Hollywood Walk of Fame"
        tg1.ActivityDescription = "The Hollywood Walk of Fame comprises more than 2,690 five-pointed terrazzo and brass stars embedded in the sidewalks along 15 blocks of Hollywood Boulevard and three blocks of Vine Street in Hollywood, California."
        tg1.ActivityAddress = "Hollywood Boulevard, Vine St, Los Angeles, CA 90028"
        tg1.ActivityPrice = "Free"
        tg1.ActivitySite = "https://walkoffame.com/"
        tg1.ActivityPhoneNum = "Not Available"
        tg1.ActivityImage = "WalkOfFameHW.jpeg"
        tg1.BackgroundImage = "HWWalkOfFame.jpeg"
        TGObjectArray.insert(tg1,at:0)
        
        let tg2 = TourGuide()
        tg2.ActivityName = "LA County Museum of Art"
        tg2.ActivityDescription = "Museum Associates, doing business as Los Angeles County Museum of Art, is a visual arts museum that offers a collection of Japanese arts, modern and contemporary arts, paintings, photography, textiles, as well as Islamic arts."
        tg2.ActivityAddress = "5905 Wilshire Blvd, Los Angeles, CA 90036"
        tg2.ActivityPrice = "Free"
        tg2.ActivitySite = "https://www.lacma.org/"
        tg2.ActivityPhoneNum = "+1323-857-6000"
        tg2.ActivityImage = "MuseumArt.jpeg"
        tg2.BackgroundImage = "MuseumArt.jpeg"
        TGObjectArray.append(tg2)
        
        let tg3 = TourGuide()
        tg3.ActivityName = "Griffith Observatory"
        tg3.ActivityDescription = "Griffith Observatory is a facility in Los Angeles, California, sitting on the south-facing slope of Mount Hollywood in Los Angeles' Griffith Park. It commands a view of the Los Angeles Basin to the southeast, Hollywood to the south, and the Pacific Ocean to the southwest."
        tg3.ActivityAddress = "4730 Crystal Springs Dr, Los Angeles, CA 90027"
        tg3.ActivityPrice = "$25"
        tg3.ActivitySite = "https://www.laparks.org/"
        tg3.ActivityPhoneNum = "+1323-913-4688"
        tg3.ActivityImage = "Griff.jpeg"
        tg3.BackgroundImage = ""
        TGObjectArray.append(tg3)
    }
 */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateHTFromJSON()
    //    populateTourGuideInfo()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showDetails") {
            let destController = segue.destination as! ViewController
            let indexPath = tableView.indexPathForSelectedRow
            let TGObject = TGObjectArray[indexPath!.row]
            destController.passedTourGuide = TGObject
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TGObjectArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let TGObject = TGObjectArray[indexPath.row]
   
        let ActivityName = TGObject.ActivityName
        let ActivityPrice = TGObject.ActivityPrice
        let ActivityImage = TGObject.ActivityImage
        
    
   
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellName", for: indexPath)
    
        cell.textLabel!.text = ActivityName
        cell.detailTextLabel!.text = ActivityPrice
    
        let img = convertToImage(imgURL: ActivityImage)
    
        cell.imageView?.image = img
        
        return cell
    }
}
