//
//  ChangeCategoryTableViewController.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 1/13/17.
//  Copyright © 2017 Fernando N. Frassia. All rights reserved.
//

import UIKit

class ChangeCategoryTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var categorias = [Categoria]()
    var enPromocion = [String]()
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategorias()
        loadEnPromocion()
        setNavBarBackButton()
    }
    
    func setNavBarBackButton() {
        backButton.setImage(UIImage(named: "Arrow Menu")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.tintColor = .black
    }
    
    func loadCategorias() {
        if let cats = FirebaseAPI.getCoreCategorias() {
            categorias = cats
        }
    }
    
    func loadEnPromocion() {
        enPromocion = FirebaseAPI.getEnPromocionUserDefaults()
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorias.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChangeCategoryCell", for: indexPath) as? ChangeCategoryCell
        let categoria = categorias[indexPath.row]
        
        var imageKey = ""
        if DeviceType.IS_IPHONE_6P {
            imageKey = "3x"
        } else {
            imageKey = "2x"
        }
        
        if let iconDic = categoria.imagen as? Dictionary<String, String> {
            let urlIcon = URL(string: iconDic[imageKey]!)
            cell?.cellImage.sd_setImage(with: urlIcon, placeholderImage: UIImage(named: "Image Not Available"))
        }
        
        if let nombre = categoria.nombre {
            cell?.cellLabel.text = nombre
        }

        return cell!
    }
    
    //MARK: -UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoria = categorias[indexPath.row]
        
        let locales = categoria.locales as? [String]?
        if let locs = locales {
            if (locs?.count)! > 0 {
                if let nombre = categoria.nombre {
                    FirebaseAPI.setCategoriaSelected(name: nombre,
                                                     locales: categoria.locales as! [String]?,
                                                     image: categoria.imagen as! [String:String])
                }
                self.dismiss(animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "", message: "No se encontraron locales para esta categoría", preferredStyle: UIAlertControllerStyle.alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                {
                    (result : UIAlertAction) -> Void in
                    tableView.deselectRow(at: indexPath, animated: true)
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
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


