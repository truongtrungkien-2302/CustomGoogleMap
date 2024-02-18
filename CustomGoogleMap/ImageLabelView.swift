//
//  ImageLabelView.swift
//  AmisCRM
//
//  Created by DN on 4/4/19.
//  Copyright © 2019 MISA JSC. All rights reserved.
//

import UIKit

class ImageLabelView: UIControl {

    var imageView: UIImageView!
    var label: UILabel!
    private var userID: Int?
    private var userName: String?
    
    var usingAvatarDefault = false
    
    private var customBlock: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.border(radius: self.bounds.width/2.0, boderWidth: 1, boderColor: UIColor(hexString: "e0e0e0"), backGroundColor: ThemeManager.color(style: .background))
        
    }
    /// Dùng hàm này để truyền UserID vào, khi nhấn vào ảnh sẽ hiển thị view Thông tin chi tiết tương ứng với UserID đó. Nếu không có userID thì sẽ chỉ set ảnh và tên thôi.
    /// - Author: Nguyễn Sỹ Tân
    /// - Date: 03/09/2019
//    func setData(id: Int?, name: String?, customBlock: (() -> Void)? = nil){
//        self.userID = id
//        self.userName = name
//        self.customBlock = customBlock
//        self.set(imagePath: id?.avatarLink(), name: name)
//    }
//    
//    func setData(empID: String?, name: String?, customBlock: (() -> Void)? = nil){
//        self.userName = name
//        self.customBlock = customBlock
//        self.set(imagePath: empID?.guidToAvatarLink(), name: name)
//    }
    
    fileprivate func commonInit(){
        self.imageView = UIImageView(frame: .zero)
        self.imageView.contentMode = .scaleAspectFill
        self.label = UILabel(frame: .zero)
        self.label.textAlignment = .center
        self.label.font = UIFont.systemFont(ofSize: 16)
        self.label.textColor = ThemeManager.color(style: .hint)
        self.label.adjustsFontSizeToFitWidth = true
        
        self.label.backgroundColor = UIColor(hexString: "f2f2f2")
        self.label.isHidden = true
        self.imageView.isHidden = true
        
        self.addSubview(label)
        self.addSubview(imageView)
        self.sendSubviewToBack(label)
        self.sendSubviewToBack(imageView)
        self.border(radius: self.bounds.width/2.0, boderWidth: 1, boderColor: UIColor(hexString: "e0e0e0"), backGroundColor: ThemeManager.color(style: .background))
        
//        imageView.snp.makeConstraints { (make) in
//            make.top.right.left.bottom.equalToSuperview()
//        }
//        
//        label.snp.makeConstraints { (make) in
//            make.top.right.left.bottom.equalToSuperview()
//        }
//        
//        self.addTarget(self, action: #selector(self.actionShowUserInfo), for: .touchUpInside)
    }
    
//    @objc func actionShowUserInfo(_ sender: Any?){
//        if self.customBlock != nil {
//            self.customBlock?()
//            return
//        }
//        if self.userID != nil {
//            UserInfoViewController.show(userID: self.userID, userName: userName)
//        }else{
//            if let img = self.imageView.image, self.imageView.isHidden == false {
//                let photo = INSPhoto(image: img, thumbnailImage: nil)
//                let photoViewer = INSPhotosViewController(photos: [photo])
//                UIApplication.topViewController()?.present(photoViewer, animated: true, completion: nil)
//            }
//        }
//    }
    
//    func set(image: UIImage?, name: String?) {
//        if let image = image {
//            self.imageView.image = image
//            self.imageView.isHidden = false
//            self.label.isHidden = true
//            self.layer.borderColor = UIColor(hexString: "e0e0e0").cgColor
//        } else if let name = name {
//            self.userName = name.getShortText().short
//            self.label.text = self.userName
//            self.imageView.isHidden = true
//            self.label.isHidden = false
//            self.layer.borderColor = UIColor.clear.cgColor
//        }
//        
//    }
    
    
    func setText(_ name: String?) {
        if let name = name {
            self.label.text = name
            self.imageView.isHidden = true
            self.label.isHidden = false
            self.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    
    override var isHighlighted: Bool{
        didSet{
            if oldValue != isHighlighted{
                UIView.animate(withDuration: 0.2) {
                    self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.85, y: 0.85) : .identity
                }
            }
        }
        
    }
    
}
