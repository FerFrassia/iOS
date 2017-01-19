//
//  PromocionLocalView.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 1/12/17.
//  Copyright © 2017 Fernando N. Frassia. All rights reserved.
//

import UIKit

class PromocionLocalView: UIView {

    @IBOutlet weak var localBackground: UIImageView!
    @IBOutlet weak var localDescuento: UIImageView!
    @IBOutlet weak var localName: UILabel!
    @IBOutlet weak var localAddress: UILabel!
    @IBOutlet weak var localShare: UIButton!
    @IBOutlet weak var localFavorite: UIButton!
    @IBOutlet weak var localDescription: UILabel!
    @IBOutlet weak var localVerMas: UIButton!
    
    @IBAction func favoritePressed(sender: UIButton) {
        if localFavorite.isSelected {
            //need to unfavorite
            FirebaseAPI.removeFavoriteFromUserFirebase(localName: (localName.text)!)
            localFavorite.isSelected = false
        } else {
            //need to favorite
            FirebaseAPI.addFavoriteToUserFirebase(localName: (localName.text)!)
            localFavorite.isSelected = true
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

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "PromocionLocalView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! PromocionLocalView
    }

}
