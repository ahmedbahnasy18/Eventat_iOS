//
//  LastOrderTableViewCell.swift
//  Eventat
//
//  Created by SourceCode on 7/29/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit

class LastOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var orderID: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var deliveryDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
