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

class LocalSelectedViewController: UIViewController, UIScrollViewDelegate, UITableViewDataSource {

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
        selectedLocal = FirebaseAPI.getCoreLocal(name: selectedName)
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
        
        
        super.viewWillAppear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UIScrollViewDelegate
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

    //MARK: UITableView Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let descuentos = selectedLocal.descuentos as! [String]
        return descuentos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeneficiosCell", for: indexPath) as! BeneficiosCell
        
        let descuentos = selectedLocal.descuentos as! [String]
        
        FIRDatabase.database().reference().child("descuentos").child(descuentos[indexPath.row]).observeSingleEvent(of: .value, with: { (snap) in
            if let snapDict = snap.value as? Dictionary<String, AnyObject> {
                if let tarjetaString = snapDict["imagen"] {
                    let urlIcon = URL(string: tarjetaString as! String)
                    cell.beneficiosImage.sd_setImage(with: urlIcon, placeholderImage: UIImage(named: "Image Not Available"))
                }
                
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    
        cell.beneficiosLabel.text = descuentos[indexPath.row]
        
        return cell
    }

}
