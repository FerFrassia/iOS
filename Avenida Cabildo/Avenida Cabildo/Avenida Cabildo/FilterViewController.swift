//
//  FilterViewController.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 1/22/17.
//  Copyright © 2017 Fernando N. Frassia. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var horizontalScroll: UIScrollView!
    @IBOutlet weak var scrollIndicator: UIView!
    @IBOutlet weak var categoriasButton: UIButton!
    @IBOutlet weak var beneficiosButton: UIButton!
    @IBOutlet weak var categoriasTableView: UITableView!
    @IBOutlet weak var beneficiosTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var abiertoAhoraSwitch: UISwitch!
    
    @IBOutlet weak var indicatorLeading: NSLayoutConstraint!
    
    var categorias = [Categoria]()
    var descuentos = [Descuento]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategorias()
        loadDescuentos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setAbiertoSwitch()
    }
    
    func setAbiertoSwitch() {
        abiertoAhoraSwitch.setOn(FirebaseAPI.isFilterAbiertoAhoraActive(), animated: false)
    }

    func loadCategorias() {
        if let cat = FirebaseAPI.getCoreCategorias() {
            categorias = cat
            removeTodos()
        }
    }
    
    func removeTodos() {
        for categoria in categorias {
            if categoria.nombre == "Todos" {
                categorias.remove(at: categorias.index(of: categoria)!)
            }
        }
    }
    
    func loadDescuentos() {
        if let desc = FirebaseAPI.getCoreDescuentos() {
            descuentos = desc
        }
    }
    
    @IBAction func limpiarAction(_ sender: Any) {
        FirebaseAPI.deleteFilters()
        FirebaseAPI.unsetFilterByAbiertoAhora()
        NotificationCenter.default.post(name: Notification.Name(rawValue: filtersUpdatedKey), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func aplicarAction(_ sender: Any) {
        checkSearchTextField()
        NotificationCenter.default.post(name: Notification.Name(rawValue: filtersUpdatedKey), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func abiertoAhoraAction(_ sender: Any) {
        if abiertoAhoraSwitch.isOn {
            FirebaseAPI.setFilterByAbiertoAhora()
        } else {
            FirebaseAPI.unsetFilterByAbiertoAhora()
        }
    }
    
    func checkSearchTextField() {
        if let text = searchTextField.text {
            if text != "" {
                FirebaseAPI.setFilterByNameDefaults(localName: text.lowercased())
            }
        }
    }
    
    //MARK: - UIScrollViewDelegate
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 {
            setCategoriasSelected()
        } else {
            setBeneficiosSelected()
        }
    }
    
    func setCategoriasSelected() {
        categoriasButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        beneficiosButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        indicatorLeading.constant = 0
    }
    
    func setBeneficiosSelected() {
        beneficiosButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        categoriasButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        indicatorLeading.constant = self.view.frame.width/2
    }
    
    @IBAction func categoriasAction(_ sender: Any) {
        var x = self.view.frame.width
        while x > 0 {
            x = x - 20
            horizontalScroll.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        }
        horizontalScroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        setCategoriasSelected()
    }
    
    
    @IBAction func beneficiosAction(_ sender: Any) {
        var x = CGFloat(0)
        while x < self.view.frame.width {
            x = x + 20
            horizontalScroll.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        }
        horizontalScroll.setContentOffset(CGPoint(x: self.view.frame.width, y: 0), animated: true)
        setBeneficiosSelected()
    }
    
    //MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == categoriasTableView {
            return categorias.count
        } else {
            return descuentos.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FiltroCell", for: indexPath) as! FiltroCell
        cell.selectionStyle = .none
        
        var imageKey = ""
        if DeviceType.IS_IPHONE_6P {
            imageKey = "3x"
        } else {
            imageKey = "2x"
        }
        
        if tableView == categoriasTableView {
            
            let categoria = categorias[indexPath.row]
            setCategoriaCellData(cell: cell, categoria: categoria, imageKey: imageKey)
            setCategoriaCellDrawing(cell: cell, filterName: categoria.nombre!)
            
        } else {
            
            let descuento = descuentos[indexPath.row]
            setDescuentoCellData(cell: cell, descuento: descuento, imageKey: imageKey)
            setDescuentoCellDrawing(cell: cell, filterName: descuento.nombre!)
        }
        
        return cell
    }
    
    func setCategoriaCellData(cell: FiltroCell, categoria: Categoria, imageKey: String) {
        cell.filtroLabel.text = categoria.nombre
        
        if let iconDic = categoria.imagen as? Dictionary<String, String> {
            let urlIcon = URL(string: iconDic[imageKey]!)
            cell.filtroImg.sd_setImage(with: urlIcon, placeholderImage: UIImage(named: "Image Not Available"))
        }
    }
    
    func setDescuentoCellData(cell: FiltroCell, descuento: Descuento, imageKey: String) {
        cell.filtroLabel.text = descuento.nombre
        
        if let iconDic = descuento.imagen as? Dictionary<String, String> {
            let urlIcon = URL(string: iconDic[imageKey]!)
            cell.filtroImg.sd_setImage(with: urlIcon, placeholderImage: UIImage(named: "Image Not Available"))
        }
    }
    
    func setCategoriaCellDrawing(cell: FiltroCell, filterName: String) {
        if FirebaseAPI.isFilterInFilters(filterName: filterName) {
            categoriaCellDrawSelected(cell: cell)
        } else {
            categoriaCellDrawUnselected(cell: cell)
        }
    }
    
    func setDescuentoCellDrawing(cell: FiltroCell, filterName: String) {
        if FirebaseAPI.isFilterInFilters(filterName: filterName) {
            descuentoCellDrawSelected(cell: cell)
        } else {
            descuentoCellDrawUnselected(cell: cell)
        }
    }
    
    func categoriaCellDrawSelected(cell: FiltroCell) {
        let blueColor = UIColor(red: 35/255, green: 107/255, blue: 167/255, alpha: 1.0)
        cell.filtroLabel.textColor = blueColor
        cell.filtroLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        cell.filtroTick.isHidden = false
        cell.filtroImg.image = cell.filtroImg.image?.withRenderingMode(.alwaysTemplate)
        cell.filtroImg.tintColor = blueColor
    }
    
    func categoriaCellDrawUnselected(cell: FiltroCell) {
        cell.filtroLabel.textColor = .black
        cell.filtroLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        cell.filtroTick.isHidden = true
        cell.filtroImg.tintColor = .black
    }
    
    func descuentoCellDrawSelected(cell: FiltroCell) {
        let blueColor = UIColor(red: 35/255, green: 107/255, blue: 167/255, alpha: 1.0)
        cell.filtroLabel.textColor = blueColor
        cell.filtroLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        cell.filtroTick.isHidden = false
    }
    
    func descuentoCellDrawUnselected(cell: FiltroCell) {
        cell.filtroLabel.textColor = .black
        cell.filtroLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        cell.filtroTick.isHidden = true
    }
    
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FiltroCell
        
        if cell.filtroTick.isHidden {
            
            var filterName = ""
            if tableView == categoriasTableView {
                let categoria = categorias[indexPath.row]
                filterName = categoria.nombre!
            } else {
                let descuento = descuentos[indexPath.row]
                filterName = descuento.nombre!
            }
            
            FirebaseAPI.addFilterUniquelyToDefaults(filterName: filterName)
            tableView.reloadRows(at: [indexPath], with: .none)
            
        } else {
            
            var filterName = ""
            if tableView == categoriasTableView {
                let categoria = categorias[indexPath.row]
                filterName = categoria.nombre!
            } else {
                let descuento = descuentos[indexPath.row]
                filterName = descuento.nombre!
            }
            
            FirebaseAPI.removeFilterIfExistsFromDefaults(filterName: filterName)
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    //MARK: - Screen
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
