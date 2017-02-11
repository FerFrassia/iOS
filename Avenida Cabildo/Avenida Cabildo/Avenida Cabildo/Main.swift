//
//  Main.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 12/30/16.
//  Copyright © 2016 Fernando N. Frassia. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import SWRevealViewController
import GoogleMaps
import CoreData

class Main: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, SWRevealViewControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var todosTableView: UITableView!
    @IBOutlet weak var revealMenuButton: UIBarButtonItem!
    @IBOutlet weak var promocionesButton: UIButton!
    @IBOutlet weak var todosButton: UIButton!
    @IBOutlet weak var scrollIndicator: UIView!
    @IBOutlet weak var mainScroll: UIScrollView!
    
    var filterGaveEmptyList = false
    var emptyListAlertAlreadyShowed = false
    
    func showLoginViewController() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let controller = storyboard.instantiateInitialViewController()
        self.present(controller!, animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        setRevealMenuButton()

        super.viewDidLoad()
        setNavBar()
        promocionCollection.register(UINib(nibName: "PromocionLocalCell", bundle: Bundle.main), forCellWithReuseIdentifier: "PromocionLocalCell")
        todosTableView.register(UINib(nibName: "PostCell", bundle: Bundle.main), forCellReuseIdentifier: "postCell")
        todosTableView.register(UINib(nibName: "Local2", bundle: Bundle.main), forCellReuseIdentifier: "Local2")
        todosTableView.register(UINib(nibName: "Local3", bundle: Bundle.main), forCellReuseIdentifier: "Local3")
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.loadLocales), name: NSNotification.Name(rawValue: localesStoredOrUpdatedKey), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.loadLocalesByNotificationFilter), name: NSNotification.Name(rawValue: filtersUpdatedKey), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.redrawPromocionAndTodosFavorite), name: NSNotification.Name(rawValue: promocionUpdatedKey), object: nil)
        
        setPromocionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadFavoritos()
        redrawSelectedLocal()
        loadEnPromocion()
        setPromocionMap()
        loadPromocionSelected()
        loadLocales()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        filterGaveEmptyList = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if filterGaveEmptyList {
            displayAlertNoLocales()
        }
    }
    
    func redrawSelectedLocal() {
        let selectedName = FirebaseAPI.getSelectedUserDefaults()
        var index = -1
        for var i in 0..<locales.count {
            let local = locales[i]
            if local.nombre == selectedName {
                index = i
                break
            }
        }
        
        if index != -1 {
            todosTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }
        
    }
    
    func setNavBar() {
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.backgroundColor = .white
        let logo = UIImage(named: "Simbolo")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
    
    func setRevealMenuButton() {
        revealViewController().delegate = self
        revealMenuButton.target = self.revealViewController()
        revealMenuButton.action = Selector(("revealToggle:"))
        let panGesture = self.revealViewController().panGestureRecognizer()
        mainScroll.addGestureRecognizer(panGesture!)
    }
    
    func revealControllerPanGestureShouldBegin(_ revealController: SWRevealViewController!) -> Bool {
        if mainScroll.contentOffset.x == 0 ||
            (mainScroll.contentOffset.x == self.view.frame.width && self.revealViewController().frontViewPosition == FrontViewPosition.right) {
            return true
        } else {
            return false
        }
    }
    
    //MARK: - Promocion TableView
    var blackTheme = false
    var enPromocion = [String]()
    var promocionSelectedName = ""
    var promocionSelectedImage = [String:String]()
    var favoritos = [String]()
    var scrollIndex = 0
    
    func loadEnPromocion() {
        enPromocion = FirebaseAPI.getEnPromocionUserDefaults()
        enPromocion = filterLocalesEnPromocion(todos: enPromocion)
        if enPromocion.count > 0 {
            FirebaseAPI.storeSelectedUserDefaults(name: enPromocion[0])
            setPromocionMap()
        }
    }
    
    func filterLocalesEnPromocion(todos: [String]) -> [String] {
        var filtrados = [String]()
        let categoriaLocales = FirebaseAPI.getCategoriaSelectedLocales()
        if categoriaLocales.count != 0 {
            for local in todos {
                for categoriaLocal in categoriaLocales {
                    if categoriaLocal == local {
                        filtrados.append(local)
                    }
                }
            }
        } else {
            filtrados = todos
        }
        return filtrados
    }
    
    func loadFavoritos() {
        favoritos = FirebaseAPI.getFavoritesUserDefaults()
    }
    
    func loadPromocionSelected() {
        promocionSelectedName = FirebaseAPI.getCategoriaSelectedNombre()
        promocionSelectedImage = FirebaseAPI.getCategoriaSelectedImage()
    }
    
    func redrawPromocionAndTodosFavorite() {
        loadFavoritos()
        promocionCollection.reloadData()
        todosTableView.reloadData()
    }
    
    func cellPromocion(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
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
        cell.categoriaLabel.text = promocionSelectedName
        
        var imageKey = ""
        if DeviceType.IS_IPHONE_6P {
            imageKey = "3x"
        } else {
            imageKey = "2x"
        }
        
        let urlIcon = URL(string: promocionSelectedImage[imageKey]!)
        DispatchQueue(label: "com.queue.Concurrent", attributes: .concurrent).async {
            if let data = try? Data(contentsOf: urlIcon!) {
                DispatchQueue.main.async {
                    cell.categoriaImg.image = UIImage(data: data)?.withRenderingMode(.alwaysTemplate)
                }
            }
        }
        
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
                    localView.localDescuento.image = UIImage(named: imageName)
                }
                
                localView.localName.text = local.nombre
                localView.localAddress.text = local.direccion
                
                localView.localFavorite.isSelected = isLocal(local: local.nombre!, locales: favoritos)
                
                localView.localVerMas.layer.cornerRadius = 15
                
                //tarjetas Img
                if let descuentosNames = local.descuentos as? [String] {
                    for descuentoName in descuentosNames {
                        var imgName = ""
                        imgName = descuentoName
                        if descuentoName == "2x1 con La Nación" {
                            imgName = "2x1 con La Nacion"
                        }
                        if let img = UIImage(named: imgName) {
                            if localView.tarjeta1.tag == 0 {
                                localView.tarjeta1.image = img
                                localView.tarjeta1.tag = 1
                            } else if localView.tarjeta2.tag == 0 {
                                localView.tarjeta2.image = img
                                localView.tarjeta2.tag = 1
                            } else if localView.tarjeta3.tag == 0 {
                                localView.tarjeta3.image = img
                                localView.tarjeta3.tag = 1
                            } else if localView.tarjeta4.tag == 0 {
                                localView.tarjeta4.image = img
                                localView.tarjeta4.tag = 1
                            }
                        }
                    }
                }
                
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
        
        //Fix constraints category
        if DeviceType.IS_IPHONE_5 {
            cell.categoriaBlueLeading.constant = 50
            cell.categoriaBlueTrailing.constant = 50
        }
        
        return cell
    }
    
    //MARK: - Todos TableView
    var locales = [Local]()
    
    func loadLocales() {
        loadAndFilterLocales()
        if checkLocalesEmpty() {
            loadFullLocales()
        }
        promocionCollection.reloadData()
        todosTableView.reloadData()
    }
    
    func loadLocalesByNotificationFilter() {
        loadAndFilterLocales()
        if checkLocalesEmpty() {
            loadFullLocales()
            filterGaveEmptyList = true
        } else {
            filterGaveEmptyList = false
        }
        promocionCollection.reloadData()
        todosTableView.reloadData()
    }
    
    func filterLocales() {
        if FirebaseAPI.isFiltersActive() {
            var filtered = [Local]()
            if FirebaseAPI.isFiltersByCategoryOrDescuentoActive() || FirebaseAPI.isFilterByNameActive() {
                let porCategoria = localesMatchingCategoria()
                let porDescuento = localesMatchingDescuentos()
                let porNombre = localesMatchingName()
                filtered = Array(Set(porCategoria + porDescuento + porNombre))
            } else {
                filtered = FirebaseAPI.getCoreLocales()
            }
            let filteredPorAbiertoAhora = localesMatchingAbiertoAhora(localesToFilter: filtered)
            locales = filteredPorAbiertoAhora
        }
    }
    
    func localesMatchingCategoria() -> [Local] {
        var filtered = [Local]()
        if FirebaseAPI.isFiltersActive() {
            for local in locales {
                if FirebaseAPI.isFilterInFilters(filterName: local.categoria!) {
                    filtered.append(local)
                }
            }
        }
        return filtered
    }
    
    func localesMatchingDescuentos() -> [Local] {
        var filtered = [Local]()
        if FirebaseAPI.isFiltersActive() {
            for local in locales {
                if let descuentos = local.descuentos as? [String] {
                    if FirebaseAPI.isFiltersInFilters(filtersToCheck: descuentos) {
                        filtered.append(local)
                    }
                }
            }
        }
        return filtered
    }
    
    func localesMatchingName() -> [Local] {
        var filtered = [Local]()
        for local in locales {
            if let nombre = local.nombre {
                if FirebaseAPI.isNameInFiltersByName(name: nombre.lowercased()) {
                    filtered.append(local)
                }
            }
        }
        return filtered
    }
    
    func localesMatchingAbiertoAhora(localesToFilter: [Local]) -> [Local] {
        if FirebaseAPI.isFilterAbiertoAhoraActive() {
            var filtered = [Local]()
            for local in localesToFilter {
                if FirebaseAPI.isLocalOpenNow(local: local) {
                    filtered.append(local)
                }
            }
            return filtered
        } else {
            return localesToFilter
        }
    }
    
    func checkLocalesEmpty() -> Bool {
        return locales.count == 0
    }
    
    func loadFullLocales() {
        locales = FirebaseAPI.getCoreLocales()
        orderLocales()
    }
    
    func loadAndFilterLocales() {
        locales = FirebaseAPI.getCoreLocales()
        orderLocales()
        filterLocales()
    }
    
    func checkLocalesEmptyByNotifications() {
        if checkLocalesEmpty() && FirebaseAPI.isFiltersActive() {
            displayAlertNoLocales()
            locales = FirebaseAPI.getCoreLocales()
            orderLocales()
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
    
    func cellTodos(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
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
        
        cell.localFavorite.isSelected = isLocal(local: local.nombre!, locales: favoritos)
        
        
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
        
        cell.localFavorite.isSelected = isLocal(local: local.nombre!, locales: favoritos)
        
        let shareWhite = UIImage(named: "Share")?.withRenderingMode(.alwaysTemplate)
        cell.localShare.setBackgroundImage(shareWhite, for: .normal)
        cell.localShare.tintColor = UIColor.white
        
        //tarjetas Img
        if let descuentosNames = local.descuentos as? [String] {
            for descuentoName in descuentosNames {
                FIRDatabase.database().reference().child("descuentos").child(descuentoName).observeSingleEvent(of: .value, with: { (snap) in
                    if let snapDict = snap.value as? Dictionary<String, AnyObject> {
                        if let tarjetaDic = snapDict["imagen"] as? [String:String] {
                            
                            var imageKey = ""
                            if DeviceType.IS_IPHONE_6P {
                                imageKey = "3x"
                            } else {
                                imageKey = "2x"
                            }
                            
                            if let tarjetaString = tarjetaDic[imageKey] {
                                let urlIcon = URL(string: tarjetaString)
                                if cell.tarjeta1.isHidden {
                                    cell.tarjeta1.sd_setImage(with: urlIcon, placeholderImage: UIImage(named: "Image Not Available"))
                                    cell.tarjeta1.isHidden = false
                                    cell.tarjeta2.isHidden = true
                                    cell.tarjeta3.isHidden = true
                                    cell.tarjeta4.isHidden = true
                                } else if cell.tarjeta2.isHidden {
                                    cell.tarjeta2.sd_setImage(with: urlIcon, placeholderImage: UIImage(named: "Image Not Available"))
                                    cell.tarjeta2.isHidden = false
                                    cell.tarjeta3.isHidden = true
                                    cell.tarjeta4.isHidden = true
                                } else if cell.tarjeta3.isHidden {
                                    cell.tarjeta3.sd_setImage(with: urlIcon, placeholderImage: UIImage(named: "Image Not Available"))
                                    cell.tarjeta3.isHidden = false
                                    cell.tarjeta4.isHidden = true
                                } else if cell.tarjeta4.isHidden {
                                    cell.tarjeta4.sd_setImage(with: urlIcon, placeholderImage: UIImage(named: "Image Not Available"))
                                    cell.tarjeta4.isHidden = false
                                }
                            }
                        }
                    }
                }) { (error) in
                    print(error.localizedDescription)
                }
            }
        }
        
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
        
        cell.localFavorite.isSelected = isLocal(local: local.nombre!, locales: favoritos)
        
        let shareWhite = UIImage(named: "Share")?.withRenderingMode(.alwaysTemplate)
        cell.localShare.setBackgroundImage(shareWhite, for: .normal)
        cell.localShare.tintColor = UIColor.white
        
        //tarjetas Img
        if let descuentosNames = local.descuentos as? [String] {
            for descuentoName in descuentosNames {
                FIRDatabase.database().reference().child("descuentos").child(descuentoName).observeSingleEvent(of: .value, with: { (snap) in
                    if let snapDict = snap.value as? Dictionary<String, AnyObject> {
                        if let tarjetaDic = snapDict["imagen"] as? [String:String] {
                            
                            var imageKey = ""
                            if DeviceType.IS_IPHONE_6P {
                                imageKey = "3x"
                            } else {
                                imageKey = "2x"
                            }
                            
                            if let tarjetaString = tarjetaDic[imageKey] {
                                let urlIcon = URL(string: tarjetaString)
                                if cell.tarjeta1.isHidden {
                                    cell.tarjeta1.sd_setImage(with: urlIcon, placeholderImage: UIImage(named: "Image Not Available"))
                                    cell.tarjeta1.isHidden = false
                                    cell.tarjeta2.isHidden = true
                                    cell.tarjeta3.isHidden = true
                                    cell.tarjeta4.isHidden = true
                                } else if cell.tarjeta2.isHidden {
                                    cell.tarjeta2.sd_setImage(with: urlIcon, placeholderImage: UIImage(named: "Image Not Available"))
                                    cell.tarjeta2.isHidden = false
                                    cell.tarjeta3.isHidden = true
                                    cell.tarjeta4.isHidden = true
                                } else if cell.tarjeta3.isHidden {
                                    cell.tarjeta3.sd_setImage(with: urlIcon, placeholderImage: UIImage(named: "Image Not Available"))
                                    cell.tarjeta3.isHidden = false
                                    cell.tarjeta4.isHidden = true
                                } else if cell.tarjeta4.isHidden {
                                    cell.tarjeta4.sd_setImage(with: urlIcon, placeholderImage: UIImage(named: "Image Not Available"))
                                    cell.tarjeta4.isHidden = false
                                }
                            }
                        }
                    }
                }) { (error) in
                    print(error.localizedDescription)
                }
            }
        }
        
        return cell
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locales.count
    }
    
    func displayAlertNoLocales() {
        let alertController = UIAlertController(title: "", message: "No se encontraron locales para esta búsqueda", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            (result : UIAlertAction) -> Void in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    
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
        return cellTodos(tableView: tableView, indexPath: indexPath)
    }
    
    func isLocal(local: String, locales: [String]) -> Bool {
        for currentLocal in locales {
            if currentLocal == local {
                return true
            }
        }
        return false
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == todosTableView {
            let local = locales[indexPath.row]
            FirebaseAPI.storeSelectedUserDefaults(name: local.nombre!)
            let story = UIStoryboard(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(withIdentifier: "LocalSelectedViewController") as! LocalSelectedViewController
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    //MARK: - Promo Scroll Horizontal
    @IBOutlet weak var swipeIndicatorLeading: NSLayoutConstraint!
    @IBOutlet weak var swipeIndicatorTrailing: NSLayoutConstraint!
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == mainScroll {
            let stoppingX = self.view.frame.width/2
            if scrollView.contentOffset.x < stoppingX {
                UIView.animate(withDuration: 0.1, delay: 0,
                               options: [],
                               animations: {
                                self.scrollIndicator.frame.origin.x = scrollView.contentOffset.x
                }, completion: nil)
            } else {
                UIView.animate(withDuration: 0.1, delay: 0,
                               options: [],
                               animations: {
                                self.scrollIndicator.frame.origin.x = stoppingX
                }, completion: nil)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == mainScroll {
            if scrollView.contentOffset.x == 0 {
                setPromocionesSelected()
            } else {
                setTodosSelected()
            }
        } else {
            let previousPage = scrollIndex;
            let pageWidth = scrollView.frame.size.width;
            let fractionalPage = scrollView.contentOffset.x / pageWidth;
            let page = lround(Double(fractionalPage));
            if (previousPage != page) {
                scrollIndex = page
                FirebaseAPI.storeSelectedUserDefaults(name: enPromocion[page])
                setPromocionMap()
            }
        }
    }
    
    func setPromocionesSelected() {
        promocionesButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        todosButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        swipeIndicatorLeading.isActive = true
        swipeIndicatorTrailing.isActive = false
    }
    
    func setPromocionesSelectedFont() {
        promocionesButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        todosButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 15)
    }
    
    func setTodosSelected() {
        todosButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        promocionesButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        swipeIndicatorLeading.isActive = false
        swipeIndicatorTrailing.isActive = true
    }
    
    func setTodosSelectedFont() {
        todosButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        promocionesButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 15)
    }
    
    @IBAction func promocionesAction(_ sender: Any) {
        var x = self.view.frame.width
        while x > 0 {
            x = x - 20
            mainScroll.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        }
        mainScroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        setPromocionesSelectedFont()
    }
    
    @IBAction func todosAction(_ sender: Any) {
        var x = CGFloat(0)
        while x < self.view.frame.width {
            x = x + 20
            mainScroll.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        }
        mainScroll.setContentOffset(CGPoint(x: self.view.frame.width, y: 0), animated: true)
        setTodosSelectedFont()
    }
    
    //MARK: - Nav
    @IBAction func filterAction(_ sender: Any) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK: - Promocion View
    @IBOutlet weak var promocionScrollView: UIScrollView!
    @IBOutlet weak var promocionMapView: GMSMapView!
    @IBOutlet weak var promocionCollection: UICollectionView!
    @IBOutlet weak var categoriaBlue: UIView!
    @IBOutlet weak var categoriaWhite: UIView!
    @IBOutlet weak var categoriaImg: UIImageView!
    @IBOutlet weak var categoriaButton: UIButton!
    @IBOutlet weak var categoriaLabel: UILabel!
    
    @IBOutlet weak var categoriaBlueLeading: NSLayoutConstraint!
    @IBOutlet weak var categoriaBlueTrailing: NSLayoutConstraint!
    
    @IBAction func categoryPressed(_ sender: Any) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "ChangeCategory") as! ChangeCategoryTableViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    func setPromocionView() {
        loadPromocionSelected()
        setCategoria()
    }
    
    func setCategoria() {
        categoriaBlue.layer.cornerRadius = 20
        categoriaWhite.layer.cornerRadius = 20
        categoriaLabel.text = promocionSelectedName
        
        var imageKey = ""
        if DeviceType.IS_IPHONE_6P {
            imageKey = "3x"
        } else {
            imageKey = "2x"
        }
        
        let urlIcon = URL(string: promocionSelectedImage[imageKey]!)
        DispatchQueue(label: "com.queue.Concurrent", attributes: .concurrent).async {
            if let data = try? Data(contentsOf: urlIcon!) {
                DispatchQueue.main.async {
                    self.categoriaImg.image = UIImage(data: data)?.withRenderingMode(.alwaysTemplate)
                }
            }
        }
        
        //Fix constraints category
        if DeviceType.IS_IPHONE_5 {
            categoriaBlueLeading.constant = 50
            categoriaBlueTrailing.constant = 50
        }
    }
    
    func setPromocionMap() {
        promocionMapView.clear()
        
        if enPromocion.count == 0 {
            return
        }
        
        let currentLocal = FirebaseAPI.getCoreLocal(name: enPromocion[scrollIndex])
        let locationArray = currentLocal.ubicacion?.components(separatedBy: ", ")
        let latitud = locationArray?[0]
        let longitud = locationArray?[1]
        
        let camera = GMSCameraPosition.camera(withLatitude: Double(latitud!)! - 0.004, longitude: Double(longitud!)!, zoom: 16.0)
        promocionMapView.camera = camera
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: Double(latitud!)!, longitude: Double(longitud!)!)
        marker.title = currentLocal.nombre
        marker.snippet = ""
        marker.icon = UIImage(named: "Simbolo")
        marker.map = promocionMapView
    }
    
    
    //MARK: - Promociones Collection DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return enPromocion.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromocionLocalCell", for: indexPath) as! PromocionLocalCell
        
        let local = FirebaseAPI.getCoreLocal(name: enPromocion[indexPath.row])
        
        let urlFondo = URL(string: local.imagenFondo!)
        cell.localBackground.sd_setImage(with: urlFondo, placeholderImage: UIImage(named: "Image Not Available"))
        
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
        
        cell.localName.text = local.nombre
        cell.localAddress.text = local.direccion
        
        cell.localFavorite.isSelected = isLocal(local: local.nombre!, locales: favoritos)
        
        cell.localVerMas.layer.cornerRadius = 15
        
        //tarjetas Img
        if let descuentosNames = local.descuentos as? [String] {
            for descuentoName in descuentosNames {
                var imgName = ""
                imgName = descuentoName
                if descuentoName == "2x1 con La Nación" {
                    imgName = "2x1 con La Nacion"
                }
                if let img = UIImage(named: imgName) {
                    if cell.tarjeta1.tag == 0 {
                        cell.tarjeta1.image = img
                        cell.tarjeta1.tag = 1
                    } else if cell.tarjeta2.tag == 0 {
                        cell.tarjeta2.image = img
                        cell.tarjeta2.tag = 1
                    } else if cell.tarjeta3.tag == 0 {
                        cell.tarjeta3.image = img
                        cell.tarjeta3.tag = 1
                    } else if cell.tarjeta4.tag == 0 {
                        cell.tarjeta4.image = img
                        cell.tarjeta4.tag = 1
                    }
                }
            }
        }
        
        return cell
    }
    
    //MARK: - iPhone Size
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
