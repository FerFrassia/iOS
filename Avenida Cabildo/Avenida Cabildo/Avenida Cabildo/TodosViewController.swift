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
        
        
        loadLocales()
        loadFavoritos()
    }
    
    func loadLocales() {
        locales = FirebaseAPI.getCoreLocales()
        orderLocales()
    }
    
    func orderLocales() {
        var ordered = [Local]()
        for local in locales {
            if local.visibilidad == "avanzado" {
                ordered.append(local)
            }
        }
        
        for local in locales {
            if local.visibilidad == "intermedio" {
                ordered.append(local)
            }
        }
        
        for local in locales {
            if local.visibilidad == "basico" {
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
        if local.visibilidad == "basico" {
            return 100
        } else if local.visibilidad == "intermedio" {
            return 110
        } else {
            return 200
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let local = locales[indexPath.row]
        var cell = UITableViewCell()
        
        if local.visibilidad == "basico" {
            cell = configureBasic(tableView: tableView, indexPath: indexPath)
        } else if local.visibilidad == "intermedio" {
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
//        cell.localDiscount.text = local.efectivo
        
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

