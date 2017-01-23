//
//  FiltroCell.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 1/23/17.
//  Copyright © 2017 Fernando N. Frassia. All rights reserved.
//

import UIKit

class FiltroCell: UITableViewCell {

    @IBOutlet weak var filtroImg: UIImageView!
    @IBOutlet weak var filtroLabel: UILabel!
    @IBOutlet weak var filtroTick: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
