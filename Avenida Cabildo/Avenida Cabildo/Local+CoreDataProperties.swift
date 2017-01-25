//
//  Local+CoreDataProperties.swift
//  
//
//  Created by Fernando N. Frassia on 1/18/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Local {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Local> {
        return NSFetchRequest<Local>(entityName: "Local");
    }

    @NSManaged public var categoria: String?
    @NSManaged public var descuentos: NSObject?
    @NSManaged public var detalleTexto: String?
    @NSManaged public var direccion: String?
    @NSManaged public var efectivo: String?
    @NSManaged public var facebook: String?
    @NSManaged public var horarios: String?
    @NSManaged public var imagenFondo: String?
    @NSManaged public var imagenLogo: String?
    @NSManaged public var instagram: String?
    @NSManaged public var mail: String?
    @NSManaged public var nombre: String?
    @NSManaged public var telefono: String?
    @NSManaged public var ubicacion: String?
    @NSManaged public var visibilidad: Int16
    @NSManaged public var web: String?
    @NSManaged public var horariosParaFiltro: NSObject?

}
