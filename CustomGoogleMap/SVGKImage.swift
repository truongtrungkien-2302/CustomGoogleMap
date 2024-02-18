//
//  SVGKImage.swift
//  DrawPolyline
//
//  Created by Truong Trung Kien on 13/02/2024.
//

import Foundation
import SVGKit

extension SVGKImage {
    
    static func named(_ named: String, tintColor: UIColor? = nil, cacheKey: String? = nil) -> SVGKImage? {
        let img = SVGKImage(named: named, withCacheKey: cacheKey)
        if let color = tintColor {
            img?.setTintColor(color: color)
        }
        return img
    }
    
    static func grayImage(named: String) -> SVGKImage? {
        return self.named(named, tintColor: ThemeManager.color(style: .gray), cacheKey: named + "_grayColor")
    }
    static func darkGrayImage(named: String) -> SVGKImage? {
        return self.named(named, tintColor: ThemeManager.fontColor(style: .secondary), cacheKey: named + "_darkGrayColor")
    }
    static func lightGrayImage(named: String) -> SVGKImage? {
        return self.named(named, tintColor: ThemeManager.color(style: .border), cacheKey: named + "_lightGrayColor")
    }
    
    static func backgroundImage(named: String) -> SVGKImage? {
        return self.named(named, tintColor: ThemeManager.color(style: .background), cacheKey: named + "_backgroudColor")
    }
    
    static func themeImage(named: String) -> SVGKImage? {
        return self.named(named, tintColor: ThemeManager.color(style: .primary), cacheKey: named + "_themeColor")
    }
    
    static func whiteImage(named: String) -> SVGKImage? {
        return self.named(named, tintColor: .white, cacheKey: named + "_whiteColor")
    }
    
    static func greenImage(named: String) -> SVGKImage? {
        return self.named(named, tintColor: ThemeManager.color(style: .green), cacheKey: named + "_greenColor")
    }
    static func blueImage(named: String) -> SVGKImage? {
        return self.named(named, tintColor: ThemeManager.color(style: .blue), cacheKey: named + "_greenColor")
    }
    static func lightGreenImage(named: String) -> SVGKImage? {
        return self.named(named, tintColor: ThemeManager.color(style: .lightGreen), cacheKey: named + "_greenColor")
    }
    static func redImage(named: String) -> SVGKImage? {
        return self.named(named, tintColor: ThemeManager.color(style: .red), cacheKey: named + "_redColor")
    }
    
    static func hintImage(named: String) -> SVGKImage? {
        return self.named(named, tintColor: ThemeManager.color(style: .hint), cacheKey: named + "hintColor")
    }
    
    static func onlineImage(named: String) -> SVGKImage? {
        return self.named(named, tintColor: ThemeManager.color(style: .status_online), cacheKey: named + "_onlineColor")
    }
    
    static func offlineImage(named: String) -> SVGKImage? {
        return self.named(named, tintColor: ThemeManager.color(style: .status_offline), cacheKey: named + "_offlineColor")
    }
    
    static func busyImage(named: String) -> SVGKImage? {
        return self.named(named, tintColor: ThemeManager.color(style: .status_busy), cacheKey: named + "_busyColor")
    }
    
    static func blackImage(named: String) -> SVGKImage? {
        return self.named(named, tintColor: UIColor(hexString: "373c49"), cacheKey: nil)
    }
    
    func setTintColor(color: UIColor){
        if self.uiImage != nil && self.caLayerTree != nil {
            changeFillColor(subLayers: self.caLayerTree!.sublayers, color: color)
        }
    }
    
    func changeFillColor(subLayers:[Any]?, color: UIColor){
        if let subLayers = subLayers {
            for layer in subLayers{
                if let l = layer as? CAShapeLayer{
                    if l.strokeColor != nil {
                        l.strokeColor = color.cgColor
                    }
                    
                    if l.fillColor != nil {
                        l.fillColor = color.cgColor
                    }
                }
                if let l = layer as? CALayer, let sub = l.sublayers {
                    changeFillColor(subLayers: sub, color: color)
                }
            }
        }
    }
    
    func fixedSizeImage(size: CGSize) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        imageView.image = self.uiImage
        return imageView.image
    }
    
    func fixedSizeImage(size: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        imageView.image = self.uiImage
        return imageView.image
    }
}
