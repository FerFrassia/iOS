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
            
            
            localFavorite.isSelected = false
        } else {
            //need to favorite
            FirebaseAPI.addFavoriteToUserFirebase(localName: (localName.text)!)
            localFavorite.isSelected = true
        }
    }
    
    
//    func configureWithData(_ data: NSDictionary){
//        if let post = data["post"] as? NSDictionary, let user = post["user"] as? NSDictionary {
//            postName.text = user["name"] as? String
//            postText.text = post["text"] as? String
//            userImage.image = UIImage(named: postName.text!.replacingOccurrences(of: " ", with: "_"))
//        }
//    }
//    
//    
//    func changeStylToBlack(){
//        userImage?.layer.cornerRadius = 30.0
//        postText.text = nil
//        postName.font = UIFont(name: "HelveticaNeue-Light", size:18) ?? .systemFont(ofSize: 18)
//        postName.textColor = .white
//        backgroundColor = UIColor(red: 15/255.0, green: 16/255.0, blue: 16/255.0, alpha: 1.0)
//    }
}
