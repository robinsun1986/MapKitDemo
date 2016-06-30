//
//  MiscUtils.swift
//  MapKitDemo
//
//  Created by Robin Sun on 29/06/2016.
//  Copyright © 2016 Robin Sun. All rights reserved.
//

import UIKit

extension Double {
    func toDecimalString() -> String {
        let percentFormatter = NSNumberFormatter()
        percentFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let decimalString = percentFormatter.stringFromNumber(self) ?? ""
        return decimalString
    }
}

extension UIColor {
    func toImage() -> UIImage {
        let rect = CGRectMake(0, 0, 1, 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, self.CGColor)
        CGContextFillRect(context, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}