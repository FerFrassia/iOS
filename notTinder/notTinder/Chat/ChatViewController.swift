//
//  chatViewController.swift
//  notTinder
//
//  Created by Fernando N. Frassia on 8/30/18.
//  Copyright © 2018 Fernando N. Frassia. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint?
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint?
    
    var messages = [chatMessage(message: "short message", recieved: true),
                    chatMessage(message: "bla bla bla bla bla bla bla bla bla bla bla bla bla medium message", recieved: true),
                    chatMessage(message: "bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla large message", recieved: false),
                    chatMessage(message: "bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla really large message", recieved: false),
                    
    ];
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Messages"
        navigationController?.navigationBar.prefersLargeTitles = true
        chatTableView.register(UINib(nibName: chatTableViewCell, bundle: nil), forCellReuseIdentifier: chatTableViewCell)
    }

    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: chatTableViewCell) as! ChatTableViewCell
        cell.setUI(with: messages[indexPath.row])
        return cell
    }
    

}
