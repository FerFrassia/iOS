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

let localesStoredOrUpdatedKey = "localesStoredOrUpdatedKey"
let filtersUpdatedKey = "filtersUpdatedKey"
let promocionUpdatedKey = "promocionUpdatedKey"

class FirebaseAPI: NSObject {
    
    static func loadFirebaseCommonData() {
        storeFavoritesUserDefaults()
    }
    
    static func loadFirebaseUserData() {
        getLocales()
        storeEnPromocionUserDefaults()
        getCategories()
        getDescuentos()
    }
    
    //MARK: - Firebase En Promocion
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
    
    //MARK: - Firebase Locales
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
                              visibilidad: data["visibilidad"] as! Int16,
                              horariosParaFiltro: data["horarios para filtro"] as! [String:AnyObject],
                              enPromocion: data["en promocion"] as! Int16)
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: localesStoredOrUpdatedKey), object: nil)
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
                           visibilidad: Int16,
                           horariosParaFiltro: [String:AnyObject],
                           enPromocion: Int16) {
        

        let locales = getCoreLocales()
        if localesListHasLocal(name: nombre, locales: locales) {
            updateLocal(local: getLocalFromList(localName: nombre, list: locales), categoria: categoria, descuentos: descuentos, detalleTexto: detalleTexto, direccion: direccion, facebook: facebook, horarios: horarios, imagenFondo: imagenFondo, imagenLogo: imagenLogo, instagram: instagram, mail: mail, nombre: nombre, telefono: telefono, ubicacion: ubicacion, web: web, efectivo: efectivo, visibilidad: visibilidad, horariosParaFiltro: horariosParaFiltro, enPromocion: enPromocion)
        } else {
            saveLocal(categoria: categoria, descuentos: descuentos, detalleTexto: detalleTexto, direccion: direccion, facebook: facebook, horarios: horarios, imagenFondo: imagenFondo, imagenLogo: imagenLogo, instagram: instagram, mail: mail, nombre: nombre, telefono: telefono, ubicacion: ubicacion, web: web, efectivo: efectivo, visibilidad: visibilidad, horariosParaFiltro: horariosParaFiltro, enPromocion: enPromocion)
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
                            visibilidad: Int16,
                            horariosParaFiltro: [String:AnyObject],
                            enPromocion: Int16) {
        
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
        local.setValue(horariosParaFiltro, forKey: "horariosParaFiltro")
        local.setValue(enPromocion, forKey: "enPromocion")
        
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
                    visibilidad: Int16,
                    horariosParaFiltro: [String:AnyObject],
                    enPromocion: Int16) {
        
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
        local.setValue(horariosParaFiltro, forKey: "horariosParaFiltro")
        local.setValue(enPromocion, forKey: "enPromocion")
        
        do {
            try context.save()
        } catch {
            fatalError("failed to save context: \(error)")
        }
    }
    
    //MARK: - Core Data Locales
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
    
    //MARK: - User Core Data
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
    
    //MARK: - Favoritos
    static func addFavorite(name: String) {
        addFavoriteToUserDefaults(name: name)
        addFavoriteToUserFirebase(localName: name)
    }
    
    static func removeFavorite(name: String) {
        removeFavoriteFromUserDefaults(name: name)
        removeFavoriteFromUserFirebase(localName: name)
    }
    
    static func addFavoriteToUserFirebase(localName: String) {
        let user = FIRAuth.auth()?.currentUser
        let firebaseID = user?.uid
        FIRDatabase.database().reference().child("usuarios").observeSingleEvent(of: .value, with: { (snap) in
            if var usuariosDic = snap.value as? [String: [String]?] {
                if var favoritesForUser = usuariosDic[firebaseID!] {
                    favoritesForUser!.append(localName)
                    usuariosDic[firebaseID!] = favoritesForUser
                } else {
                    let favoritesArray = [localName]
                    usuariosDic[firebaseID!] = favoritesArray
                }
                FIRDatabase.database().reference().child("usuarios").setValue(usuariosDic)
                NotificationCenter.default.post(name: Notification.Name(rawValue: promocionUpdatedKey), object: nil)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    static func removeFavoriteFromUserFirebase(localName: String) {
        let user = FIRAuth.auth()?.currentUser
        let firebaseID = user?.uid
        FIRDatabase.database().reference().child("usuarios").child(firebaseID!).observeSingleEvent(of: .value, with: { (snap) in
            if var favoritesForUser = snap.value as? [String] {
                if let index = favoritesForUser.index(of: localName) {
                    favoritesForUser.remove(at: index)
                }
                FIRDatabase.database().reference().child("usuarios").child(firebaseID!).setValue(favoritesForUser)
                NotificationCenter.default.post(name: Notification.Name(rawValue: promocionUpdatedKey), object: nil)
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
    
    static func addFavoriteToUserDefaults(name: String) {
        if var fav = UserDefaults.standard.array(forKey: "favoritos") as? [String] {
            fav.append(name)
            UserDefaults.standard.set(fav, forKey: "favoritos")
        } else {
            UserDefaults.standard.set([name], forKey: "favoritos")
        }
    }
    
    static func removeFavoriteFromUserDefaults(name: String) {
        if var fav = UserDefaults.standard.array(forKey: "favoritos") as? [String] {
            if let index = fav.index(of: name) {
                fav.remove(at: index)
                UserDefaults.standard.set(fav, forKey: "favoritos")
            }
        }
    }
    
    static func getFavoritesUserDefaults() -> [String] {
        if let fav = UserDefaults.standard.array(forKey: "favoritos") as? [String] {
            return fav
        } else {
            return [String]()
        }
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
    
    static func getCoreFavorites() -> [Local] {
        let locales = self.getCoreLocales()
        let favoritos = self.getFavoritesUserDefaults()
        
        var localesFiltrados = [Local]()
        for local in locales {
            for favorito in favoritos {
                if local.nombre == favorito {
                    localesFiltrados.append(local)
                }
            }
        }
        return localesFiltrados
    }
    
    static func isLocalFavorited(nombre: String) -> Bool {
        let favoritos = self.getFavoritesUserDefaults()
        if favoritos.index(of: nombre) != nil {
            return true
        } else {
            return false
        }
    }
    
    //MARK: - Selected Local Defaults
    static func storeSelectedUserDefaults(name: String) {
        UserDefaults.standard.set(name, forKey: "selectedLocal")
    }
    
    static func getSelectedUserDefaults() -> String {
        if let local = UserDefaults.standard.string(forKey: "selectedLocal") {
            return local
        } else {
            return ""
        }
    }
    
    static func getSelectedUserDefaultsLocal() -> Local {
        let selectedName = getSelectedUserDefaults()
        let locales = getCoreLocales()
        for local in locales {
            if local.nombre == selectedName {
                return local
            }
        }
        return Local()
    }
    
    //MARK: - Categories
    static func getCategories() {
        FIRDatabase.database().reference().child("categorias").observeSingleEvent(of: .value, with: { (snap) in
            if let snapDict = snap.value as? Dictionary<String, AnyObject> {
                storeCategoriasCoreData(dic: snapDict)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    static func storeCategoriasCoreData(dic: Dictionary<String, AnyObject>) {
        for (categoryName, data) in dic {
            saveOrUpdateCategoria(nombre: categoryName,
                                  imagen: data["imagen"] as! Dictionary<String, String>,
                                  locales: data["locales"] as? [String])
        }
    }
    
    static func saveOrUpdateCategoria(nombre: String, imagen: Dictionary<String, String>, locales: [String]?) {
        if let categorias = getCoreCategorias() {
            if categoriasListHasCategoria(name: nombre, categorias: categorias) {
                updateCategoria(categoria: getCategoriaFromList(name: nombre, categorias: categorias),
                                nombre: nombre,
                                imagen: imagen,
                                locales: locales)
            } else {
                saveCategoria(nombre: nombre,
                              imagen: imagen,
                              locales: locales)
            }
        }
    }
    
    static func saveCategoria(nombre: String, imagen: Dictionary<String, String>, locales: [String]?) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let categoria = NSEntityDescription.insertNewObject(forEntityName: "Categoria", into: context) as! Categoria
        
        categoria.setValue(nombre, forKey: "nombre")
        categoria.setValue(imagen, forKey: "imagen")
        
        if let locals = locales {
            categoria.setValue(locals, forKey: "locales")
        } else {
            categoria.setValue([], forKey: "locales")
        }
        
        do {
            try context.save()
        } catch {
            fatalError("failed to save context: \(error)")
        }
    }
    
    static func updateCategoria(categoria: Categoria, nombre: String, imagen: Dictionary<String, String>, locales: [String]?) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        categoria.setValue(nombre, forKey: "nombre")
        categoria.setValue(imagen, forKey: "imagen")
        
        if let locals = locales {
            categoria.setValue(locals, forKey: "locales")
        } else {
            categoria.setValue([], forKey: "locales")
        }
        
        do {
            try context.save()
        } catch {
            fatalError("failed to save context: \(error)")
        }
        
    }
    
    static func getCoreCategorias() -> [Categoria]? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Categoria")
        do {
            let result = try context.fetch(request) as? [Categoria]
            return result
        } catch {
            fatalError("Can't fetch user: \(error)")
        }
    }
    
    static func categoriasListHasCategoria(name: String, categorias: [Categoria]) -> Bool {
        var found = false
        for categoria in categorias {
            if categoria.nombre == name {
                found = true
                break
            }
        }
        return found
    }
    
    static func getCategoriaFromList(name: String, categorias: [Categoria]) -> Categoria {
        var categoriaFound = Categoria()
        for categoria in categorias {
            if categoria.nombre == name {
                categoriaFound = categoria
                break
            }
        }
        return categoriaFound
    }
    
    static func setCategoriaSelected(name: String, locales: [String]?, image: [String:String]) {
        UserDefaults.standard.set(name, forKey: "categoriaNombre")
        UserDefaults.standard.set(image, forKey: "categoriaImage")
        if let loc = locales {
            UserDefaults.standard.set(loc, forKey: "categoriaLocales")
        }
    }
    
    static func getCategoriaSelectedNombre() -> String {
        if let categoria = UserDefaults.standard.string(forKey: "categoriaNombre") {
            return categoria
        } else {
            return "Todos"
        }
    }
    
    static func getCategoriaSelectedLocales() -> [String] {
        if let locales = UserDefaults.standard.array(forKey: "categoriaLocales") {
            return locales as! [String]
        } else {
            return [String]()
        }
    }
    
    static func getCategoriaSelectedImage() -> [String:String] {
        if let imageDic = UserDefaults.standard.dictionary(forKey: "categoriaImage") {
            return imageDic as! [String:String]
        } else {
            return ["1x": "https://firebasestorage.googleapis.com/v0/b/avenida-cabildo.appspot.com/o/Assets%20iPhone%2FHome.png?alt=media&token=6b74d89f-e73f-41b9-9cd2-f9d88455523c", "2x": "https://firebasestorage.googleapis.com/v0/b/avenida-cabildo.appspot.com/o/Assets%20iPhone%2Fhotel%402x.png.png?alt=media&token=ec7a32c7-b64c-4301-b0d5-eca24da0ba7a", "3x": "https://firebasestorage.googleapis.com/v0/b/avenida-cabildo.appspot.com/o/Assets%20iPhone%2Fhotel%403x.png.png?alt=media&token=777cd7b5-6427-4eca-9cd5-cfe10d4a5eac", "pdf": "https://firebasestorage.googleapis.com/v0/b/avenida-cabildo.appspot.com/o/Assets%20iPhone%2Ftiendas.pdf?alt=media&token=6d8b9876-4f1f-4ca5-bd89-11d961606cc5"]
        }
    }
    
    //MARK: - Descuentos
    static func getDescuentos() {
        FIRDatabase.database().reference().child("descuentos").observeSingleEvent(of: .value, with: { (snap) in
            if let snapDict = snap.value as? Dictionary<String, AnyObject> {
                storeDescuentosCoreData(dic: snapDict)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    static func storeDescuentosCoreData(dic: Dictionary<String, AnyObject>) {
        for (descuentoName, data) in dic {
            saveOrUpdateDescuento(nombre: descuentoName,
                                  imagen: data["imagen"] as! Dictionary<String, String>,
                                  locales: data["locales"] as? [String])
        }
    }
    
    static func saveOrUpdateDescuento(nombre: String, imagen: Dictionary<String, String>, locales: [String]?) {
        if let descuentos = getCoreDescuentos() {
            if descuentosListHasDescuento(name: nombre, descuentos: descuentos) {
                updateDescuento(descuento: getDescuentoFromList(name: nombre, descuentos: descuentos),
                                nombre: nombre,
                                imagen: imagen,
                                locales: locales)
            } else {
                saveDescuento(nombre: nombre,
                              imagen: imagen,
                              locales: locales)
            }
        }
    }
    
    static func updateDescuento(descuento: Descuento, nombre: String, imagen: Dictionary<String, String>, locales: [String]?) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        descuento.setValue(nombre, forKey: "nombre")
        descuento.setValue(imagen, forKey: "imagen")
        
        if let locals = locales {
            descuento.setValue(locals, forKey: "locales")
        } else {
            descuento.setValue([], forKey: "locales")
        }
        
        do {
            try context.save()
        } catch {
            fatalError("failed to save context: \(error)")
        }
        
    }
    
    static func saveDescuento(nombre: String, imagen: Dictionary<String, String>, locales: [String]?) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let descuento = NSEntityDescription.insertNewObject(forEntityName: "Descuento", into: context) as! Descuento
        
        descuento.setValue(nombre, forKey: "nombre")
        descuento.setValue(imagen, forKey: "imagen")
        
        if let locals = locales {
            descuento.setValue(locals, forKey: "locales")
        } else {
            descuento.setValue([], forKey: "locales")
        }
        
        do {
            try context.save()
        } catch {
            fatalError("failed to save context: \(error)")
        }
    }
    
    static func getCoreDescuentos() -> [Descuento]? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Descuento")
        do {
            let result = try context.fetch(request) as? [Descuento]
            return result
        } catch {
            fatalError("Can't fetch user: \(error)")
        }
    }
    
    static func descuentosListHasDescuento(name: String, descuentos: [Descuento]) -> Bool {
        var found = false
        for descuento in descuentos {
            if descuento.nombre == name {
                found = true
                break
            }
        }
        return found
    }
    
    static func getDescuentoFromList(name: String, descuentos: [Descuento]) -> Descuento {
        var descuentoFound = Descuento()
        for descuento in descuentos {
            if descuento.nombre == name {
                descuentoFound = descuento
                break
            }
        }
        return descuentoFound
    }
    
    //MARK: - Filters by categoria and descuento
    static func addFilterUniquelyToDefaults(filterName: String) {
        var stored = self.getFiltersFromDefaults()
        if !isFilterInFilters(filterName: filterName) {
            stored.append(filterName)
            UserDefaults.standard.set(stored, forKey: "filtrosTodos")
        }
    }
    
    static func removeFilterIfExistsFromDefaults(filterName: String) {
        var stored = self.getFiltersFromDefaults()
        for filter in stored {
            if filter == filterName {
                stored.remove(at: stored.index(of: filter)!)
                break
            }
        }
        UserDefaults.standard.set(stored, forKey: "filtrosTodos")
    }
    
    static func deleteFilters() {
        UserDefaults.standard.set([String](), forKey: "filtrosTodos")
        UserDefaults.standard.set("", forKey: "filterLocalName")
    }
    
    static func getFiltersFromDefaults() -> [String] {
        if let filtros = UserDefaults.standard.array(forKey: "filtrosTodos") as? [String] {
            return filtros
        } else {
            return [String]()
        }
    }
    
    static func isFilterInFilters(filterName: String) -> Bool {
        let stored = self.getFiltersFromDefaults()
        for filter in stored {
            if filter == filterName {
                return true
            }
        }
        return false
    }
    
    static func isFiltersInFilters(filtersToCheck: [String]) -> Bool {
        let stored = self.getFiltersFromDefaults()
        for filter in stored {
            for filterToCheck in filtersToCheck {
                if filter == filterToCheck {
                    return true
                }
            }
        }
        return false
    }
    
    static func isFiltersActive() -> Bool {
        let stored = self.getFiltersFromDefaults()
        let storedName = self.getFilterByNameDefaults()
        let abiertoAhora = self.isFilterAbiertoAhoraActive()
        return stored.count != 0 || storedName != "" || abiertoAhora
    }
    
    static func isFiltersByCategoryOrDescuentoActive() -> Bool {
        let stored = self.getFiltersFromDefaults()
        return stored.count != 0
    }
    
    static func isFilterByNameActive() -> Bool {
        let storedName = self.getFilterByNameDefaults()
        return storedName != ""
    }
    
    static func isFilterAbiertoAhoraActive() -> Bool {
        return UserDefaults.standard.bool(forKey: "filterAbiertoAhora")
    }
    
    //MARK: - Filter by name
    static func setFilterByNameDefaults(localName: String) {
        UserDefaults.standard.set(localName, forKey: "filterLocalName")
    }
    
    static func getFilterByNameDefaults() -> String {
        if let name = UserDefaults.standard.string(forKey: "filterLocalName") {
            return name
        } else {
            return ""
        }
    }
    
    static func isNameInFiltersByName(name: String) -> Bool {
        let saved = getFilterByNameDefaults()
        return name == saved
    }
    
    //MARK: - Filter by Abierto ahora
    static func setFilterByAbiertoAhora() {
        UserDefaults.standard.set(true, forKey: "filterAbiertoAhora")
    }
    
    static func unsetFilterByAbiertoAhora() {
        UserDefaults.standard.set(false, forKey: "filterAbiertoAhora")
    }
    
    static func isLocalOpenNow(local: Local) -> Bool {
        let dia = getDayOfWeek()
        let hora = getHour()
        
        if let horariosDic = local.horariosParaFiltro as? [String:AnyObject] {
            if let diaDic = horariosDic[dia] as? [String:Int64] {
                let abre = diaDic["abre"]!
                let cierra = diaDic["cierra"]!
                if abre < hora && hora < cierra {
                    return true
                } else {
                    return false
                }
            }
        }
        return true
    }
    
    //MARK: - Helpers
    static func getDayOfWeek() -> String {
        let date = Date()
        let calendar = Calendar.current
        let weekDay = calendar.component(.weekday, from: date)
        switch weekDay {
        case 1:
            return "domingo"
        case 2:
            return "lunes"
        case 3:
            return "martes"
        case 4:
            return "miercoles"
        case 5:
            return "jueves"
        case 6:
            return "viernes"
        case 7:
            return "sabado"
        default:
            return "lunes"
        }
    }
    
    static func getHour() -> Int64 {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        return Int64(hour)
    }
    
    
    
    
    
    
    
    
    
    
}
