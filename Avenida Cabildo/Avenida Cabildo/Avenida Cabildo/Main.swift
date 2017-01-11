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

class Main: ButtonBarPagerTabStripViewController {

    @IBOutlet weak var revealMenuButton: UIBarButtonItem!

    let graySpotifyColor = UIColor(red: 21/255.0, green: 21/255.0, blue: 24/255.0, alpha: 1.0)
    let darkGraySpotifyColor = UIColor(red: 19/255.0, green: 20/255.0, blue: 20/255.0, alpha: 1.0)
    
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
        
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = UIColor(red: 33/255.0, green: 174/255.0, blue: 67/255.0, alpha: 1.0)
        settings.style.buttonBarItemFont = UIFont(name: "HelveticaNeue-Light", size:14) ?? UIFont.systemFont(ofSize: 14)
        settings.style.selectedBarHeight = 3.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        
        settings.style.buttonBarLeftContentInset = 20
        settings.style.buttonBarRightContentInset = 20
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            
            oldCell?.label.textColor = .gray
            oldCell?.label.font = UIFont(name: "HelveticaNeue-Light", size: 14) ?? UIFont.systemFont(ofSize: 5)
            
            newCell?.label.textColor = .black
            newCell?.label.font = UIFont(name: "HelveticaNeue", size: 16) ?? UIFont.systemFont(ofSize: 5)
        }
    }

    
    func setRevealMenuButton() {
        revealMenuButton.target = self.revealViewController()
        revealMenuButton.action = Selector(("revealToggle:"))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    //MARK: Pager Tab Strip DataSource
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = PromocionesViewController(style: .plain, itemInfo: IndicatorInfo(title: "PROMOCIONES"))
        let child_2 = TodosViewController(style: .plain, itemInfo: IndicatorInfo(title: "TODOS"))
        return [child_1, child_2]
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
