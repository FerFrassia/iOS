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
    
    let cellIdentifier = "postCell"
    var blackTheme = false
    var itemInfo = IndicatorInfo(title: "LALALA")
    var locales = [Local]()
    
    init(style: UITableViewStyle, itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "PostCell", bundle: Bundle.main), forCellReuseIdentifier: cellIdentifier)
//        tableView.estimatedRowHeight = 200.0;
//        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.allowsSelection = false
//        if blackTheme {
//            tableView.backgroundColor = UIColor(red: 15/255.0, green: 16/255.0, blue: 16/255.0, alpha: 1.0)
//        }
        
        loadLocales()
    }
    
    func loadLocales() {
        locales = FirebaseAPI.getCoreLocales()
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
        return locales.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PostCell
        
        cell.localName.text = locales[indexPath.row].nombre
        cell.localAddress.text = locales[indexPath.row].direccion
        
        let url = URL(string: locales[indexPath.row].imagenLogo!)
        cell.localImage.sd_setImage(with: url, placeholderImage: UIImage(named: "Profile Pic Placeholder"))
        
//        //colors
//        switch indexPath.row {
//        case 0:
//            cell.backgroundColor = UIColor.red
//        case 1:
//            cell.backgroundColor = UIColor.blue
//        case 2:
//            cell.backgroundColor = UIColor.gray
//        default:
//            cell.backgroundColor = UIColor.yellow
//        }
        
        return cell
    }
    
    // MARK: - IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}

