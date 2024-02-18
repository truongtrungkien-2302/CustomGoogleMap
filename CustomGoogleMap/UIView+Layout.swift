//
//  UIView+Layout.swift
//  ActiveLabel
//
//  Created by Tony Lai on 6/9/18.
//

import UIKit

public protocol LayoutCompatible {
    associatedtype LayoutCompatibleType

    var layout: LayoutExtension<LayoutCompatibleType> { get }
}

public extension LayoutCompatible {
    var layout: LayoutExtension<Self> {
        get { return LayoutExtension(self) }
    }
}

public struct LayoutExtension<Base> {
    let base: Base

    init(_ base: Base) {
        self.base = base
    }
}

extension UIView: LayoutCompatible {}

public struct LayoutPinOptions: OptionSet {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let none = LayoutPinOptions(rawValue: 0 << 0)
    public static let top = LayoutPinOptions(rawValue: 1 << 0)
    public static let bottom = LayoutPinOptions(rawValue: 2 << 0)
    public static let leading = LayoutPinOptions(rawValue: 3 << 0)
    public static let trailing = LayoutPinOptions(rawValue: 4 << 0)
}

public extension LayoutExtension where Base: UIView {

//    @discardableResult
//    public func pin(to view: UIView, insets: UIEdgeInsets = .zero, without options: LayoutPinOptions = .none) -> UIView {
//        base.translatesAutoresizingMaskIntoConstraints = false
//        var constraints = [NSLayoutConstraint]()
//        if !options.contains(.top) {
//            constraints.append(base.topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top))
//        }
//        if !options.contains(.bottom) {
//            constraints.append(base.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom))
//        }
//        if !options.contains(.leading) {
//            constraints.append(base.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left))
//        }
//        if !options.contains(.trailing) {
//            constraints.append(base.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right))
//        }
//        NSLayoutConstraint.activate(constraints)
//        return base
//    }

    func square(with constant: CGFloat) {
        base.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            base.widthAnchor.constraint(equalToConstant: constant),
            base.heightAnchor.constraint(equalToConstant: constant)
            ])
    }

    func center(of view: UIView) {
        base.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            base.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            base.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    func border(radius: CGFloat, boderWidth: CGFloat = 0, boderColor: UIColor? = nil, backGroundColor: UIColor? = nil) {
        self.layer.cornerRadius = radius
        if let boderColor = boderColor {
            self.layer.borderColor = boderColor.cgColor
        } else {
            self.layer.borderColor = UIColor.clear.cgColor
        }
        
        self.layer.borderWidth = boderWidth
        
        if backGroundColor != nil {
            self.backgroundColor = backGroundColor
        }
        
        self.layer.masksToBounds = true
    }
    
    func addTapGesture(tapNumber: Int, target: Any, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
      }
}

extension UIView {
    public var size: CGSize {
        get {
            return frame.size
        }
        set {
            width = newValue.width
            height = newValue.height
        }
    }
    
    public var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    public var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    public var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    public var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    public var screenshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    public var parentViewController: UIViewController? {
        weak var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    public func firstResponder() -> UIView? {
        var views = [UIView](arrayLiteral: self)
        var i = 0
        repeat {
            let view = views[i]
            if view.isFirstResponder {
                return view
            }
            views.append(contentsOf: view.subviews)
            i += 1
        } while i < views.count
        return nil
    }
    
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
    public func rounds(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    public func addShadow(ofColor color: UIColor = UIColor(red: 0.07, green: 0.47, blue: 0.57, alpha: 1.0), radius: CGFloat = 3, offset: CGSize = .zero, opacity: Float = 0.5) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
      layer.masksToBounds = false
      layer.shadowColor = UIColor.black.cgColor
      layer.shadowOpacity = 0.5
      layer.shadowOffset = CGSize(width: -1, height: 1)
      layer.shadowRadius = 12

      layer.shadowPath = UIBezierPath(rect: bounds).cgPath
      layer.shouldRasterize = true
      layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
      layer.masksToBounds = false
      layer.shadowColor = color.cgColor
      layer.shadowOpacity = opacity
      layer.shadowOffset = offSet
      layer.shadowRadius = radius

      layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
      layer.shouldRasterize = true
      layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        layer.masksToBounds = false
    }
    
//    public func addTopBottomLineView(){
//        let topLine = LineView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: PIXEL))
//        topLine.backgroundColor = ThemeManager.color(style: .border)
//        
//        let bottomLine = LineView(frame: CGRect(x: 0, y: self.bounds.height - PIXEL, width: self.bounds.width, height: PIXEL))
//        bottomLine.backgroundColor = ThemeManager.color(style: .border)
//        
//        self.addSubview(topLine)
//        self.addSubview(bottomLine)
//    }
    
    ///  Các trạng thái ẩn hiện của 1 view
    /// - Author: GIANG PHAN BA
    /// - Date: 05/04/2021
    enum Visibility {
        case visible // hiện view lên
        case invisible // ẩn đi nhưng vẫn dữ kích thước của view đó
        case gone // ẩn hẳn đi luôn, các view khác có thể đè lên
    }
    
    ///  Thiết lập ẩn hiện của 1 view
    /// - Author: GIANG PHAN BA
    /// - Date: 05/04/2021
    var visibility: Visibility {
        get {
            let constraint = (self.constraints.filter{$0.firstAttribute == .height && $0.constant == 0}.first)
            if let constraint = constraint, constraint.isActive {
                return .gone
            } else {
                return self.isHidden ? .invisible : .visible
            }
        }
        set {
            if self.visibility != newValue {
                self.setVisibility(newValue)
            }
        }
    }
    
    ///  Thiết lập ẩn hiện của 1 view
    /// - Author: GIANG PHAN BA
    /// - Date: 05/04/2021
    private func setVisibility(_ visibility: Visibility) {
        let constraint = (self.constraints.filter{$0.firstAttribute == .height && $0.constant == 0}.first)
        
        switch visibility {
        case .visible:
            constraint?.isActive = false
            self.isHidden = false
            break
        case .invisible:
            constraint?.isActive = false
            self.isHidden = true
            break
        case .gone:
            if let constraint = constraint {
                constraint.isActive = true
            } else {
                let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 0)
                self.addConstraint(constraint)
                constraint.isActive = true
            }
        }
    }
}

extension UIEdgeInsets {
    static func make(t: CGFloat = 0, l: CGFloat = 0, b: CGFloat = 0,  r: CGFloat = 0) -> UIEdgeInsets{
        return UIEdgeInsets(top: t, left: l, bottom: b, right: r)
    }
}

extension CGRect{
    static func square(_ size: CGFloat) -> CGRect{
        return CGRect(x: 0, y: 0, width: size, height: size)
    }
}
