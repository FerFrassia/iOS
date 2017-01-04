//
//  Local+CoreDataProperties.swift
//  
//
//  Created by Fernando N. Frassia on 1/3/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Local {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Local> {
        return NSFetchRequest<Local>(entityName: "Local");
    }

    @NSManaged public var address: String?
    @NSManaged public var backgroundImage: String?
    @NSManaged public var detailText: String?
    @NSManaged public var email: String?
    @NSManaged public var frontImage: String?
    @NSManaged public var name: String?
    @NSManaged public var openTime: String?
    @NSManaged public var phone: String?
    @NSManaged public var role: String?
    @NSManaged public var website: String?

}
