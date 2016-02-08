//
//  Extensions.swift
//  ChatUI
//
//  Created by Max Suvorov on 07.02.16.
//  Copyright © 2016 Max Suvorov. All rights reserved.
//

import Foundation
import UIKit

extension UISegmentedControl {
    func removeBorders() {
        setBackgroundImage(imageWithColor(backgroundColor!), forState: .Normal, barMetrics: .Default)
        setBackgroundImage(imageWithColor(tintColor!), forState: .Selected, barMetrics: .Default)
        setDividerImage(imageWithColor(UIColor.clearColor()), forLeftSegmentState: .Normal, rightSegmentState: .Normal, barMetrics: .Default)
    }
    
    func setCornerRadius (radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRectMake(0.0, 0.0, 1.0, 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image
    }
}

extension Int {
    func isEven () -> Bool {
        if ( self % 2 == 0 ) {
            return true
        }
        else {
            return false
        }
    }
}

extension UITableView {
    func scrollToBottom () {
        self.contentOffset = CGPointMake(0, CGFloat.max)
    }
}