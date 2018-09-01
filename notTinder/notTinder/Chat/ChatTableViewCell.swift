//
//  ChatTableViewCell.swift
//  notTinder
//
//  Created by Fernando N. Frassia on 9/1/18.
//  Copyright © 2018 Fernando N. Frassia. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var chatLabel: UILabel!
    @IBOutlet weak var chatLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatLabelTrailingConstraint: NSLayoutConstraint!
    
    func setUI(with message: chatMessage) {
        chatLabel.text = message.message
        chatLabel.numberOfLines = 0
        
        chatLabelLeadingConstraint.priority = message.recieved ? UILayoutPriority(rawValue: 700) : UILayoutPriority(rawValue: 300)
        chatLabelTrailingConstraint.priority = message.recieved ? UILayoutPriority(rawValue:300) : UILayoutPriority(rawValue:700)
        self.layoutIfNeeded()
        
        chatLabel.backgroundColor = message.recieved ? UIColor.green : UIColor.white
        chatLabel.layer.cornerRadius = 5
        chatLabel.sizeToFit()
        
    }
    
}
