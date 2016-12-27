//
//  ViewController.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 12/21/16.
//  Copyright © 2016 Fernando N. Frassia. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var loginButtonFB: UIButton?
    @IBOutlet weak var loginButtonGL: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()

        setFBCorners()
        setGLCorners()
        
    }
    
    func setFBCorners() {
        loginButtonFB!.layer.cornerRadius = 25
    }
    
    func setGLCorners() {
        loginButtonGL!.layer.cornerRadius = 25
    }
    
    @IBAction func loginActionFB() {
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "email"], from: self, handler:
            { (result, err) in
                if err != nil {
                    print("FB Login Failed: ", err ?? "Error is nil")
                } else {
                    print("FB Login Success: ", result?.token.tokenString ?? "Result token is nil")
                }
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logged out of Facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
        } else {
            print("Logged in to Facebook")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

