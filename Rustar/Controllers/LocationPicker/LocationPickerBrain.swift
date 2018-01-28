//
//  Brain.swift
//  Rustar
//
//  Created by George Nebieridze on 1/27/18.
//  Copyright © 2018 Rustar. All rights reserved.
//

import UIKit
import CoreData

class LocationPickerBrain {
    
    var downloaded: Bool
    
    var locations = [Location]()
    var downloadedLocations = [Location]()
    
    let callBack: ([Location]) -> ()
    
    init(callBack: @escaping ([Location]) -> ()) {
        downloaded = false
        self.callBack = callBack
    }
    
    func fetchData() {
        do {
            
            let fetchFromData: NSFetchRequest<Location> = Location.fetchRequest()
            locations = try AppDelegate.persistentContainer.viewContext.fetch(fetchFromData)
            
        } catch let error {
            print(error)
        }
        
        if locations.count > 0 {
            self.callBack(self.locations)
        } else {
            print("Empty")
        }
    }
    
    func downloadData() {
        
        let jsonUrlLink = "https://script.googleusercontent.com/macros/echo?user_content_key=wM3n5XpINfTWF0qjQLN__bPTANVymebQ6Wphc36h-67bTlzht7qkbcSQqr1nRTnZEssvlsOk8KXmrlxd760YStC--FPCY_M9OJmA1Yb3SEsKFZqtv3DaNYcMrmhZHmUMWojr9NvTBuBLhyHCd5hHa1ZsYSbt7G4nMhEEDL32U4DxjO7V7yvmJPXJTBuCiTGh3rUPjpYM_V0PJJG7TIaKpyr_lAc9V4NXdV3kMcIDX22Jnodg7Qef_ld4DFc4yMLCJlAEelXzvDauUxDB_P7jPMKiW3k6MDkf31SIMZH6H4k&lib=MbpKbbfePtAVndrs259dhPT7ROjQYJ8yx"
        
        guard let url = URL(string: jsonUrlLink) else { return }
        
        URLSession.shared.dataTask(with: url) {
            (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                let json = try JSONDecoder().decode(FirstPageJSONDataFrame.self, from: data)
                let countryList = json.Sheet1
                
                // Create a New Data
                for i in countryList {
                    let location = Location(context: AppDelegate.persistentContainer.viewContext)
                    
                    location.city = i.city
                    location.image = NSData(contentsOf: NSURL(string: i.url)! as URL)
                    location.oldPrice = NSDecimalNumber(decimal: i.old_price)
                    location.price = NSDecimalNumber(decimal: i.price)
                    location.rank = NSDecimalNumber(decimal: i.rank)
                    
                    self.downloadedLocations.append(location)
                }
                
                self.downloaded = true
                
                DispatchQueue.main.async {
                    // Delete the old Data
                    for oldLocation in self.locations {
                        AppDelegate.persistentContainer.viewContext.delete(oldLocation)
                    }
                    
                    self.callBack(self.downloadedLocations)
                    
                    AppDelegate.saveContext()
                }
                
            } catch let jsonErr {
                print(jsonErr)
            }
        }.resume()
    }
}
