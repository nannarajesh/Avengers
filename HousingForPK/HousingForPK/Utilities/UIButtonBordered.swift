//
//  UIButtonBordered.swift
//  ESI
//
//  Created by Administrator on 08/12/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import UIKit
import QuartzCore

class UIButtonBordered: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor.clearColor()
        //self.backgroundColor = UIColor.whiteColor()
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.cornerRadius = 5.0
    }
}
