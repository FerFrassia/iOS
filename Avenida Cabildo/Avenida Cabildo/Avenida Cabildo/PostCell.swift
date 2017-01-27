//
//  PostCell.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 1/5/17.
//  Copyright © 2017 Fernando N. Frassia. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var localImage: UIImageView!
    @IBOutlet weak var localName: UILabel!
    @IBOutlet weak var localAddress: UILabel!
    @IBOutlet weak var localDiscount: UILabel!
    @IBOutlet weak var localShare: UIButton!
    @IBOutlet weak var localFavorite: UIButton!
    
    @IBAction func favoritePressed(sender: UIButton) {
        if localFavorite.isSelected {
            //need to unfavorite
            FirebaseAPI.removeFavorite(name: (localName.text)!)
            localFavorite.isSelected = false
        } else {
            //need to favorite
            FirebaseAPI.addFavorite(name: (localName.text)!)
            localFavorite.isSelected = true
        }
    }
    
    @IBAction func sharePressed(sender: UIButton) {
        let local = FirebaseAPI.getCoreLocal(name: (localName.text)!)
        let shareView = Bundle.main.loadNibNamed("ShareView", owner: nil, options: nil)?[0] as! ShareView
        shareView.selectedLocal = local
        shareView.layer.cornerRadius = 15
        shareView.blackContainer.layer.cornerRadius = 15
        shareView.whiteContainer.layer.cornerRadius = 15
        
        let x = CGFloat(40)
        let width = CGFloat(UIScreen.main.bounds.width - 80)
        let y = CGFloat(UIScreen.main.bounds.height/2 - 125)
        let height = CGFloat(250)
        shareView.frame = CGRect(x: x, y: y, width: width, height: height)
        
        UIApplication.shared.keyWindow?.addSubview(shareView)
    }
    
    

}
