//
//  CartTableViewCell.swift
//  Eventat
//
//  Created by SourceCode on 7/31/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var cartImg: UIImageView!
    
    @IBOutlet weak var productNAme: UILabel!
    
    @IBOutlet weak var productCost: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
