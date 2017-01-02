//
//  ViewController.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 12/21/16.
//  Copyright © 2016 Fernando N. Frassia. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn
import Firebase

class Login: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var loginButtonFB: UIButton?
    @IBOutlet weak var loginButtonGL: UIButton?
    @IBOutlet weak var loginImgGL: UIImageView?
    @IBOutlet weak var loginImgGlLeading: NSLayoutConstraint!
    @IBOutlet weak var loginImgGLWidth: NSLayoutConstraint!
    @IBOutlet weak var FBWidth: NSLayoutConstraint!
    @IBOutlet weak var FBIconWidth: NSLayoutConstraint!
    @IBOutlet weak var GLIconWidth: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLoginFB()
        setLoginGoogle()
    }
    
    func setLoginFB() {
        setFBCorners()
        setFBWidth()
        setFBTitle()
        setFBImage()
    }
    
    func setFBCorners() {
        loginButtonFB!.layer.cornerRadius = 25
    }
    
    func setFBTitle() {
        //iphone 5
        if UIDevice.current.userInterfaceIdiom == .phone && max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) == 568.0 {
            let attributes1 = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 14)]
            let attributes2 = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 14)]
            
            let part1 = NSMutableAttributedString(string: "          INGRESA CON ", attributes: attributes1)
            let part2 = NSMutableAttributedString(string: "FACEBOOK  ", attributes: attributes2)
            
            let combination = NSMutableAttributedString()
            
            combination.append(part1)
            combination.append(part2)
            
            loginButtonFB!.setAttributedTitle(combination, for: .normal)
        }
    }
    
    func setFBImage() {
        //iphone 5
        if UIDevice.current.userInterfaceIdiom == .phone && max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) == 568.0 {
            FBIconWidth.constant = 25
        }
    }
    
    func setFBWidth() {
        //iphone 5
        if UIDevice.current.userInterfaceIdiom == .phone && max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) == 568.0 {
            FBWidth.constant = 255
        }
    }
    
    func setLoginGoogle() {
        setGLCorners()
        setLoginImgGLFrame()
        setLoginGLTitle()
        setLoginGLWidth()
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    
    func setLoginImgGLFrame() {
        //iphone 5
        if UIDevice.current.userInterfaceIdiom == .phone && max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) == 568.0 {
            loginImgGlLeading.constant = -47
            GLIconWidth.constant = 25
        }
    }
    
    func setLoginGLTitle() {
        //iphone 5
        if UIDevice.current.userInterfaceIdiom == .phone && max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) == 568.0 {
            
            let attributes1 = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 14)]
            let attributes2 = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 14)]
            
            let part1 = NSMutableAttributedString(string: "     INGRESA CON ", attributes: attributes1)
            let part2 = NSMutableAttributedString(string: "GOOGLE  ", attributes: attributes2)
            
            let combination = NSMutableAttributedString()
            
            combination.append(part1)
            combination.append(part2)
            
            loginButtonGL!.setAttributedTitle(combination, for: .normal)
            
        }
    }
    
    func setLoginGLWidth() {
        if UIDevice.current.userInterfaceIdiom == .phone && max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) == 568.0 {
            loginImgGLWidth.constant = 255
        }
    }
    
    func setGLCorners() {
        loginButtonGL!.layer.cornerRadius = 25
    }
    
    @IBAction func loginActionFB() {
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self, handler:
            { (result, err) in
                if err != nil {
                    print("FB Login Failed: ", err ?? "Error is nil")
                    
                } else {
                    if (result?.isCancelled)! {
                       return
                    } else {
                        print("FB Login Success: ", result?.token.tokenString ?? "Result token is nil")
                        self.fetchProfile()
                        self.showMenuVC()
                    }
                    
                }
        })
    }
    
    func fetchProfile() {
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields" : "email, name, public_profile"])
            .start(completionHandler:  { (connection, result, error) in
                guard let result = result as? NSDictionary,
                    let email = result["email"] as? String,
                    let user_name = result["name"] as? String,
                    let user_gender = result["gender"] as? String,
                    let user_id_fb = result["id"]  as? String else {
                        return
                }
                print("got it")
            })
    }
    
    @IBAction func showMenuVC() {
        UIApplication.shared.statusBarStyle = .default
        performSegue(withIdentifier: "MainSegue", sender: self)
    }
    
    @IBAction func loginActionGoogle() {
        GIDSignIn.sharedInstance().signIn()
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

