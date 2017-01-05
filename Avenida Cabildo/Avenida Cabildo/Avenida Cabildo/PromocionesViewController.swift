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
    
    let cellIdentifier = "postCell"
    var blackTheme = false
    var itemInfo = IndicatorInfo(title: "LALALA")
    
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
        tableView.estimatedRowHeight = 60.0;
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.allowsSelection = false
        if blackTheme {
            tableView.backgroundColor = UIColor(red: 15/255.0, green: 16/255.0, blue: 16/255.0, alpha: 1.0)
        }
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
        return DataProvider.sharedInstance.postsData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PostCell
        let data = DataProvider.sharedInstance.postsData.object(at: indexPath.row) as!
        NSDictionary
        cell.configureWithData(data)
        if blackTheme {
            cell.changeStylToBlack()
        }
        return cell
    }
    
    // MARK: - IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}
