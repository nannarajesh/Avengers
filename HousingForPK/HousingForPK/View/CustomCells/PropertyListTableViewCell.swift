//
//  PropertyListTableViewCell.swift
//  HousingForPK
//
//  Created by Administrator on 25/04/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

import UIKit

class PropertyListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var imgBackground: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
