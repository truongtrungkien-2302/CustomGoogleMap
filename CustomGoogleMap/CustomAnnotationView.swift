//
//  CustomAnnotationView.swift
//  DrawPolyline
//
//  Created by Truong Trung Kien on 12/02/2024.
//

import Foundation

//class CustomAnnotationView: UIView {
//    
//    var avatarImageView: ImageLabelView!
//    
//    init(frame: CGRect, title: String, borderColor: UIColor, tag: Int) {
//        super.init(frame: frame)
//        self.title = title
//        self.borderColor = borderColor
//        self.tag = tag
//        self.commonInit()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        self.commonInit()
//    }
//    
//    
//    func commonInit(){
//        if #available(iOS 11.0, *) {
//            self.clusteringIdentifier = "mapAnnotation"
//        } else {
//            // Fallback on earlier versions
//        }
//        self.image = SVGKImage.themeImage(named: "icPinLocation")?.uiImage
//        
//        self.avatarImageView = ImageLabelView(frame: CGRect(x: 2, y: 2, width: self.bounds.width - 4, height: self.bounds.width - 4))
//        self.avatarImageView.isUserInteractionEnabled = false
//        if let customAnnotation = self.customAnnotation, let data = customAnnotation.data{
//            if data.count > 1 {
//                
//                let text = data.count > 99 ? "99+" : "\(data.count)"
//                self.avatarImageView.setText(text)
//                if isFromManagerRouting {
//                    self.image = SVGKImage.themeImage(named: "icPinLocation")?.uiImage
//                    self.avatarImageView.label.textColor = ThemeManager.color(style: .primary)
//                }else{
//                    self.image = SVGKImage.grayImage(named: "icPinLocation")?.uiImage
//                    self.avatarImageView.label.textColor = ThemeManager.color(style: .hint)
//                }
//                
//            }else{
//                if(isFromManagerRouting){
//                    switch ERouteEmployeeStatus(rawValue: data.first?.typeEmployeeRouteStatus ?? -1){
//                    case .ONLINE:
//                        self.image = SVGKImage.onlineImage(named: "icPinLocation")?.uiImage
//                        break
//                    case .ABSENT:
//                        self.image = SVGKImage.busyImage(named: "icPinLocation")?.uiImage
//                        break
//                    default:
//                        self.image = SVGKImage.grayImage(named: "icPinLocation")?.uiImage
//                        break
//                        }
//                    self.avatarImageView.setData(empID: data.first?.avatar, name: data.first?.name)
//                }else{
//                    self.image = SVGKImage.themeImage(named: "icPinLocation")?.uiImage
//                    self.avatarImageView.set(imagePath: nil, name: data.first?.name)
//                }
//            }
//        }
//        if self.isSelected {
//            self.image = SVGKImage.redImage(named: "icPinLocation")?.uiImage
//            self.avatarImageView.label.textColor = ThemeManager.color(style: .red)
//        }
//        self.addSubview(self.avatarImageView)
//    }
//    
//    
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        let hitView = super.hitTest(point, with: event)
//        if hitView != nil {
//            self.superview?.bringSubviewToFront(self)
//        }
//        return hitView
//    }
//    
//    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        let rect = self.bounds
//        var isInside = rect.contains(point)
//        if !isInside {
//            for view in self.subviews {
//                isInside = view.frame.contains(point)
//                if isInside {
//                    break
//                }
//            }
//        }
//        return isInside
//    }
//    
//    // MARK: - callout showing and hiding
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        self.commonInit()
//        guard let customAnnotation = self.customAnnotation else { return }
//        self.didChangeSeletectState?(selected, customAnnotation)
//    }
//}
