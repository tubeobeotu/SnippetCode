//
//  CreatePeopleUserName.swift
//  VidooApp
//
//  Created by tungpt on 11/14/18.
//  Copyright © 2018 eZLO. All rights reserved.
//

import UIKit
import Cartography
fileprivate struct CreatePeopleUserNameConstants {
    static let textFieldMargin   :   UIEdgeInsets         = UIEdgeInsets(top: 4, left: 50, bottom: 0, right: 0)
    static let titleLabelFontSize   :   CGFloat         = 13
    static let titleLabelString     : String = "add person name"
    static let headerHeight  : CGFloat = 25
    static let textFieldBorderWidth: CGFloat = 1
    static let textFieldCornerRadius: CGFloat = 16
    
    static let paddingTextField = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
}
protocol CreatePeopleUserNameDelegate {
    func didChangeUserName(userName: String)
}
class CreatePeopleUserName: BaseView {
    //Mark private
    private var textField: CreatePeopleNameTextField = {
        let textfield = CreatePeopleNameTextField()
        textfield.borderStyle = .none
        textfield.font = UIFont.systemFont(ofSize: CreatePeopleUserNameConstants.titleLabelFontSize, weight: .regular)
        textfield.placeholder = CreatePeopleUserNameConstants.titleLabelString //TODO: Localize
        textfield.layer.cornerRadius = CreatePeopleUserNameConstants.textFieldCornerRadius
        textfield.layer.borderWidth = CreatePeopleUserNameConstants.textFieldBorderWidth
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.textColor = CommonConstants.titleColorGray
        return textfield
    }()
    lazy private var header = CreatePeopleHeader()
    //Mark public
    var delegate:CreatePeopleUserNameDelegate!
    override func setupView() {
        header.headerType = .userName
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.addSubview(header)
        self.addSubview(textField)
        constrain(header) { (header) in
            header.left == header.superview!.left
            header.right == header.superview!.right
            header.top == header.superview!.top
            header.height == CreatePeopleUserNameConstants.headerHeight
        }
        
        constrain(textField, header) { (textField, header) in
            textField.top == header.bottom + CreatePeopleUserNameConstants.textFieldMargin.top
            textField.right == header.right
            textField.bottom == textField.superview!.bottom
        }
        
        constrain(textField, header.titleLabel) { (textField, header) in
            textField.left == header.left
        }
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.delegate?.didChangeUserName(userName: textField.text ?? "")
    }
}

class CreatePeopleNameTextField: UITextField {

//    override open func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: CreatePeopleUserNameConstants.paddingTextField)
//    }
//    
//    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: CreatePeopleUserNameConstants.paddingTextField)
//    }
//    
//    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: CreatePeopleUserNameConstants.paddingTextField)
//    }
}
