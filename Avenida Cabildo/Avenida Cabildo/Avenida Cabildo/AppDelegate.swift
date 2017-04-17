//
//  AppDelegate.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 12/21/16.
//  Copyright © 2016 Fernando N. Frassia. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FIRApp.configure()
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        //Google Sign In
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().signInSilently()
        
        //Google Maps
        GMSServices.provideAPIKey("AIzaSyDjID78dt3Y5O02zS3Lr_aaGUdDzuGc47g")
        
        DispatchQueue(label: "com.queue.Concurrent", attributes: .concurrent).async {
            FirebaseAPI.loadFirebaseCommonData()
            FirebaseAPI.loadFirebaseUserData()
        }
                
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app,
                                                                            open: url,
                                                                            sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!,
                                                                            annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!,
                                                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        return handled
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let err = error {
            print("Failed to log into Google: ", err)
            self.showLoginVC()
            return
        }
        print("Google log in Success, user: ", user)
        UserDefaults.standard.setValue(user.profile.name, forKey: "GoogleName")
        UserDefaults.standard.setValue(user.profile.email, forKey: "GoogleEmail")
        
        if user.profile.hasImage {
            let imgUrl = user.profile.imageURL(withDimension: 100)
            let imgString = imgUrl?.absoluteString
            UserDefaults.standard.setValue(imgString, forKey: "GoogleImg")
        }
        
        guard let authentication = user.authentication else { return }
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if let err = error {
                print("Failed to create a Firebase User with Google Account: ", err)
                self.showLoginVC()
                return
            }
            guard let uid = user?.uid else {return}
            print("Successfully logged into Firebase with Google Account: ", uid)
            FirebaseAPI.loadFirebaseUserData()
            FirebaseAPI.loadFirebaseCommonData()
            self.showMenuVC()
        })
    }
    
    func showMenuVC() {
//        UIApplication.shared.statusBarStyle = .default
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let fakeVC = storyboard.instantiateViewController(withIdentifier: "Fake") as? FakeSplashViewController
//        fakeVC?.openMenu = true
//        window!.rootViewController = fakeVC
        NotificationCenter.default.post(name: Notification.Name(rawValue: openMenuKey), object: nil)
    }
    
    func showLoginVC() {
//        UIApplication.shared.statusBarStyle = .default
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let fakeVC = storyboard.instantiateViewController(withIdentifier: "Fake") as? FakeSplashViewController
//        fakeVC?.openLogin = true
//        window!.rootViewController = fakeVC
        NotificationCenter.default.post(name: Notification.Name(rawValue: openLoginKey), object: nil)
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                withError error: NSError!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        FirebaseAPI.loadFirebaseUserData()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Avenida_Cabildo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

