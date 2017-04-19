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
        if let web = local?.web {
            if let name = local?.nombre {
                var topVC = UIApplication.shared.keyWindow?.rootViewController
                while((topVC!.presentedViewController) != nil) {
                    topVC = topVC!.presentedViewController
                }
                let stringToShare = FirebaseAPI.shareLocal(name: name, web: web)
                let activityViewController = UIActivityViewController(activityItems: [stringToShare], applicationActivities: nil)
                topVC?.present(activityViewController, animated: true, completion: nil)
            }
        }
    }
    
    

}
