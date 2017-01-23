//
//  DetalleCell.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 1/20/17.
//  Copyright © 2017 Fernando N. Frassia. All rights reserved.
//

import UIKit

class DetalleCell: UITableViewCell {
    
    @IBOutlet weak var detalleImage: UIImageView!
    @IBOutlet weak var detalleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
