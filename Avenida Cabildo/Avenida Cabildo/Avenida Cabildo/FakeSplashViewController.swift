//
//  FakeSplashViewController.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 1/2/17.
//  Copyright © 2017 Fernando N. Frassia. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class FakeSplashViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        if FirebaseAPI.isUserLoggedInFirebase() {
            showMenuVC()
        } else {
            showLoginVC()
        }
    }
    
    func showMenuVC() {
        UIApplication.shared.statusBarStyle = .default
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "MainSegue", sender: nil)
        }
    }
    
    func showLoginVC() {
        UIApplication.shared.statusBarStyle = .lightContent
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "LoginSegue", sender: nil)
        }
    }

}
