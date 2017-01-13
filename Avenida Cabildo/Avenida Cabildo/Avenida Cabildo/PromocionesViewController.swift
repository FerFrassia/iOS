//
//  PromocionesViewController.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 1/4/17.
//  Copyright © 2017 Fernando N. Frassia. All rights reserved.
//

import Foundation
import XLPagerTabStrip
import GoogleMaps

class PromocionesViewController: UITableViewController, IndicatorInfoProvider {
    
    var blackTheme = false
    var itemInfo = IndicatorInfo(title: "LALALA")
    var enPromocion = [String]()
    var favoritos = [String]()
    var scrollIndex = 0
    
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
        
        loadEnPromocion()
        loadFavoritos()
    }
    
    func loadEnPromocion() {
        enPromocion = FirebaseAPI.getEnPromocionUserDefaults()
        FirebaseAPI.storeSelectedUserDefaults(name: enPromocion[0])
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
    
    var imageArray = [UIImage(named: "Login Background"), UIImage(named: "Login Background"), UIImage(named: "Login Background")]
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PromocionCell", for: indexPath) as! PromocionCell
        if enPromocion.count != 0 {
            let currentLocal = FirebaseAPI.getCoreLocal(name: enPromocion[scrollIndex])
            let locationArray = currentLocal.ubicacion?.components(separatedBy: ", ")
            let latitud = locationArray?[0]
            let longitud = locationArray?[1]
            
            //Google Maps
            cell.promocionMapView.clear()
            
            let camera = GMSCameraPosition.camera(withLatitude: Double(latitud!)! - 0.004, longitude: Double(longitud!)!, zoom: 16.0)
            cell.promocionMapView.camera = camera
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: Double(latitud!)!, longitude: Double(longitud!)!)
            marker.title = ""
            marker.snippet = ""
            marker.icon = UIImage(named: "Simbolo")
            marker.map = cell.promocionMapView
        }
        
        //Categoria
        cell.categoriaBlue.layer.cornerRadius = 20
        cell.categoriaWhite.layer.cornerRadius = 20
        
        let indumentariaBlue = UIImage(named: "Indumentaria")?.withRenderingMode(.alwaysTemplate)
        cell.categoriaImg.image = indumentariaBlue
        cell.categoriaImg.tintColor = UIColor(red: 72/255, green: 135/255, blue: 190/255, alpha: 1.0)
        
        //Scroll View
        if enPromocion.count == 0 {
            loadEnPromocion()
            tableView.reloadData()
        } else {
            for i in 0..<enPromocion.count {
                
                let local = FirebaseAPI.getCoreLocal(name: enPromocion[i])
                let localView = Bundle.main.loadNibNamed("PromocionLocalView", owner: nil, options: nil)?[0] as! PromocionLocalView
                
                let urlFondo = URL(string: local.imagenFondo!)
                localView.localBackground.sd_setImage(with: urlFondo, placeholderImage: UIImage(named: "Image Not Available"))
                
                localView.localName.text = local.nombre
                localView.localAddress.text = local.direccion
                
                if isLocal(local: local.nombre!, locales: favoritos) {
                    localView.localFavorite.isSelected = true
                }
                
                localView.localVerMas.layer.cornerRadius = 15
                
                    
                let xPosition = self.view.frame.width * CGFloat(i)
                localView.frame = CGRect(x: xPosition + 20,
                                         y: 0,
                                         width: cell.promocionHorizontalScroll.frame.width - 40,
                                         height: cell.promocionHorizontalScroll.frame.height)
                
                cell.promocionHorizontalScroll.contentSize.width = cell.promocionHorizontalScroll.frame.width * CGFloat(i + 1)
                cell.promocionHorizontalScroll.addSubview(localView)
                
                cell.promocionHorizontalScroll.delegate = self
                cell.promocionHorizontalScroll.contentOffset = CGPoint(x: cell.promocionHorizontalScroll.frame.width * CGFloat(scrollIndex), y: 0)
                
        
            }
        }
        
        return cell
    }
    
    func isLocal(local: String, locales: [String]) -> Bool {
        for currentLocal in locales {
            if currentLocal == local {
                return true
            }
        }
        return false
    }
    
    //MARK: UIScrollViewDelegate
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let previousPage = scrollIndex;
        let pageWidth = scrollView.frame.size.width;
        let fractionalPage = scrollView.contentOffset.x / pageWidth;
        let page = lround(Double(fractionalPage));
        if (previousPage != page) {
            scrollIndex = page
            FirebaseAPI.storeSelectedUserDefaults(name: enPromocion[page])
            tableView.reloadData()
        }
    }
    
    // MARK: - IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    
}
