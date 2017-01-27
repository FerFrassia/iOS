//
//  ShareView.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 1/27/17.
//  Copyright © 2017 Fernando N. Frassia. All rights reserved.
//

import UIKit
import Social

class ShareView: UIView {

    var selectedLocal = Local()
    @IBOutlet weak var blackContainer: UIView!
    @IBOutlet weak var whiteContainer: UIView!
    
    func setShareView() {
        self.layer.cornerRadius = 15
    }
    
    func showShareView() {
        self.isHidden = false
    }
    
    func hideShareView() {
        self.isHidden = true
    }
    
    @IBAction func fbShareAction(_ sender: Any) {
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil) {
            topVC = topVC!.presentedViewController
        }
        
        if let s = selectedLocal.facebook {
            let url = URL(string: s)!
            let facebookComposer = SLComposeViewController.init(forServiceType: SLServiceTypeFacebook)
            facebookComposer?.add(url)
            topVC?.present(facebookComposer!, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "", message: "Este local no posee Facebook", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
            })
            topVC?.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func instagramShareAction(_ sender: Any) {
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil) {
            topVC = topVC!.presentedViewController
        }
        
        if let s = selectedLocal.instagram {
            let url = URL(string: s)!
            let facebookComposer = SLComposeViewController.init(forServiceType: SLServiceTypeFacebook)
            facebookComposer?.add(url)
            topVC?.present(facebookComposer!, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "", message: "Este local no posee Instagram", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
            })
            topVC?.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func copyShareAction(_ sender: Any) {
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil) {
            topVC = topVC!.presentedViewController
        }
        
        if let s = selectedLocal.web {
            UIPasteboard.general.string = s
            let alert = UIAlertController(title: "", message: "Enlace copiado", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
            })
            topVC?.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "", message: "Este local no posee enlace web", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
            })
            topVC?.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelarShareAction(_ sender: Any) {
        hideShareView()
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "ShareView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ShareView
    }

}
