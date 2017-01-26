//
//  Local3.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 1/11/17.
//  Copyright © 2017 Fernando N. Frassia. All rights reserved.
//

import UIKit

class Local3: UITableViewCell {

    @IBOutlet weak var localImage: UIImageView!
    @IBOutlet weak var localName: UILabel!
    @IBOutlet weak var localAddress: UILabel!
    @IBOutlet weak var localShare: UIButton!
    @IBOutlet weak var localFavorite: UIButton!
    @IBOutlet weak var localBackgroundImage: UIImageView!
    @IBOutlet weak var localDescuento: UIImageView!
    
    @IBOutlet weak var tarjeta1: UIImageView!
    @IBOutlet weak var tarjeta2: UIImageView!
    @IBOutlet weak var tarjeta3: UIImageView!
    @IBOutlet weak var tarjeta4: UIImageView!
    
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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
