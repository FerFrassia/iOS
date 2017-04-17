//
//  TodosViewController.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 1/4/17.
//  Copyright © 2017 Fernando N. Frassia. All rights reserved.
//


import Foundation
import XLPagerTabStrip

class TodosViewController: UITableViewController, IndicatorInfoProvider {
    
    var blackTheme = false
    var itemInfo = IndicatorInfo(title: "LALALA")
    var locales = [Local]()
    var favoritos = [String]()
    
    init(style: UITableViewStyle, itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "PostCell", bundle: Bundle.main), forCellReuseIdentifier: "postCell")
        tableView.register(UINib(nibName: "Local2", bundle: Bundle.main), forCellReuseIdentifier: "Local2")
        tableView.register(UINib(nibName: "Local3", bundle: Bundle.main), forCellReuseIdentifier: "Local3")
        
        tableView.allowsSelection = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(filtersChanged), name: NSNotification.Name(rawValue: "filtersUpdatedKey"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(localesChanged), name: NSNotification.Name(localesStoredOrUpdatedKey), object: nil)
        
        loadLocales()
        loadFavoritos()
    }
    
    func localesChanged() {
        loadLocales()
        tableView.reloadData()
    }
    
    func filtersChanged() {
        loadLocales()
        tableView.reloadData()
    }
    
    func loadLocales() {
        locales = FirebaseAPI.getCoreLocales()
        orderLocales()
        filterLocales()
        checkLocalesEmpty()
    }
    
    func filterLocales() {
        var filtered = [Local]()
        for local in locales {
            if FirebaseAPI.isFilterInFilters(filterName: local.categoria!) {
                filtered.append(local)
            }
        }
        locales = filtered
    }
    
    func checkLocalesEmpty() {
        if locales.count == 0 {
            let alertController = UIAlertController(title: "", message: "No se encontraron locales para estos filtros", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            {
                (result : UIAlertAction) -> Void in
                
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
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
    
    func loadFavoritos() {
        favoritos = FirebaseAPI.getFavoritesUserDefaults()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locales.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let local = locales[indexPath.row]
        if local.visibilidad == 3 {
            return 100
        } else if local.visibilidad == 2 {
            return 110
        } else {
            return 200
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let local = locales[indexPath.row]
        var cell = UITableViewCell()
        
        if local.visibilidad == 3 {
            cell = configureBasic(tableView: tableView, indexPath: indexPath)
        } else if local.visibilidad == 2 {
            cell = configureIntermediate(tableView: tableView, indexPath: indexPath)
        } else {
            cell = configureAdvanced(tableView: tableView, indexPath: indexPath)
        }
        
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
        } else {
            cell.localDescuento.isHidden = true
        }
        
        if isLocal(local: local.nombre!, locales: favoritos) {
            cell.localFavorite.isSelected = true
       }
        
        let shareWhite = UIImage(named: "Share")?.withRenderingMode(.alwaysTemplate)
        cell.localShare.setBackgroundImage(shareWhite, for: .normal)
        cell.localShare.tintColor = UIColor.white
        
        return cell
    }
    
    
    // MARK: - IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    func isLocal(local: String, locales: [String]) -> Bool {
        for currentLocal in locales {
            if currentLocal == local {
                return true
            }
        }
        return false
    }
}

