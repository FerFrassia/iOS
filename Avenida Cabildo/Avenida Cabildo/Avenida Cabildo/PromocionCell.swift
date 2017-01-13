//
//  PromocionCell.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 1/11/17.
//  Copyright © 2017 Fernando N. Frassia. All rights reserved.
//

import UIKit
import GoogleMaps

class PromocionCell: UITableViewCell {

    
    @IBOutlet weak var promocionScrollView: UIScrollView!
    @IBOutlet weak var promocionMapView: GMSMapView!
    @IBOutlet weak var promocionHorizontalScroll: UIScrollView!
    @IBOutlet weak var categoriaBlue: UIView!
    @IBOutlet weak var categoriaWhite: UIView!
    @IBOutlet weak var categoriaImg: UIImageView!
    @IBOutlet weak var categoriaButton: UIButton!
    
    
    @IBAction func categoryPressed(_ sender: Any) {
        //TODO
//        var topVC = UIApplication.shared.keyWindow?.rootViewController
//        while((topVC!.presentedViewController) != nil) {
//            topVC = topVC!.presentedViewController
//        }
//        
//        let story = UIStoryboard(name: "Main", bundle: nil)
//        let vc = story.instantiateViewController(withIdentifier: "ChangeCategory") as! ChangeCategoryTableViewController
//        topVC?.present(vc, animated: true, completion: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
