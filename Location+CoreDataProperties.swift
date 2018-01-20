//
//  Location+CoreDataProperties.swift
//  Rustar
//
//  Created by George Nebieridze on 1/17/18.
//  Copyright © 2018 Rustar. All rights reserved.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var city: String?
    @NSManaged public var image: NSData?
    @NSManaged public var oldPrice: NSDecimalNumber?
    @NSManaged public var price: NSDecimalNumber?
    @NSManaged public var rank: NSDecimalNumber?

}
