//
//  CreatePeopleUserName.swift
//  VidooApp
//
//  Created by tungpt on 11/14/18.
//  Copyright © 2018 eZLO. All rights reserved.
//

import Foundation
import UIKit
public enum CreatePeopleImageViewType{
    case left
    case center
    case right
    var image: UIImage{
        get{
            switch self {
            case .left:
                return #imageLiteral(resourceName: "ic_leftSide")
            case .center:
                return #imageLiteral(resourceName: "ic_fullFace")
            case .right:
                return #imageLiteral(resourceName: "ic_rightSide")
            }
        }
    }
    
    var text: String{
        get{
            
            switch self {
            case .left:
                return "Left side"
            case .center:
                return "Full Face"
            case .right:
                return "Right side"
            }
        }
    }
}
struct CreatePeopleImageViewConstaints{
    static let bgView = UIColor.white
    static let cornerRadius:CGFloat = 8
}
class CreatePeopleImageView: CornerImageView{
    //Mark public
    var viewType:CreatePeopleImageViewType = .center{
        didSet{
            self.setImage(image: viewType.image)
            self.setTitle(content: viewType.text)
        }
    }
    override func setupView() {
        super.setupView()
        self.backgroundColor = CreatePeopleImageViewConstaints.bgView
        self.layer.cornerRadius = CreatePeopleImageViewConstaints.cornerRadius
    }
}
