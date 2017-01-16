//
//  Categoria+CoreDataProperties.swift
//  
//
//  Created by Fernando N. Frassia on 1/16/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Categoria {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Categoria> {
        return NSFetchRequest<Categoria>(entityName: "Categoria");
    }

    @NSManaged public var nombre: String?
    @NSManaged public var imagen: NSObject?
    @NSManaged public var locales: NSObject?

}
