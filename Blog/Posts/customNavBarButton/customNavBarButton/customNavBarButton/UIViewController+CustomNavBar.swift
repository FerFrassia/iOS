//
//  UIViewController+CustomNavBar.swift
//  customNavBarButton
//
//  Created by Fernando N. Frassia on 9/23/18.
//  Copyright © 2018 Fernando N. Frassia. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func setRightBarButton(withNotificationTarget notificationTarget:Any?,
                           notificationAction:Selector,
                           filterTarget:Any?,
                           filterAction:Selector) {
        let customBarButton = CustomBarButtonView.instanteFromNib(notificationTarget: notificationTarget,
                                                                  notificationAction: notificationAction,
                                                                  filterTarget: filterTarget,
                                                                  filterAction: filterAction)
        let customBarButtonItem = UIBarButtonItem.init(customView: customBarButton)
        navigationItem.setRightBarButton(customBarButtonItem, animated: false)
    }
    
    func setTitle(_ text: String) {
        navigationItem.title = text
    }
}
