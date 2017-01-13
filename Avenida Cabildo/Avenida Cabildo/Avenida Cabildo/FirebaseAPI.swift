//
//  FirebaseAPI.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 1/7/17.
//  Copyright © 2017 Fernando N. Frassia. All rights reserved.
//

import UIKit
import FirebaseDatabase
import CoreData
import Firebase

class FirebaseAPI: NSObject {
    
    static func loadFirebaseCommonData() {
        storeFavoritesUserDefaults()
    }
    
    static func loadFirebaseUserData() {
        getLocales()
        storeEnPromocionUserDefaults()
    }
    
    //MARK: Firebase En Promocion
    static func storeEnPromocionUserDefaults() {
        FIRDatabase.database().reference().child("promociones").observeSingleEvent(of: .value, with: { (snap) in
            if snap.exists() {
                let enPromocion = snap.value as! [String]
                
                UserDefaults.standard.set(enPromocion, forKey: "enPromocion")
            } else {
                UserDefaults.standard.set([], forKey: "enPromocion")
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    static func getEnPromocionUserDefaults() -> [String] {
        if let fav = UserDefaults.standard.array(forKey: "enPromocion") as? [String] {
            return fav
        } else {
            return [String]()
        }
    }
    
    //MARK: Firebase Locales
    static func getLocales() {
        FIRDatabase.database().reference().child("locales").observeSingleEvent(of: .value, with: { (snap) in
            if let snapDict = snap.value as? Dictionary<String, AnyObject> {
                loadLocales(dic: snapDict)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    static func loadLocales(dic: Dictionary<String, AnyObject>) {
        for (localName, data) in dic {
            saveOrUpdateLocal(categoria: data["categoria"] as! String,
                              descuentos: data["descuentos"] as? [String],
                              detalleTexto: data["detalle texto"] as! String,
                              direccion: data["direccion"] as! String,
                              facebook: data["facebook"] as! String,
                              horarios: data["horarios"] as! String,
                              imagenFondo: data["imagen fondo"] as! String,
                              imagenLogo: data["imagen logo"] as! String,
                              instagram: data["instagram"] as! String,
                              mail: data["mail"] as! String,
                              nombre: localName,
                              telefono: data["telefono"] as! String,
                              ubicacion: data["ubicacion"] as! String,
                              web: data["web"] as! String,
                              efectivo: data["efectivo"] as! String,
                              visibilidad: data["visibilidad"] as! String)
        }
    }
    
    
    static func saveOrUpdateLocal(categoria: String,
                           descuentos: [String]?,
                           detalleTexto: String,
                           direccion: String,
                           facebook: String,
                           horarios: String,
                           imagenFondo: String,
                           imagenLogo: String,
                           instagram: String,
                           mail: String,
                           nombre: String,
                           telefono: String,
                           ubicacion: String,
                           web: String,
                           efectivo: String,
                           visibilidad: String) {
        

        let locales = getCoreLocales()
        if localesListHasLocal(name: nombre, locales: locales) {
            updateLocal(local: getLocalFromList(localName: nombre, list: locales), categoria: categoria, descuentos: descuentos, detalleTexto: detalleTexto, direccion: direccion, facebook: facebook, horarios: horarios, imagenFondo: imagenFondo, imagenLogo: imagenLogo, instagram: instagram, mail: mail, nombre: nombre, telefono: telefono, ubicacion: ubicacion, web: web, efectivo: efectivo, visibilidad: visibilidad)
        } else {
            saveLocal(categoria: categoria, descuentos: descuentos, detalleTexto: detalleTexto, direccion: direccion, facebook: facebook, horarios: horarios, imagenFondo: imagenFondo, imagenLogo: imagenLogo, instagram: instagram, mail: mail, nombre: nombre, telefono: telefono, ubicacion: ubicacion, web: web, efectivo: efectivo, visibilidad: visibilidad)
        }

    }
    
    static func localesListHasLocal(name: String, locales: [Local]) -> Bool {
        var found = false
        for local in locales {
            if local.nombre == name {
                found = true
                break
            }
        }
        return found
    }
    
    static func getLocalFromList(localName: String, list: [Local]) -> Local {
        var localFound = Local()
        for local in list {
            if local.nombre == localName {
                localFound = local
                break
            }
        }
        return localFound
    }
    
    static func updateLocal(local: Local,
                            categoria: String,
                            descuentos: [String]?,
                            detalleTexto: String,
                            direccion: String,
                            facebook: String,
                            horarios: String,
                            imagenFondo: String,
                            imagenLogo: String,
                            instagram: String,
                            mail: String,
                            nombre: String,
                            telefono: String,
                            ubicacion: String,
                            web: String,
                            efectivo: String,
                            visibilidad: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        local.setValue(categoria, forKey: "categoria")
        
        if let desc = descuentos {
            local.setValue(desc, forKey: "descuentos")
        } else {
            local.setValue([], forKey: "descuentos")
        }
        
        local.setValue(detalleTexto, forKey: "detalleTexto")
        local.setValue(direccion, forKey: "direccion")
        local.setValue(facebook, forKey: "facebook")
        local.setValue(horarios, forKey: "horarios")
        local.setValue(imagenFondo, forKey: "imagenFondo")
        local.setValue(imagenLogo, forKey: "imagenLogo")
        local.setValue(instagram, forKey: "instagram")
        local.setValue(mail, forKey: "mail")
        local.setValue(nombre, forKey: "nombre")
        local.setValue(telefono, forKey: "telefono")
        local.setValue(ubicacion, forKey: "ubicacion")
        local.setValue(web, forKey: "web")
        local.setValue(efectivo, forKey: "efectivo")
        local.setValue(visibilidad, forKey: "visibilidad")
        
        do {
            try context.save()
        } catch {
            fatalError("failed to save context: \(error)")
        }
        
    }
    
    static func saveLocal (categoria: String,
                    descuentos: [String]?,
                    detalleTexto: String,
                    direccion: String,
                    facebook: String,
                    horarios: String,
                    imagenFondo: String,
                    imagenLogo: String,
                    instagram: String,
                    mail: String,
                    nombre: String,
                    telefono: String,
                    ubicacion: String,
                    web: String,
                    efectivo: String,
                    visibilidad: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let local = NSEntityDescription.insertNewObject(forEntityName: "Local", into: context) as! Local
        
        local.setValue(categoria, forKey: "categoria")
        
        if let desc = descuentos {
            local.setValue(desc, forKey: "descuentos")
        } else {
            local.setValue([], forKey: "descuentos")
        }
        
        local.setValue(detalleTexto, forKey: "detalleTexto")
        local.setValue(direccion, forKey: "direccion")
        local.setValue(facebook, forKey: "facebook")
        local.setValue(horarios, forKey: "horarios")
        local.setValue(imagenFondo, forKey: "imagenFondo")
        local.setValue(imagenLogo, forKey: "imagenLogo")
        local.setValue(instagram, forKey: "instagram")
        local.setValue(mail, forKey: "mail")
        local.setValue(nombre, forKey: "nombre")
        local.setValue(telefono, forKey: "telefono")
        local.setValue(ubicacion, forKey: "ubicacion")
        local.setValue(web, forKey: "web")
        local.setValue(efectivo, forKey: "efectivo")
        local.setValue(visibilidad, forKey: "visibilidad")
        
        do {
            try context.save()
        } catch {
            fatalError("failed to save context: \(error)")
        }
    }
    
    //MARK: Core Data Locales
    static func getCoreLocales() -> [Local] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Local")
        do {
            let result = try context.fetch(request) as! [Local]
            return result
        } catch {
            fatalError("Can't fetch user: \(error)")
        }
    }
    
    static func favorite(local: Local) {
        
    }
    
    static func unfavorite(local: Local) {
        
    }
    
    static func getFavorites() {
        
        FIRDatabase.database().reference().child("usuarios").child("").observeSingleEvent(of: .value, with: { (snap) in
            if let snapDict = snap.value as? Dictionary<String, AnyObject> {
                loadLocales(dic: snapDict)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    //MARK: User Core Data
    static func storeCoreUser() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let usuario = NSEntityDescription.insertNewObject(forEntityName: "Usuario", into: context) as! Usuario
        
        let user = FIRAuth.auth()?.currentUser
        usuario.setValue(user?.email, forKey: "email")
        usuario.setValue(user?.uid, forKey: "firebaseID")
        usuario.setValue(user?.displayName, forKey: "name")

        do {
            try context.save()
        } catch {
            fatalError("failed to save context: \(error)")
        }
    }
    
    static func updateCoreUser() {
        
    }
    
    static func getCoreUser() -> Usuario {
        return Usuario()
    }
    
    static func getCoreLocal(name: String) -> Local {
        let locales = getCoreLocales()
        return getLocalFromList(localName: name, list: locales)
    }
    
    //MARK: User Firebase
    static func addFavoriteToUserFirebase(localName: String) {
        let user = FIRAuth.auth()?.currentUser
        let firebaseID = user?.uid
        FIRDatabase.database().reference().child("usuarios").observeSingleEvent(of: .value, with: { (snap) in
            if snap.hasChild(firebaseID!) {
                //add favorite local to existing array
                let userFavSnap = snap.childSnapshot(forPath: firebaseID!)
                var userFavArray = userFavSnap.value as! [String]
                userFavArray.append(localName)
                FIRDatabase.database().reference().child("usuarios").child(firebaseID!).setValue(userFavArray)
            } else {
                //create user and add an array with the local
                let favoritesArray = ["0": localName]
                FIRDatabase.database().reference().child("usuarios").setValue([firebaseID!: favoritesArray])
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    static func removeFavoriteFromUserFirebase(localName: String) {
        let user = FIRAuth.auth()?.currentUser
        let firebaseID = user?.uid
        FIRDatabase.database().reference().child("usuarios").child(firebaseID!).observeSingleEvent(of: .value, with: { (snap) in
            if var userFavArray = snap.value as? [String] {
                if let localIndex = userFavArray.index(of: localName) {
                    userFavArray.remove(at: localIndex)
                }
                FIRDatabase.database().reference().child("usuarios").child(firebaseID!).setValue(userFavArray)
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    static func storeFavoritesUserDefaults() {
        let user = FIRAuth.auth()?.currentUser
        guard let firebaseID = user?.uid else {return}
        FIRDatabase.database().reference().child("usuarios").observeSingleEvent(of: .value, with: { (snap) in
            if snap.hasChild(firebaseID) {
                let userFavSnap = snap.childSnapshot(forPath: firebaseID)
                let userFavArray = userFavSnap.value as! [String]
                
                UserDefaults.standard.set(userFavArray, forKey: "favoritos")
            } else {
                UserDefaults.standard.set([], forKey: "favoritos")
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    static func getFavoritesUserDefaults() -> [String] {
        if let fav = UserDefaults.standard.array(forKey: "favoritos") as? [String] {
            return fav
        } else {
            return [String]()
        }
    }
    
    //MARK: Selected Local Defaults
    static func storeSelectedUserDefaults(name: String) {
        UserDefaults.standard.set(name, forKey: "favoritos")
    }
    
    static func getSelectedUserDefaults() -> String {
        return UserDefaults.standard.string(forKey: "favoritos")!
    }
    
    
    
    

    
  
}
