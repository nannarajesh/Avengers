//
//  WhiteArrow.swift
//  HousingForPK
//
//  Created by Rajesh Nanna on 26/04/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

import UIKit

class WhiteArrow: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        var ctx : CGContextRef = UIGraphicsGetCurrentContext()
        
        CGContextBeginPath(ctx)
        CGContextMoveToPoint   (ctx, CGRectGetMinX(rect), CGRectGetMinY(rect))  // top left
        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMidY(rect))  // mid right
        CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect))  // bottom left
        CGContextClosePath(ctx)
        
        CGContextSetRGBFillColor(ctx, 1, 1, 1, 1)
        CGContextFillPath(ctx)
        
        self.backgroundColor = UIColor(patternImage: UIImage(named: "blue@2x.png")!)
    }
    

}
