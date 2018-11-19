//
//  CreatePeopleUserName.swift
//  VidooApp
//
//  Created by tungpt on 11/14/18.
//  Copyright © 2018 eZLO. All rights reserved.
//

import UIKit
import Cartography
public enum CreatePeopleHeaderType{
    case userName
    case userPhotos
    
    var image: UIImage{
        get{
            switch self {
            case .userName:
                return #imageLiteral(resourceName: "ic_user")
            case .userPhotos:
                return #imageLiteral(resourceName: "ic_photos")
            }
        }
    }
    
    var text: String{
        get{
            switch self {
            case .userName:
                return "User Name"
            case .userPhotos:
                return "User Photos"
            }
        }
    }
}
class CreatePeopleHeader: BaseView {
    //MARK: Private
    fileprivate struct CreatePeopleConstants {
        static let titleLabelFontSize   :   CGFloat         = 14
        static let imageRect            :   CGRect          = CGRect.init(x: 0, y: 0, width: 20, height: 20)
        static let controlsSpacing      :   CGFloat         = 16
    }
    //MARK: Public
    public var headerType:CreatePeopleHeaderType = .userName{
        didSet{
            titleLabel.text = headerType.text
            imageView.image = headerType.image
        }
    }
    
    public private(set) var titleLabel: UILabel! = {
        let label = UILabel(frame: .zero)
        label.text = "label"
        label.font = UIFont.systemFont(ofSize: CreatePeopleConstants.titleLabelFontSize, weight: .semibold)
        label.textColor = CommonConstants.titleColorGray
        label.textAlignment = .center
        return label
    }()
    
    public private(set) var imageView: UIImageView! = {
        let imageView = UIImageView(frame: .zero)
        constrain(imageView) { (imageView) in
            imageView.width == CreatePeopleConstants.imageRect.width
            imageView.height == CreatePeopleConstants.imageRect.height
        }
        imageView.tintColor = CommonConstants.iconDisabledTintColor
        return imageView
    }()
    override func setupView() {
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        
        
        constrain(imageView) { (imageView) in
            imageView.centerY == imageView.superview!.centerY
            imageView.left == imageView.superview!.left + CreatePeopleConstants.imageRect.origin.x
            imageView.width == CreatePeopleConstants.imageRect.width
            imageView.height == CreatePeopleConstants.imageRect.height
        }
        
        constrain(imageView, titleLabel) { imageView, titleLabel in
            titleLabel.centerY == imageView.centerY
            titleLabel.left == imageView.right + CreatePeopleConstants.controlsSpacing
            titleLabel.top == titleLabel.superview!.top
            titleLabel.bottom == titleLabel.superview!.bottom
        }
    }
    
}
