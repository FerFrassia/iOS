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
import CoreData

class Login: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var loginButtonFB: UIButton?
    @IBOutlet weak var loginButtonGL: UIButton?
    @IBOutlet weak var loginImgGL: UIImageView?
    @IBOutlet weak var loginImgGlLeading: NSLayoutConstraint!
    @IBOutlet weak var loginImgGLWidth: NSLayoutConstraint!
    @IBOutlet weak var FBWidth: NSLayoutConstraint!
    @IBOutlet weak var FBIconWidth: NSLayoutConstraint!
    @IBOutlet weak var GLIconWidth: NSLayoutConstraint!
    @IBOutlet weak var FBImage: UIImageView!
    
    let moc = DataController().managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLoginFB()
        setLoginGoogle()
//        seedUser()
//        fetch()
    }
    
    func fetch() {
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
        do {
            let fetchedUser = try moc.fetch(userFetch) as! [Usuario]
            print("USERRRRR: ", fetchedUser.first?.name ?? "")
        } catch {
            fatalError("Can't fetch user: \(error)")
        }
    }
    
    func seedUser() {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Usuario", into: moc) as! Usuario
        
        entity.setValue("Juancito", forKey: "name")
        
        do {
            try moc.save()
        } catch {
            fatalError("failed to save context: \(error)")
        }
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
        FBImage.image = UIImage(named: "Login Facebook Icon")?.withRenderingMode(.alwaysTemplate)
        FBImage.tintColor = .white
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
        setGLImage()
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    func setGLImage() {
        loginImgGL?.image = UIImage(named: "Login Google Icon")?.withRenderingMode(.alwaysTemplate)
        loginImgGL?.tintColor = .white
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
                        self.fetchProfile()
                        self.showMenuVC()
                        self.signInFirebaseWithFB()
                        FirebaseAPI.loadFirebaseUserData()
                    }
                    
                }
        })
    }
    
    func signInFirebaseWithFB() {
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else {return}
        let credentials = FIRFacebookAuthProvider.credential(withAccessToken: accessTokenString)
        FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
            if error != nil {
                 print("FB Firebase Login Failed: \(error)")
                return
            }
            print("Accessed FB Firebase with user: \(user)")
            FirebaseAPI.storeCoreUser()
            
        })
    }
    
    func fetchProfile() {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.loginBehavior = FBSDKLoginBehavior.web
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) -> Void in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else if (result?.isCancelled)! {
                print("Cancelled")
            } else {
                if let userId = result?.token.userID {
                    UserDefaults.standard.setValue(userId, forKey: "fbToken")
                    FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name, email"]).start(completionHandler: { (connection, result, error) -> Void in
                        if (error == nil) {
                            if let res = result as? [String:Any] {
                                UserDefaults.standard.setValue(res["name"], forKey: "fbName")
                                UserDefaults.standard.setValue(res["email"], forKey: "fbEmail")
                            }
                        }
                    })
                }
            }
        }
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

