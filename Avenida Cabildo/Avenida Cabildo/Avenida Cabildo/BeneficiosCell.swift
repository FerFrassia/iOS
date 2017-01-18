//
//  BeneficiosCell.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 1/17/17.
//  Copyright © 2017 Fernando N. Frassia. All rights reserved.
//

import UIKit

class BeneficiosCell: UITableViewCell {
    
    @IBOutlet weak var beneficiosImage: UIImageView!
    @IBOutlet weak var beneficiosLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
