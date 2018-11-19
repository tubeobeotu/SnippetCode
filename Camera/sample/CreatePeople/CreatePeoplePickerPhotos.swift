//
//  CreatePeopleUserName.swift
//  VidooApp
//
//  Created by tungpt on 11/14/18.
//  Copyright © 2018 eZLO. All rights reserved.
//

import Foundation
import UIKit
import Cartography
fileprivate struct CreatePeoplePickerPhotosConstaints{
    static let spacing:CGFloat = 16
    static let defaultRect:CGRect = CGRect(x: 0, y: 0, width: 20, height: 20)
}
public protocol CreatePeoplePickerPhotosDelegate{
    func didSelectLeftSideButton()
    func didSelectFullFaceButton()
    func didSelectRightSideButton()
}
class CreatePeoplePickerPhotos: BaseView {
    var delegate: CreatePeoplePickerPhotosDelegate!
    
    //Private
    private var leftView:CreatePeopleImageView!
    private var centerView:CreatePeopleImageView!
    private var rightView:CreatePeopleImageView!
    private var stackView: UIStackView! = {
        let tmpStackView = UIStackView()
        tmpStackView.alignment = .fill
        tmpStackView.distribution = .fillEqually
        tmpStackView.spacing = CreatePeoplePickerPhotosConstaints.spacing
        return tmpStackView
    }()
    override func setupView() {
        leftView = CreatePeopleImageView.init(frame: CreatePeoplePickerPhotosConstaints.defaultRect)
        leftView.viewType = .left
        leftView.didSelectView = {
            self.delegate?.didSelectLeftSideButton()
        }
        centerView = CreatePeopleImageView.init(frame: CreatePeoplePickerPhotosConstaints.defaultRect)
        centerView.viewType = .center
        centerView.didSelectView = {
            self.delegate?.didSelectFullFaceButton()
        }
        rightView = CreatePeopleImageView.init(frame: CreatePeoplePickerPhotosConstaints.defaultRect)
        rightView.viewType = .right
        rightView.didSelectView = {
            self.delegate?.didSelectRightSideButton()
        }

        self.stackView.frame = CreatePeoplePickerPhotosConstaints.defaultRect
        self.stackView.addArrangedSubview(leftView)
        self.stackView.addArrangedSubview(centerView)
        self.stackView.addArrangedSubview(rightView)
        self.addSubview(self.stackView)
        
        constrain(stackView) { (stackView) in
            stackView.top == stackView.superview!.top
            stackView.left == stackView.superview!.left
            stackView.right == stackView.superview!.right
            stackView.bottom == stackView.superview!.bottom
        }
    }
    func setImage(image: UIImage, type: CreatePeopleImageViewType){
        switch type {
        case .left:
            leftView.setContent(image: image)
            break
        case .right:
            rightView.setContent(image: image)
            break
        default:
            centerView.setContent(image: image)
            break
        }
    }

}
