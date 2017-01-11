//
//  PromocionesViewController.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 1/4/17.
//  Copyright © 2017 Fernando N. Frassia. All rights reserved.
//

import Foundation
import XLPagerTabStrip

class PromocionesViewController: UITableViewController, IndicatorInfoProvider {
    
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
        
        tableView.register(UINib(nibName: "PromocionCell", bundle: Bundle.main), forCellReuseIdentifier: "PromocionCell")
        tableView.allowsSelection = false
        
        
//        loadLocales()
//        loadFavoritos()
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PromocionCell", for: indexPath) as! PromocionCell
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
