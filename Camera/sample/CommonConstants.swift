//
//  Copyright © 2018 eZLO. All rights reserved.
//

import Foundation
import UIKit
import DynamicColor

struct CommonLayoutPriority {
    //MARK: - Public
    static let supperLow:   UILayoutPriority    = UILayoutPriority(100)
    static let low:         UILayoutPriority    = UILayoutPriority(250)
    static let normal:      UILayoutPriority    = UILayoutPriority(500)
    static let hight:       UILayoutPriority    = UILayoutPriority(750)
    static let quiteMax:    UILayoutPriority    = UILayoutPriority(999)
    static let require:     UILayoutPriority    = UILayoutPriority(1000)
    
    static let tempWith:    CGFloat             = 100
    static let tempHeight:  CGFloat             = 100
}

struct CommonConstants {
    
    //MARK: - Public
    static var windowBackgroundColor: UIColor {
        return .black
    }
    
    static var borderColor: UIColor {
        let color = UIColor(hexString: "#040A17")
        return color
    }
    
    static var bordorColorFilter: UIColor {
        let color = UIColor(hexString: "8C8CAA")
        return color
    }
    
    //MARK: - CLIP COLOR
    static var clipMotionColor: UIColor {
        let clr = UIColor(hexString: "#857BFF")
        return clr
    }
    
    static var clipObjectColor: UIColor {
        let clr = UIColor(hexString: "#FF867F")
        return clr
    }
    
    static var clipFaceColor: UIColor {
        let clr = UIColor(hexString: "#52A1DE")
        return clr
    }
    
    static var clipSoundColor: UIColor {
        let clr = UIColor(hexString: "#0FD4D9")
        return clr
    }
    
    //MARK: Application (General) Colors
    static var applicationBackgroundColor: UIColor {
        let clr = UIColor(hexString: "#F3F3F3")
        return clr
    }
    
    static var applicationTintColor: UIColor {
        let clr = UIColor(hexString: "#42FF2E")
        return clr
    }
    
    static var applicationErrorColor: UIColor {
        let clr = UIColor(hexString: "#DF5951")
        return clr
    }
    
    //MARK: Font
    static var fontContent: UIFont {
        return UIFont.systemFont(ofSize: 12)
    }
    
    static var fontButton: UIFont {
        return UIFont.systemFont(ofSize: 13)
    }

    //MARK: Title Colors
    static var titleColorGray: UIColor {
        return UIColor(hexString: "#575D6A")
    }
    
    static var titleColorWhite: UIColor {
        return .white
    }

    static var titleColorLightGray: UIColor {
        return UIColor(hexString: "#7D8191")
    }
    
    //MARK: Icon Colors
    static var iconEnabledTintColor: UIColor {
        return UIColor(hexString: "#8E94A8")
    }
    
    static var iconSelectedTintColor: UIColor {
        return UIColor(hexString: "#10B85E")
    }
    
    static var iconDisabledTintColor: UIColor {
        return UIColor(hexString: "#CCCFDB")
    }
    
    //MARK: Gradient Controls Colors
    static var gradientControlBeginColor: UIColor {
        return iconSelectedTintColor
    }
    
    static var gradientControlEndColor: UIColor {
        return UIColor(hexString: "#28CB90")
    }
    
    static var gradientControlGrayBeginColor: UIColor {
        return UIColor(hexString: "#B4B7BE")
    }
    
    static var gradientControlGrayEndColor: UIColor {
        return UIColor(hexString: "#E2E3E7")
    }
    
    //MARK: Title Sizes
    static var titleSize: CGFloat {
        return 18
    }
    
    //MARK: TabBar
    static var tabBarTitleSize: CGFloat {
        return 10
    }
    
    //MARK: Cell Title Sizes
    static var cellTitleSize: CGFloat {
        return 14
    }
    
    static var cellDescriptionSize: CGFloat {
        return 12
    }
    
    static var buttonTitleSize: CGFloat {
        return 14
    }
    
    //
    static var navigationToolBarButtonSize:CGSize {
        let size = CGSize(width: 24, height: 24)
        return size
    }
    
    static var widthCollectionViewCell: CGFloat {
        let screenWith = UIScreen.main.bounds.width
        return screenWith - CommonConstants.normalMargin * 2
    }
    
    static var normalMargin: CGFloat {
        return 10
    }
    
    static let dateFormateNormal:   String          = "yyyyMMdd HHmmss"
    
    static let radius:              CGFloat             = 5
    //MARK: - Private
}
