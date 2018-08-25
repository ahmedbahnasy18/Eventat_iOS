//
//  OpeningTimeTableViewController.swift
//  Eventat
//
//  Created by SourceCode on 7/30/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit

class OpeningTimeTableViewCell:      UITableViewCell {
@IBOutlet weak var date: UILabel!
@IBOutlet weak var from: UILabel!
    @IBOutlet weak var to: UILabel!


override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
}

override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
}

}
