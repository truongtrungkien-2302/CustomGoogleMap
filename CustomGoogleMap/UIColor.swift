//
//  UIColor.swift
//  DrawPolyline
//
//  Created by Truong Trung Kien on 13/02/2024.
//

import Foundation
import UIKit

extension UIColor {

    public convenience init(rgbaValue: UInt32) {
        let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
        let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
        let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
        let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    public convenience init(hex: Int, alpha: CGFloat) {
        let r = CGFloat((hex & 0xFF0000) >> 16)/255
        let g = CGFloat((hex & 0xFF00) >> 8)/255
        let b = CGFloat(hex & 0xFF)/255
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }

    public convenience init(hexString: String) {
        let hexString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)

        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }

        var color: UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    public convenience init(r : CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red:r/255.0, green:g/255.0, blue:b/255.0, alpha:1)
    }
    
    public convenience init(gray: CGFloat) {
        self.init(red:gray/255.0, green:gray/255.0, blue:gray/255.0, alpha:1)
    }

    public func hexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

        return String(format: "#%06x", rgb)
    }
}
