//
//  ThemeManager.swift
//  DrawPolyline
//
//  Created by Truong Trung Kien on 13/02/2024.
//

import Foundation
import UIKit

enum AppFont: String {
    case `default`
    case neoSans
    
    
    static func getAll() -> [AppFont] {
        return [.default, .neoSans]
    }
    
    func getName() -> String{
        switch self {
        case .neoSans:
            return "Neo Sans"
        default:
            return "ASVC_FontDefault"
        }
    }
    
    func light(size: CGFloat) -> UIFont{
        var font: UIFont?
        switch self {
        case .neoSans:
            font = UIFont(name: "NeoSansIntel", size: size)
        default:
            font = UIFont(name: "SFProText-Light", size: size)
        }
        return font ?? UIFont.systemFont(ofSize:size)
    }
    
    func regular(size: CGFloat) -> UIFont{
        var font: UIFont?
        switch self {
        case .neoSans:
            font = UIFont(name: "NeoSansIntel", size: size)
        default:
            font = UIFont(name: "SFProText-Regular", size: size)
        }
        return font ?? UIFont.systemFont(ofSize:size)
    }
    
    func bold(size: CGFloat) -> UIFont{
        var font: UIFont?
        switch self {
        case .neoSans:
            font = UIFont(name: "UTMNeoSansIntelBold", size: size)
        default:
            font = UIFont(name: "SFProText-Semibold", size: size)
        }
        return font ?? UIFont.systemFont(ofSize:size)
    }
    
    func medium(size: CGFloat) -> UIFont{
        var font: UIFont?
        switch self {
        case .neoSans:
            font = UIFont(name: "UTMNeoSansIntelBold", size: size)
        default:
            font = UIFont(name: "SFProText-Medium", size: size)
        }
        return font ?? UIFont.systemFont(ofSize:size)
    }
}

enum FontStyleEnum {
    case title5Medium
    case headline
    case title1
    case title2Medium
    case title2
    case title3
    case title4
    case title4Medium
    case subheader
    
    case body
    case bodyBold
    case bodyMedium
    case caption1
    case caption1Bold
    case caption2
    case caption3
    case footnote
    case footnoteBold
    case tableHeader
    case subheaderBold
    case subheaderBold1
    case subheaderMedium
}

enum FontColorEnum {
    case primary
    case secondary
    case disabled
    case hint
    case white
    case clickable
    case error
    case custom(color: UIColor)
}

enum ColorEnum {
    /// Màu báo lỗi validate
    case error
    /// Màu chính của ứng dụng
    case primary
    /// Màu phụ của ứng dụng
    case secondary
    /// Màu nền
    case background
    /// Màu viền
    case border
    /// Màu hint
    case hint
    /// Màu nền của header
    case header
    /// Màu ảnh disabled
    case disabled
    /// Màu nền xám của control/ button
    case controlBackground
    /// Màu nền xám khi highlight của control/ button
    case controlHighlight
    /// Màu xanh lá
    case green
    case lightGreen
    /// Màu đỏ
    case red
    case white
    // overview 1
    case overview1
    case overview2
    case overview3
    case overview4
    
    
    case activityHome1
    case activityHome2
    case activityHome3
    case activityHome4
    
    // status
    case status_online
    case status_busy
    case status_offline
    case blue
    case blueLight
    case blueLight1
    case gray
    case grayLight
    case uncheckBox
    
    case blueLine
}

/// Lớp quản lý màu sắc và font chữ của ứng dụng
class ThemeManager {
    static let kCachedThemeColor = "kCachedThemeColor"
    static let kCachedFont = "kCachedFont"
    
    static let shared: ThemeManager = ThemeManager()
    var primaryColor: UIColor = ThemeManager.color(style: .blue)
    
    static func fontColor(style: FontColorEnum) -> UIColor {
        var color: UIColor?
        
        switch style {
        case .primary:
            color = UIColor(hexString: "1f2229")
        case .secondary:
            color = UIColor(hexString: "636C83")
        case .disabled:
            color = UIColor(hexString: "8e8e93")
        case .hint:
            color = UIColor(hexString: "9e9e9e")
        case .white:
            color = UIColor(hexString: "ffffff")
        case .clickable:
            color = self.color(style: .primary)
        case .error:
            color = UIColor(hexString: "EC4141")
        case .custom(let c):
            color = c
        }
        return color ?? UIColor(hexString: "212121")
    }
    
    static func color(style: ColorEnum) -> UIColor {
        var color: UIColor?
        
        switch style {
        case .primary:
            color = ThemeManager.shared.primaryColor
        case .secondary:
            color = UIColor(hexString: "ff9500")
        case .error:
            color = UIColor(hexString: "ff3830")
        case .hint:
            color = UIColor(hexString: "9e9e9e")
        case .border:
            color = UIColor(hexString: "d3d7de")
        case .header:
            color = UIColor(hexString: "757575")
        case .background:
            color = UIColor(hexString: "efeff4")
        case .disabled:
            color = UIColor(hexString: "8e8e93")
        case .controlBackground:
            color = UIColor(hexString: "efefef")
        case .controlHighlight:
            color = UIColor(hexString: "dedede")
        case .green:
            color = UIColor(hexString: "1B8722")
        case .lightGreen:
            color = UIColor(hexString: "1BB395")
        case .red:
            color = UIColor(hexString: "EC4141")
        case .overview1:
            color = UIColor(hexString: "633FF2")
        case .overview2:
            color = UIColor(hexString: "3F5FF1")
        case .overview3:
            color = UIColor(hexString: "3CA5EE")
        case .overview4:
            color = UIColor(hexString: "F07A3D")
        case .white:
            color = UIColor(hexString: "ffffff")
        case .activityHome1:
            color = UIColor(hexString: "FF9500")
        case .activityHome2:
            color = UIColor(hexString: "FF1CBE93")
        case .activityHome3:
            color = UIColor(hexString: "FF6859EB")
        case .activityHome4:
            color = UIColor(hexString: "0999CC")
        case .status_online:
            color = UIColor(hexString: "31b491")
        case .status_busy:
            color = UIColor(hexString: "f07d42")
        case .status_offline:
            color = UIColor(hexString: "636c83")
        case .blue:
            color = UIColor(hexString: "4262f0")
        case .blueLight:
            color = UIColor(hexString: "D1ECFE")
        case .blueLight1:
            color = UIColor(hexString: "e7ebfd")
        case .gray:
            color = UIColor(hexString: "373C49")
        case .grayLight:
            color = UIColor(hexString: "F0F2F4")
        case .uncheckBox:
            color = UIColor(hexString: "C869C")
        case .blueLine:
            color = UIColor(red: 0.121569, green: 0.466667, blue: 0.705882, alpha: 1)
        }
        
        return color ?? UIColor(hexString: "f2f2f2")
    }
}
