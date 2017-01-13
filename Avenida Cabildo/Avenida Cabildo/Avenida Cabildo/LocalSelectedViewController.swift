//
//  LocalSelectedViewController.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 1/13/17.
//  Copyright © 2017 Fernando N. Frassia. All rights reserved.
//

import UIKit

class LocalSelectedViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var localBackground: UIImageView!
    @IBOutlet weak var localLogo: UIImageView!
    @IBOutlet weak var localName: UILabel!
    @IBOutlet weak var localCategory: UILabel!
    @IBOutlet weak var localShare: UIButton!
    @IBOutlet weak var localFavorite: UIButton!
    @IBOutlet weak var localDiscount: UILabel!
    
    
    
    var selectedLocal = Local()
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
