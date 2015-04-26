//
//  MasterTableViewCell.swift
//  Housing4PK
//
//  Created by Administrator on 25/04/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

import UIKit

class MasterTableViewCell: UITableViewCell {

    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var imgBackGround: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgBackGround.image = UIImage(named: "blue@2x.png")
        
        imgIcon.contentMode = UIViewContentMode.ScaleAspectFill
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func animateBackgroundImages ()
    {
        //imgIcon.hidden = true
        
        
//        imgBackGround.animationDuration = 10.0
        
//        UIView.animateWithDuration(1.5, animations: {
//            self.imgBackGround.alpha = 1.0
//        })
        //imgBackGround.image = UIImage(named: "gray.png")
        
//        imgBackGround.animationImages = NSArray(objects: UIImage(named: "color1.png")!, UIImage(named: "color2.png")!, UIImage(named: "color3.png")! ,UIImage(named: "color4.png")!, UIImage(named: "color5.png")!, UIImage(named: "color6.png")!, UIImage(named: "color7.png")!, UIImage(named: "color8.png")!, UIImage(named: "color9.png")!, UIImage(named: "color10.png")!, UIImage(named: "color11.png")!, UIImage(named: "color12.png")!)
//        imgBackGround.startAnimating()
    }
}
