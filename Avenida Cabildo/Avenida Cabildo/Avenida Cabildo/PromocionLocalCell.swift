//
//  PromocionLocalCell.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 2/4/17.
//  Copyright © 2017 Fernando N. Frassia. All rights reserved.
//

import UIKit

class PromocionLocalCell: UICollectionViewCell {
    
    @IBOutlet weak var localBackground: UIImageView!
    @IBOutlet weak var localDescuento: UIImageView!
    @IBOutlet weak var localName: UILabel!
    @IBOutlet weak var localAddress: UILabel!
    @IBOutlet weak var localShare: UIButton!
    @IBOutlet weak var localFavorite: UIButton!
    @IBOutlet weak var localDescription: UILabel!
    @IBOutlet weak var localVerMas: UIButton!
    
    @IBOutlet weak var tarjeta1: UIImageView!
    @IBOutlet weak var tarjeta2: UIImageView!
    @IBOutlet weak var tarjeta3: UIImageView!
    @IBOutlet weak var tarjeta4: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func favoritePressed(sender: UIButton) {
        if FirebaseAPI.isUserLoggedInFirebase() {
            if localFavorite.isSelected {
                //need to unfavorite
                localFavorite.isSelected = false
                FirebaseAPI.removeFavorite(name: (localName.text)!)
            } else {
                //need to favorite
                localFavorite.isSelected = true
                FirebaseAPI.addFavorite(name: (localName.text)!)
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
    
    @IBAction func verMasPressed(sender: UIButton) {
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil) {
            topVC = topVC!.presentedViewController
        }
        
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "LocalSelectedViewController") as! LocalSelectedViewController
        topVC?.present(vc, animated: true, completion: nil)
    }

}
