//
//  FakeSplashViewController.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 1/2/17.
//  Copyright © 2017 Fernando N. Frassia. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class FakeSplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        checkFBLoggedIn()
    }

    func checkFBLoggedIn() {
        if (FBSDKAccessToken.current()) != nil {
            showMenuVC()
            FirebaseAPI.loadFirebaseData()
        }
    }
    
    func showMenuVC() {
        performSegue(withIdentifier: "MainSegue", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
