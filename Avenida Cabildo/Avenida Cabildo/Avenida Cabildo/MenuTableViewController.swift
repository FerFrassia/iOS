//
//  MenuTableViewController.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 12/31/16.
//  Copyright © 2016 Fernando N. Frassia. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class MenuTableViewController: UITableViewController {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.backgroundView = UIImageView(image: UIImage(named: "Login Background"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setProfilePicture()
        setFBName()
        setFBEmail()
    }
    
    func setProfilePicture() {
        getUserPicture()
        setRoundProfilePicture()
    }
    
    func setRoundProfilePicture() {
        profilePic.clipsToBounds = true
        profilePic.layer.cornerRadius = profilePic.frame.size.width/2
    }
    
    func setFBName() {
        if let FBName = UserDefaults.standard.string(forKey: "fbName") {
            userName.text = FBName
        } else if let googleName = UserDefaults.standard.string(forKey: "GoogleName") {
            userName.text = googleName
        }
    }
    
    func setFBEmail() {
        if let FBEmail = UserDefaults.standard.string(forKey: "fbEmail") {
            userEmail.text = FBEmail
        } else if let googleEmail = UserDefaults.standard.string(forKey: "GoogleEmail") {
            userEmail.text = googleEmail
        }
    }
    
    func getUserPicture() {
        if let userID = UserDefaults.standard.string(forKey: "fbToken") {
            let fbProfileString = "https://graph.facebook.com/\(userID)/picture?type=large"
            let url = URL(string: fbProfileString)
            profilePic.sd_setImage(with: url, placeholderImage: UIImage(named: "Profile Pic Placeholder"))
        } else if let googleImg = UserDefaults.standard.string(forKey: "GoogleImg") {
            let url = URL(string: googleImg)
            profilePic.sd_setImage(with: url, placeholderImage: UIImage(named: "Profile Pic Placeholder"))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 6
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuTableViewCell
        
        cell.backgroundColor = UIColor(red: 38/255, green: 57/255, blue: 78/255, alpha: 0.9)
        
        if indexPath.section == 0 {
            cell.cellLabel.text = "Favoritos"
            cell.cellImage.image = UIImage(named: "Star Menu")
        } else {
            cell.cellLabel.text = "Cerrar Sesión"
            cell.cellImage.image = UIImage(named: "Cerrar Menu")
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            openFavorites()
        } else {
            logOutAll()
        }
    }
    
    func openFavorites() {
        if FirebaseAPI.isUserLoggedInFirebase() {
            let story = UIStoryboard(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(withIdentifier: "FavoritosViewController") as! FavoritosViewController
            self.present(vc, animated: true, completion: nil)
        } else {
            alertLoginFav()
        }
    }
    
    func alertLoginFav() {
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil) {
            topVC = topVC!.presentedViewController
        }
        
        let alert = UIAlertController(title: "", message: "Para utilizar Favoritos debe loguearse", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
        })
        topVC?.present(alert, animated: true, completion: nil)
    }
    
    func logOutAll() {
        logOutGoogle()
        logOutFB()
        setEmptyFavorites()
        FirebaseAPI.signOutFirebase()
        showLoginViewController()
    }
    
    func logOutGoogle() {
        GIDSignIn.sharedInstance().signOut()
        try! FIRAuth.auth()!.signOut()
        UserDefaults.standard.removeObject(forKey: "GoogleName")
        UserDefaults.standard.removeObject(forKey: "GoogleEmail")
        UserDefaults.standard.removeObject(forKey: "GoogleImg")
    }
    
    func logOutFB() {
        FBSDKLoginManager().logOut()
        UserDefaults.standard.removeObject(forKey: "fbName")
        UserDefaults.standard.removeObject(forKey: "fbEmail")
        UserDefaults.standard.removeObject(forKey: "fbToken")
    }
    
    func showLoginViewController() {
        UIApplication.shared.statusBarStyle = .lightContent
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Login")
        self.present(controller, animated: false, completion: nil)
    }
    
    func setEmptyFavorites() {
        UserDefaults.standard.set([], forKey: "favoritos")
    }
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
