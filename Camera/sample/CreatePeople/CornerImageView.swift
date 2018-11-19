//
//  CreatePeopleUserName.swift
//  VidooApp
//
//  Created by tungpt on 11/14/18.
//  Copyright © 2018 eZLO. All rights reserved.
//

import UIKit
import Cartography
fileprivate struct CornerImageViewConstaints {
    static let labelHeight:CGFloat = 16
    static let labelFontSize:CGFloat = 12
    static let spacing:UIEdgeInsets = UIEdgeInsets.init(top: 16, left: 16, bottom: 4, right: 16)
    static let spacingLabel:UIEdgeInsets = UIEdgeInsets.init(top: 0, left: 8, bottom: 16, right: 8)
    static let titleNumberOfLines:Int = 1
    static let imageHeight:CGFloat = 40
}
class CornerImageView: BaseView{
    public var didSelectView: ()->Void = {}
    private var imageView:UIImageView! = {
        let tmpImageView = UIImageView.init(frame: .zero)
        tmpImageView.contentMode = .scaleAspectFit
        return tmpImageView
    }()
    private var contentImageView:UIImageView! = {
        let tmpImageView = UIImageView.init(frame: .zero)
        tmpImageView.contentMode = .scaleToFill
        return tmpImageView
    }()
    private var labelTitle:UILabel! = {
        let tmplabelTitle = UILabel.init(frame: .zero)
        tmplabelTitle.text = ""
        tmplabelTitle.font = UIFont.systemFont(ofSize: CornerImageViewConstaints.labelFontSize, weight: .regular)
        tmplabelTitle.textColor = CommonConstants.titleColorGray
        tmplabelTitle.textAlignment = .center
        tmplabelTitle.numberOfLines = CornerImageViewConstaints.titleNumberOfLines
        return tmplabelTitle
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup(){
        self.clipsToBounds = true
        self.isUserInteractionEnabled = true
        
        //add constraint
        self.addSubview(self.imageView)
        self.addSubview(self.labelTitle)
        self.addSubview(self.contentImageView)
        
        constrain(labelTitle) { (labelTitle) in
            labelTitle.height == CornerImageViewConstaints.labelHeight
            labelTitle.left == labelTitle.superview!.left + CornerImageViewConstaints.spacingLabel.left
            labelTitle.right == labelTitle.superview!.right - CornerImageViewConstaints.spacingLabel.right
            labelTitle.bottom == labelTitle.superview!.bottom - CornerImageViewConstaints.spacingLabel.bottom
        }
        
        constrain(imageView, labelTitle) { (imageView, labelTitle) in
            imageView.top >= imageView.superview!.top + CornerImageViewConstaints.spacing.top
            imageView.bottom == labelTitle.top - CornerImageViewConstaints.spacing.bottom
            imageView.left == imageView.superview!.left + CornerImageViewConstaints.spacing.left
            imageView.right == imageView.superview!.right - CornerImageViewConstaints.spacing.right
            imageView.height == CornerImageViewConstaints.imageHeight
        }
        
        constrain(contentImageView) { (contentImageView) in
            contentImageView.top == contentImageView.superview!.top
            contentImageView.left == contentImageView.superview!.left
            contentImageView.right == contentImageView.superview!.right
            contentImageView.bottom == contentImageView.superview!.bottom
            
        }
        
        //
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(sender:)))
        self.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        self.didSelectView()
    }
    
    func setImage(image: UIImage){
        self.imageView.image = image
    }
    
    func setContent(image: UIImage){
        self.contentImageView.image = image
    }
    func setTitle(content: String){
        self.labelTitle.text = content
    }
}
