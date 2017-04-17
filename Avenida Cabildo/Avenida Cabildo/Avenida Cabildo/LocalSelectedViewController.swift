//
//  LocalSelectedViewController.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 1/13/17.
//  Copyright © 2017 Fernando N. Frassia. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import GoogleMaps
import MessageUI

class LocalSelectedViewController: UIViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var localBackground: UIImageView!
    @IBOutlet weak var localLogo: UIImageView!
    @IBOutlet weak var localName: UILabel!
    @IBOutlet weak var localCategory: UILabel!
    @IBOutlet weak var localShare: UIButton!
    @IBOutlet weak var localFavorite: UIButton!
    @IBOutlet weak var localDiscount: UILabel!
    @IBOutlet weak var scrollIndicator: UIView!
    @IBOutlet weak var scrollHorizontal: UIScrollView!
    @IBOutlet weak var beneficiosButton: UIButton!
    @IBOutlet weak var detallesButton: UIButton!
    
    
    var selectedLocal = Local()
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBarBackButton()
    }
    
    func setNavBarBackButton() {
        backButton.setImage(UIImage(named: "Arrow Menu")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.tintColor = .black
    }
    
    func loadSelectedLocal() {
        let selectedName = FirebaseAPI.getSelectedUserDefaults()
        if let selectedCoreLocal = FirebaseAPI.getCoreLocal(name: selectedName) {
            selectedLocal = selectedCoreLocal
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadSelectedLocal()
        
        let urlFondo = URL(string: selectedLocal.imagenFondo!)
        localBackground.sd_setImage(with: urlFondo, placeholderImage: UIImage(named: "Image Not Available"))
        
        let urlLogo = URL(string: selectedLocal.imagenLogo!)
        localLogo.sd_setImage(with: urlLogo, placeholderImage: UIImage(named: "Image Not Available"))
        
        localName.text = selectedLocal.nombre
        localCategory.text = selectedLocal.categoria
        
        let shareWhite = UIImage(named: "Share")?.withRenderingMode(.alwaysTemplate)
        localShare.setBackgroundImage(shareWhite, for: .normal)
        localShare.tintColor = UIColor.white
        
        localDiscount.text = "\(selectedLocal.efectivo!) DESCUENTO"
        
        loadDetalle()
        setLocalFavorite()
        super.viewWillAppear(true)
    }

    func setLocalFavorite() {
        localFavorite.isSelected = FirebaseAPI.isLocalFavorited(nombre: selectedLocal.nombre!)
    }
    
    //MARK: -UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
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
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 {
            setBeneficiosSelected()
        } else {
            setDetallesSelected()
        }
    }
    
    //MARK: -Beneficios
    @IBOutlet weak var beneficiosTableView: UITableView!
    
    func setBeneficiosSelected() {
        beneficiosButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        detallesButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 17)
    }
    
    func setDetallesSelected() {
        detallesButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        beneficiosButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 17)
    }
    
    @IBAction func beneficiosAction(_ sender: Any) {
        var x = self.view.frame.width
        while x > 0 {
            x = x - 20
            scrollHorizontal.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        }
        scrollHorizontal.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        setBeneficiosSelected()
    }
    
    @IBAction func detallesAction(_ sender: Any) {
        var x = CGFloat(0)
        while x < self.view.frame.width {
            x = x + 20
            scrollHorizontal.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        }
        scrollHorizontal.setContentOffset(CGPoint(x: self.view.frame.width, y: 0), animated: true)
        setDetallesSelected()
    }
    
    func configureCellBeneficios(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeneficiosCell", for: indexPath) as! BeneficiosCell
        
        let descuentos = selectedLocal.descuentos as! [String]
        FIRDatabase.database().reference().child("descuentos").observeSingleEvent(of: .value, with: { (snap) in
            if FirebaseAPI.permitedFirebaseString(toCheck: descuentos[indexPath.row]) && snap.hasChild(descuentos[indexPath.row]) {
                let descuentoSnap = snap.childSnapshot(forPath: descuentos[indexPath.row])
                if let snapDict = descuentoSnap.value as? Dictionary<String, AnyObject> {
                    if let tarjetaDic = snapDict["imagen"] as? [String:String] {
                        
                        var imageKey = ""
                        if DeviceType.IS_IPHONE_6P {
                            imageKey = "3x"
                        } else {
                            imageKey = "2x"
                        }
                        
                        if let tarjetaString = tarjetaDic[imageKey] {
                            let urlIcon = URL(string: tarjetaString)
                            cell.beneficiosImage.sd_setImage(with: urlIcon, placeholderImage: UIImage(named: "Image Not Available"))
                        }
                        
                    }
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
        cell.beneficiosLabel.text = descuentos[indexPath.row]
        
        return cell
    }

    //MARK: -UITableView Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == beneficiosTableView {
            if let descuentos = selectedLocal.descuentos as? [String] {
                return descuentos.count
            } else {
                return 0
            }
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == beneficiosTableView {
            return configureCellBeneficios(tableView: tableView, indexPath: indexPath)
        } else {
            return configureCellDetalle(tableView: tableView, indexPath: indexPath)
        }
    }
    
    //MARK: -UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 80
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == detalleTableView {
            switch indexPath.row {
            case 0:
                let locationArray = selectedLocal.ubicacion?.components(separatedBy: ", ")
                if let latitud = locationArray?[0] {
                    if let longitud = locationArray?[1] {
                        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
                            if let url = URL(string: "comgooglemaps://?saddr=&daddr=\(latitud),\(longitud)&directionsmode=driving") {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        } else {
                            displayAlert(message: "Google Maps no pudo abrirse")
                        }
                    }
                }
                
            case 1:
                break
            case 2:
                if let number = selectedLocal.telefono {
                    if let url = URL(string: "tel://\(number)") {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
                
            case 3:
                sendMail()
            case 4:
                if let web = selectedLocal.web {
                    if let url = URL(string: web) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            default:
                break
            }
        }
    }
    
    func sendMail() {
        if MFMailComposeViewController.canSendMail() {
            if let mail = selectedLocal.mail {
                let composeVC = MFMailComposeViewController()
                composeVC.mailComposeDelegate = self
                composeVC.setToRecipients([mail])
                composeVC.setSubject("Consulta")
                composeVC.setMessageBody("", isHTML: false)
                self.present(composeVC, animated: true, completion: nil)
            } else {
                displayAlert(message: "El local no posee mail")
            }
        } else {
            displayAlert(message: "El mail no pudo enviarse")
        }
    }
    
    func displayAlert(message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            (result : UIAlertAction) -> Void in
            
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: -Detalle
    @IBOutlet weak var detalleText: UITextView!
    @IBOutlet weak var detalleMap: GMSMapView!
    @IBOutlet weak var detalleTableView: UITableView!
    
    @IBOutlet weak var scrollHeight: NSLayoutConstraint!
    @IBOutlet weak var detalleMapTop: NSLayoutConstraint!
    @IBOutlet weak var detalleTableViewTop: NSLayoutConstraint!
    @IBOutlet weak var horizontalContentHeight: NSLayoutConstraint!
    
    
    func loadDetalle() {
        loadDetalleMap()
        loadDetalleText()
    }
    
    func loadDetalleText() {
        detalleText.text = selectedLocal.detalleTexto!
        changeConstraintsDueToDetalleText()
    }
    
    func changeConstraintsDueToDetalleText() {
        var someConstant = 0
        if DeviceType.IS_IPHONE_6P {
            someConstant = 61
        } else if DeviceType.IS_IPHONE_6 {
            someConstant = 39
        } else {
            someConstant = -20
        }
        
        scrollHeight.constant = scrollHorizontal.frame.origin.y + detalleTableView.frame.origin.y + detalleTableView.frame.size.height - CGFloat(someConstant)
    }
    
    override func viewDidLayoutSubviews() {
        scrollHeight.constant = scrollHorizontal.frame.origin.y + detalleTableView.frame.origin.y + detalleTableView.frame.size.height
        horizontalContentHeight.constant = detalleTableView.frame.origin.y + detalleTableView.frame.size.height
    }
    
    func loadDetalleMap() {
        let locationArray = selectedLocal.ubicacion?.components(separatedBy: ", ")
        let latitud = locationArray?[0]
        let longitud = locationArray?[1]
        
        //Google Maps
        detalleMap.clear()
        
        let camera = GMSCameraPosition.camera(withLatitude: Double(latitud!)!, longitude: Double(longitud!)!, zoom: 17.0)
        detalleMap.camera = camera
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: Double(latitud!)!, longitude: Double(longitud!)!)
        marker.title = ""
        marker.snippet = ""
        marker.icon = UIImage(named: "Simbolo")
        marker.map = detalleMap
    }
    
    @IBAction func instagramAction(_ sender: Any) {
        let local = FirebaseAPI.getCoreLocal(name: (localName.text)!)
        if let instagram = local?.instagram {
            if let url = URL(string: instagram) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else {
            let alertController = UIAlertController(title: "", message: "Este local no posee instagram", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                (result : UIAlertAction) -> Void in
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func facebookAction(_ sender: Any) {
        let local = FirebaseAPI.getCoreLocal(name: (localName.text)!)
        if let fb = local?.facebook {
            if let url = URL(string: fb) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else {
            let alertController = UIAlertController(title: "", message: "Este local no posee facebook", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                (result : UIAlertAction) -> Void in
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func favoriteAction(_ sender: Any) {
        if FirebaseAPI.isUserLoggedInFirebase() {
            if let name = selectedLocal.nombre {
                if localFavorite.isSelected {
                    FirebaseAPI.removeFavorite(name: name)
                } else {
                    FirebaseAPI.addFavorite(name: name)
                }
                localFavorite.isSelected = !localFavorite.isSelected
            }
        } else {
            alertLoginFav()
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func alertLoginFav() {
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil) {
            topVC = topVC!.presentedViewController
        }
        
        let alert = UIAlertController(title: "", message: "Para utilizar Favoritos debe loguearse", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
        })
        topVC?.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sharePressed(sender: UIButton) {
        let local = FirebaseAPI.getCoreLocal(name: (localName.text)!)
        if let web = local?.web {
            let activityViewController = UIActivityViewController(activityItems: [web], applicationActivities: nil)
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    func configureCellDetalle(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetalleCell", for: indexPath) as! DetalleCell
        
        var cellImage = UIImage()
        var cellText = ""
        switch indexPath.row {
        case 0:
            cellImage = UIImage(named: "Lugar Detalle")!
            cellText = selectedLocal.direccion!
        case 1:
            cellImage = UIImage(named: "Horario Detalle")!
            cellText = selectedLocal.horarios!
        case 2:
            cellImage = UIImage(named: "Telefono Detalle")!
            cellText = selectedLocal.telefono!
        case 3:
            cellImage = UIImage(named: "Mail Detalle")!
            cellText = selectedLocal.mail!
        default:
            cellImage = UIImage(named: "Link Detalle")!
            cellText = selectedLocal.web!
        }
        
        cell.detalleImage.image = cellImage
        cell.detalleLabel.text = cellText
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    //MARK: - iPhone Size
    enum UIUserInterfaceIdiom : Int {
        case Unspecified
        case Phone
        case Pad
    }
    
    struct ScreenSize {
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    struct DeviceType {
        static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    }
    
    

}
