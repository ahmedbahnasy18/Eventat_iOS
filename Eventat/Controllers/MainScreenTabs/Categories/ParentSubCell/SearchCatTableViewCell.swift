//
//  SearchCatTableViewCell.swift
//  Eventat
//
//  Created by SourceCode on 7/30/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit

class SearchCatTableViewCell: UITableViewCell {

    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productCost: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var heartImg: UIImageView!
    
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var cartImg: UIImageView!
    
    @IBOutlet weak var cosmoRateView: CosmosView!
    
    @IBOutlet weak var rateBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
