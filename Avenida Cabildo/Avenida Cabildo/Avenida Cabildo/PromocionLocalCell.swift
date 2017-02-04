//
//  PromocionLocalCell.swift
//  Avenida Cabildo
//
//  Created by Fernando N. Frassia on 2/4/17.
//  Copyright © 2017 Fernando N. Frassia. All rights reserved.
//

import UIKit

class PromocionLocalCell: UICollectionViewCell {
    
    @IBOutlet weak var localBackground: UIImageView!
    @IBOutlet weak var localDescuento: UIImageView!
    @IBOutlet weak var localName: UILabel!
    @IBOutlet weak var localAddress: UILabel!
    @IBOutlet weak var localShare: UIButton!
    @IBOutlet weak var localFavorite: UIButton!
    @IBOutlet weak var localDescription: UILabel!
    @IBOutlet weak var localVerMas: UIButton!
    
    @IBOutlet weak var tarjeta1: UIImageView!
    @IBOutlet weak var tarjeta2: UIImageView!
    @IBOutlet weak var tarjeta3: UIImageView!
    @IBOutlet weak var tarjeta4: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
