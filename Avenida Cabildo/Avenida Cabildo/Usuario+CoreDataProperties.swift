//
//  Usuario+CoreDataProperties.swift
//  
//
//  Created by Fernando N. Frassia on 1/7/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Usuario {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Usuario> {
        return NSFetchRequest<Usuario>(entityName: "Usuario");
    }

    @NSManaged public var email: String?
    @NSManaged public var firebaseID: String?
    @NSManaged public var name: String?
    @NSManaged public var favoritos: String?

}
