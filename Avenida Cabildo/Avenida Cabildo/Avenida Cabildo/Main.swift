//
//  Main.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 12/30/16.
//  Copyright © 2016 Fernando N. Frassia. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import SWRevealViewController
import XLPagerTabStrip

class Main: BarPagerTabStripViewController {

    @IBOutlet weak var revealMenuButton: UIBarButtonItem!
    @IBOutlet weak var buttonBarView: ButtonBarView!
    
    @IBAction func LogOutAction(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        try! FIRAuth.auth()!.signOut()
        showLoginViewController()
    }
    
    func showLoginViewController() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let controller = storyboard.instantiateInitialViewController()
        self.present(controller!, animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setRevealMenuButton()
    
    }
    
    func setRevealMenuButton() {
        revealMenuButton.target = self.revealViewController()
        revealMenuButton.action = Selector(("revealToggle:"))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    //MARK: XLPager
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let child1 = PromocionesViewController(style: .plain, itemInfo: IndicatorInfo(title: " HOME"))
        let child2 = PromocionesViewController(style: .plain, itemInfo: IndicatorInfo(title: " HOME"))
        
        return [child1, child2]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
