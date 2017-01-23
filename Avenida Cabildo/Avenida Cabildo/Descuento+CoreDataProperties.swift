//
//  Descuento+CoreDataProperties.swift
//  
//
//  Created by Fernando N. Frassia on 1/23/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

extension Descuento {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Descuento> {
        return NSFetchRequest<Descuento>(entityName: "Descuento");
    }

    @NSManaged public var nombre: String?
    @NSManaged public var locales: NSObject?
    @NSManaged public var imagen: NSObject?

}
