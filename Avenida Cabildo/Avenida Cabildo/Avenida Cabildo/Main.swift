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

class Main: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var promocionesTableView: UITableView!
    @IBOutlet weak var todosTableView: UITableView!
    @IBOutlet weak var revealMenuButton: UIBarButtonItem!
    @IBOutlet weak var promocionesButton: UIButton!
    @IBOutlet weak var todosButton: UIButton!
    @IBOutlet weak var scrollIndicator: UIView!
    @IBOutlet weak var mainScroll: UIScrollView!
    
    func showLoginViewController() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let controller = storyboard.instantiateInitialViewController()
        self.present(controller!, animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        setRevealMenuButton()

        super.viewDidLoad()
        setNavBar()
        promocionesTableView.register(UINib(nibName: "PromocionCell", bundle: Bundle.main), forCellReuseIdentifier: "PromocionCell")
        todosTableView.register(UINib(nibName: "PostCell", bundle: Bundle.main), forCellReuseIdentifier: "postCell")
        todosTableView.register(UINib(nibName: "Local2", bundle: Bundle.main), forCellReuseIdentifier: "Local2")
        todosTableView.register(UINib(nibName: "Local3", bundle: Bundle.main), forCellReuseIdentifier: "Local3")
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.loadLocales), name: NSNotification.Name(rawValue: localesStoredOrUpdatedKey), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadEnPromocion()
        loadFavoritos()
        loadPromocionSelected()
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
        revealMenuButton.target = self.revealViewController()
        revealMenuButton.action = Selector(("revealToggle:"))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
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
        cell.categoriaButton.setTitle(promocionSelectedName, for: .normal)
        
        var imageKey = ""
        if DeviceType.IS_IPHONE_6P {
            imageKey = "3x"
        } else {
            imageKey = "2x"
        }
        
        let urlIcon = URL(string: promocionSelectedImage[imageKey]!)
        cell.categoriaImg.sd_setImage(with: urlIcon, placeholderImage: UIImage(named: "Image Not Available"))
        cell.categoriaImg.image = cell.categoriaImg.image?.withRenderingMode(.alwaysTemplate)
        
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
    
    //MARK: - Todos TableView
    var locales = [Local]()
    
    func loadLocales() {
        locales = FirebaseAPI.getCoreLocales()
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
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == promocionesTableView {
            return 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == promocionesTableView {
            return 1
        } else {
            return locales.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == promocionesTableView {
            return promocionesTableView.frame.height
        } else {
            let local = locales[indexPath.row]
            if local.visibilidad == 3 {
                return 100
            } else if local.visibilidad == 2 {
                return 110
            } else {
                return 200
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == promocionesTableView {
            return cellPromocion(tableView: tableView, indexPath: indexPath)
        } else {
            return cellTodos(tableView: tableView, indexPath: indexPath)
        }
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
                promocionesTableView.reloadData()
            }
        }
    }
    
    func setPromocionesSelected() {
        promocionesButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        todosButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        swipeIndicatorLeading.isActive = true
        swipeIndicatorTrailing.isActive = false
    }
    
    func setTodosSelected() {
        todosButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        promocionesButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        swipeIndicatorLeading.isActive = false
        swipeIndicatorTrailing.isActive = true
    }
    
    
    @IBAction func promocionesAction(_ sender: Any) {
        var x = self.view.frame.width
        while x > 0 {
            x = x - 20
            mainScroll.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        }
        mainScroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        setPromocionesSelected()
    }
    
    @IBAction func todosAction(_ sender: Any) {
        var x = CGFloat(0)
        while x < self.view.frame.width {
            x = x + 20
            mainScroll.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        }
        mainScroll.setContentOffset(CGPoint(x: self.view.frame.width, y: 0), animated: true)
        setTodosSelected()
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
