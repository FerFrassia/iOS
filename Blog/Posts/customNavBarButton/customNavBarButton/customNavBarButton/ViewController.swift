//
//  ViewController.swift
//  customNavBarButton
//
//  Created by Fernando N. Frassia on 9/23/18.
//  Copyright © 2018 Fernando N. Frassia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavBar()
    }
    
    func setNavBar() {
        setRightBarButton(withNotificationTarget: self,
                          notificationAction: #selector(ViewController.notificationPressed),
                          filterTarget: self,
                          filterAction: #selector(ViewController.filterPressed))
        setTitle("Our App")
    }
    
    @objc func notificationPressed() {
        print("notification pressed")
    }
    
    @objc func filterPressed() {
        print("filter pressed   ")
    }
}

