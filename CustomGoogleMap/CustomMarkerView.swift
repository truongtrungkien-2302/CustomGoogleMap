//
//  CustomMarkerView.swift
//  DrawPolyline
//
//  Created by Truong Trung Kien on 11/02/2024.
//

import Foundation
import UIKit

class CustomMarkerView: UIView {
    var title: String!
//    var borderColor: UIColor!
    var isOrange = true
    
    init(frame: CGRect, title: String, borderColor: UIColor, tag: Int,_ isOrange: Bool) {
        super.init(frame: frame)
        self.title = title
        self.isOrange = isOrange
        self.tag = tag
        self.setupViews()
    }
    
    func setupViews() {
        let uiView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.width))
        uiView.layer.cornerRadius = self.bounds.width / 2
        uiView.layer.borderColor = self.isOrange ? UIColor.orange.cgColor : UIColor.red.cgColor
        uiView.layer.borderWidth = 3.0
        uiView.clipsToBounds = true
        uiView.backgroundColor = .white
        
        let lblContent = UILabel(frame: CGRect(x: 0 , y: 0, width: self.bounds.width - 4, height: self.bounds.width - 4))
        lblContent.text = self.title
        lblContent.font = UIFont.systemFont(ofSize: 16)
        lblContent.textColor = .black
        lblContent.textAlignment = .center
        
        self.addSubview(uiView)
        self.addSubview(lblContent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
