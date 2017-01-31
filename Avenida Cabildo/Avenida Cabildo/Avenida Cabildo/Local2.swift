//
//  Local2.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 1/10/17.
//  Copyright © 2017 Fernando N. Frassia. All rights reserved.
//

import UIKit

class Local2: UITableViewCell {

    @IBOutlet weak var localImage: UIImageView!
    @IBOutlet weak var localName: UILabel!
    @IBOutlet weak var localAddress: UILabel!
    @IBOutlet weak var localDiscount: UILabel!
    @IBOutlet weak var localShare: UIButton!
    @IBOutlet weak var localFavorite: UIButton!
    @IBOutlet weak var localBackgroundImage: UIImageView!
    
    @IBOutlet weak var tarjeta1: UIImageView!
    @IBOutlet weak var tarjeta2: UIImageView!
    @IBOutlet weak var tarjeta3: UIImageView!
    @IBOutlet weak var tarjeta4: UIImageView!
    
    @IBAction func favoritePressed(sender: UIButton) {
        if FirebaseAPI.isUserLoggedInFirebase() {
            if localFavorite.isSelected {
                //need to unfavorite
                FirebaseAPI.removeFavorite(name: (localName.text)!)
                localFavorite.isSelected = false
            } else {
                //need to favorite
                FirebaseAPI.addFavorite(name: (localName.text)!)
                localFavorite.isSelected = true
            }
        } else {
            alertLoginFav()
        }
    }
    
    func alertLoginFav() {
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil) {
            topVC = topVC!.presentedViewController
        }
        
        let alert = UIAlertController(title: "", message: "Para utilizar Favoritos debe loguearse", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
        })
        topVC?.present(alert, animated: true, completion: nil)
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
