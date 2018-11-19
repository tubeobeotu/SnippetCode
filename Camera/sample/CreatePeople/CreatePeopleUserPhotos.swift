//
//  CreatePeopleUserName.swift
//  VidooApp
//
//  Created by tungpt on 11/14/18.
//  Copyright © 2018 eZLO. All rights reserved.
//

import UIKit
import Cartography
fileprivate struct CreatePeopleUserPhotosConstants {
    static let titleLabelMargin   :   UIEdgeInsets         = UIEdgeInsets(top: 20, left: 0, bottom: 30, right: 0)
    static let photosViewMargin   :   UIEdgeInsets         = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    static let titleLabelFontSize   :   CGFloat         = 14
    static let titleLabelString     : String = "Please add 3 photos for better identification, one in full face and two in profile with left and right side."
    static let titleNumberOfLines = 0
    static let headerHeight  : CGFloat = 25
    static let photoViewsHeight: CGFloat = 80
}
protocol CreatePeopleUserPhotosDelegate:CreatePeoplePickerPhotosDelegate {
    
}

class CreatePeopleUserPhotos: BaseView {
    //Mark private
    public private(set) var titleLabel: UILabel! = {
        let label = UILabel(frame: .zero)
        label.text = CreatePeopleUserPhotosConstants.titleLabelString
        label.font = UIFont.systemFont(ofSize: CreatePeopleUserPhotosConstants.titleLabelFontSize, weight: .regular)
        label.textColor = CommonConstants.titleColorGray
        label.textAlignment = .left
        label.numberOfLines = CreatePeopleUserPhotosConstants.titleNumberOfLines
        return label
    }()
    private var photosView:CreatePeoplePickerPhotos! = {
        let tmpView = CreatePeoplePickerPhotos(frame: .zero)
        return tmpView
    }()
    lazy private var header = CreatePeopleHeader()
    
    //Mark public
    var delegate:CreatePeopleUserPhotosDelegate!
    override func setupView() {
        header.headerType = .userPhotos
        photosView.delegate = self
        self.addSubview(header)
        self.addSubview(photosView)
        self.addSubview(titleLabel)
        constrain(header) { (header) in
            header.left == header.superview!.left
            header.right == header.superview!.right
            header.top == header.superview!.top
            header.height == CreatePeopleUserPhotosConstants.headerHeight
        }
        
        constrain(photosView, header.titleLabel) { (photosView, header) in
            photosView.left == header.left + CreatePeopleUserPhotosConstants.photosViewMargin.left
            photosView.right == photosView.superview!.right - CreatePeopleUserPhotosConstants.photosViewMargin.right
            photosView.top == header.bottom + CreatePeopleUserPhotosConstants.photosViewMargin.top
            photosView.height == photosView.width/3

        }

        constrain(titleLabel, photosView) { (titleLabel, photosView) in
            titleLabel.left == photosView.left + CreatePeopleUserPhotosConstants.titleLabelMargin.left
            titleLabel.top == photosView.bottom + CreatePeopleUserPhotosConstants.titleLabelMargin.bottom
            titleLabel.right == photosView.right - CreatePeopleUserPhotosConstants.titleLabelMargin.right
        }

        
    }
    
    func setImage(image: UIImage, type: CreatePeopleImageViewType){
        photosView.setImage(image: image, type: type)
    }
}

extension CreatePeopleUserPhotos: CreatePeoplePickerPhotosDelegate{
    func didSelectLeftSideButton() {
        self.delegate?.didSelectLeftSideButton()
    }
    func didSelectFullFaceButton() {
        self.delegate?.didSelectFullFaceButton()
    }
    func didSelectRightSideButton() {
        self.delegate?.didSelectRightSideButton()
    }
}
