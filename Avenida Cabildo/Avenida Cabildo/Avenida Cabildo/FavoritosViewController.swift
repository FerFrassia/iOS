//
//  FavoritosViewController.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 1/26/17.
//  Copyright © 2017 Fernando N. Frassia. All rights reserved.
//

import UIKit

class FavoritosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var todosTableView: UITableView!
    
    var locales = [Local]()
    var favoritos = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBarBackButton()
        todosTableView.register(UINib(nibName: "PostCell", bundle: Bundle.main), forCellReuseIdentifier: "postCell")
        todosTableView.register(UINib(nibName: "Local2", bundle: Bundle.main), forCellReuseIdentifier: "Local2")
        todosTableView.register(UINib(nibName: "Local3", bundle: Bundle.main), forCellReuseIdentifier: "Local3")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadLocales()
        loadFavoritos()
    }
    
    func loadFavoritos() {
        favoritos = FirebaseAPI.getFavoritesUserDefaults()
    }
    
    func loadLocales() {
        locales = FirebaseAPI.getCoreFavorites()
        orderLocales()
        todosTableView.reloadData()
    }
    
    func orderLocales() {
        var ordered = [Local]()
        for local in locales {
            if local.visibilidad == 1 {
                ordered.append(local)
            }
        }
        
        for local in locales {
            if local.visibilidad == 2 {
                ordered.append(local)
            }
        }
        
        for local in locales {
            if local.visibilidad == 3 {
                ordered.append(local)
            }
        }
        
        locales = ordered
    }
    
    func setNavBarBackButton() {
        backButton.setImage(UIImage(named: "Arrow Menu")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.tintColor = .black
    }

    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locales.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let local = locales[indexPath.row]
        if local.visibilidad == 3 {
            return 100
        } else if local.visibilidad == 2 {
            return 110
        } else {
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let local = locales[indexPath.row]
        var cell = UITableViewCell()
        
        if local.visibilidad == 3 {
            cell = configureBasic(tableView: tableView, indexPath: indexPath)
        } else if local.visibilidad == 2 {
            cell = configureIntermediate(tableView: tableView, indexPath: indexPath)
        } else {
            cell = configureAdvanced(tableView: tableView, indexPath: indexPath)
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func configureBasic(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCell
        let local = locales[indexPath.row]
        
        cell.localName.text = local.nombre
        cell.localAddress.text = local.direccion
        cell.localDiscount.text = local.efectivo
        
        let url = URL(string: local.imagenLogo!)
        cell.localImage.sd_setImage(with: url, placeholderImage: UIImage(named: "Image Not Available"))
        
        
        if isLocal(local: local.nombre!, locales: favoritos) {
            cell.localFavorite.isSelected = true
        }
        
        return cell
    }
    
    func configureIntermediate(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Local2", for: indexPath) as! Local2
        let local = locales[indexPath.row]
        
        cell.localName.text = local.nombre
        cell.localAddress.text = local.direccion
        cell.localDiscount.text = local.efectivo
        
        let urlLogo = URL(string: local.imagenLogo!)
        cell.localImage.sd_setImage(with: urlLogo, placeholderImage: UIImage(named: "Image Not Available"))
        
        let urlFondo = URL(string: local.imagenFondo!)
        cell.localBackgroundImage.sd_setImage(with: urlFondo, placeholderImage: UIImage(named: "Image Not Available"))
        
        if isLocal(local: local.nombre!, locales: favoritos) {
            cell.localFavorite.isSelected = true
        }
        
        let shareWhite = UIImage(named: "Share")?.withRenderingMode(.alwaysTemplate)
        cell.localShare.setBackgroundImage(shareWhite, for: .normal)
        cell.localShare.tintColor = UIColor.white
        
        return cell
    }
    
    func configureAdvanced(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Local3", for: indexPath) as! Local3
        let local = locales[indexPath.row]
        
        cell.localName.text = local.nombre
        cell.localAddress.text = local.direccion
        
        let urlLogo = URL(string: local.imagenLogo!)
        cell.localImage.sd_setImage(with: urlLogo, placeholderImage: UIImage(named: "Image Not Available"))
        
        let urlFondo = URL(string: local.imagenFondo!)
        cell.localBackgroundImage.sd_setImage(with: urlFondo, placeholderImage: UIImage(named: "Image Not Available"))
        
        if let efectivo = local.efectivo {
            var imageName = ""
            switch efectivo {
            case "10%":
                imageName = "10Descuento"
            case "20%":
                imageName = "20Descuento"
            case "30%":
                imageName = "30Descuento"
            case "40%":
                imageName = "40Descuento"
            case "50%":
                imageName = "50Descuento"
            default:
                imageName = "10Descuento"
            }
            cell.localDescuento.image = UIImage(named: imageName)
        }
        
        if isLocal(local: local.nombre!, locales: favoritos) {
            cell.localFavorite.isSelected = true
        }
        
        let shareWhite = UIImage(named: "Share")?.withRenderingMode(.alwaysTemplate)
        cell.localShare.setBackgroundImage(shareWhite, for: .normal)
        cell.localShare.tintColor = UIColor.white
        
        return cell
    }
    
    //MARK: -UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let local = locales[indexPath.row]
        FirebaseAPI.storeSelectedUserDefaults(name: local.nombre!)
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "LocalSelectedViewController") as! LocalSelectedViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK: - Helpers
    func isLocal(local: String, locales: [String]) -> Bool {
        for currentLocal in locales {
            if currentLocal == local {
                return true
            }
        }
        return false
    }
    
    enum UIUserInterfaceIdiom : Int
    {
        case Unspecified
        case Phone
        case Pad
    }
    
    struct ScreenSize
    {
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    struct DeviceType
    {
        static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    }
}
