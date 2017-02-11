//
//  FakeSplashViewController.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 1/2/17.
//  Copyright © 2017 Fernando N. Frassia. All rights reserved.
//

import UIKit
import FirebaseAuth

class FakeSplashViewController: UIViewController {
    
    var openLogin = false
    var openMenu = false
    
    override func viewWillAppear(_ animated: Bool) {
        if openLogin {
            showLoginVC()
        }
        
        if openMenu {
            showMenuVC()
        }
    }
    
    func showMenuVC() {
        UIApplication.shared.statusBarStyle = .default
        DispatchQueue(label: "com.queue.Concurrent", attributes: .concurrent).async {
            self.performSegue(withIdentifier: "MainSegue", sender: nil)
        }
    }
    
    func showLoginVC() {
        UIApplication.shared.statusBarStyle = .lightContent
        DispatchQueue(label: "com.queue.Concurrent", attributes: .concurrent).async {
            self.performSegue(withIdentifier: "LoginSegue", sender: nil)
        }
    }
    

}
