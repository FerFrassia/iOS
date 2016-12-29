//
//  ViewController.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 12/21/16.
//  Copyright © 2016 Fernando N. Frassia. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class Login: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var loginButtonFB: UIButton?
    @IBOutlet weak var loginButtonGL: UIButton?
    @IBOutlet weak var loginImgGL: UIImageView?
    @IBOutlet weak var loginImgGlLeading: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setFBCorners()
        setGLCorners()
        setLoginImgGLFrame()
        setLoginGLTitle()
        
    }
    
    func setLoginImgGLFrame() {
        //iphone 5
        if UIDevice.current.userInterfaceIdiom == .phone && max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) == 568.0 {
            loginImgGlLeading.constant = -38
        }
    }
    
    func setLoginGLTitle() {
        //iphone 5
        if UIDevice.current.userInterfaceIdiom == .phone && max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) == 568.0 {
            
            let ingresaString = "INGRESA CON "
            let atribute1 = [NSFontAttributeName: UIFont(name: "Chalkduster", size: 15)]
            let ingresaAtribute = NSAttributedString(string: ingresaString, attributes: atribute1)
            
            loginButtonGL!.titleLabel!.text = ingresaString
            
        }
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

