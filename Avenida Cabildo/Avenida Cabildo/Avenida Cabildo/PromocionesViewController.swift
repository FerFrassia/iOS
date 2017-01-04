//
//  PromocionesViewController.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 1/4/17.
//  Copyright © 2017 Fernando N. Frassia. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class PromocionesViewController: UIViewController, IndicatorInfoProvider {

    var itemInfo = IndicatorInfo(title: "View")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
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
