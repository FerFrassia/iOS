//
//  customBarButtonView.swift
//  customNavBarButton
//
//  Created by Fernando N. Frassia on 9/23/18.
//  Copyright © 2018 Fernando N. Frassia. All rights reserved.
//

import UIKit

class CustomBarButtonView: UIView {
    
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    
    class func instanteFromNib(notificationTarget:Any?,
                               notificationAction:Selector,
                               filterTarget:Any?,
                               filterAction:Selector) -> CustomBarButtonView {
        let customView = UINib(nibName: "CustomBarButtonView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CustomBarButtonView
        
        customView.widthAnchor.constraint(equalToConstant: 130).isActive = true
        customView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        customView.notificationBtn.addTarget(notificationTarget, action: notificationAction, for: .touchDown)
        customView.filterBtn.addTarget(filterTarget, action: filterAction, for: .touchDown)
        
        return customView
    }

}
