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
    
    

}
