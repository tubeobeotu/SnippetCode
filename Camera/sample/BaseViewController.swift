//
//  Copyright © 2018 eZLO. All rights reserved.
//

import Foundation
import UIKit
import Cartography



public class BaseViewController: UIViewController {
    //MARK: - Public
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initialSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //uncoment here if wants same initial setup over storyboard/xib 
        //self.initialSetup()
    }
    
    override public func loadView() {
        super.loadView()
        loadViewSetup()
    }
    
    
    
    public private(set) var noItemsLabel: UILabel! = {
        let label = UILabel(frame: .zero)
        label.text = "There's no items to show"
        label.font = UIFont.systemFont(ofSize: CommonConstants.titleSize, weight: .regular)
        label.textColor = CommonConstants.titleColorGray
        label.textAlignment = .center
        return label
    }()
    
    public var noItemsLabelHidden: Bool = true {
        didSet {
            if needTriggerProperty {
                setNoItemsLabelHidden(noItemsLabelHidden, animated: false)
            }
        }
    }
    
    public func setNoItemsLabelHidden(_ hidden: Bool, animated: Bool) {
        needTriggerProperty = false
        noItemsLabelHidden = hidden
        needTriggerProperty = true
        
        let animations = {
            if (hidden != self.noItemsLabel.isHidden) {
                self.noItemsLabel.isHidden = hidden
            }
        }
        
        if animated {
            UIView.setAnimationCurve(.easeOut)
            UIView.animate(withDuration: BaseViewControllerConstants.animationsDuration, animations: animations)
        } else {
            animations()
        }
    }
    
    
    
    public func initialSetup() {
        //
    }

    public func loadViewSetup() {
        view.addSubview(noItemsLabel)
        
        constrain(noItemsLabel, noItemsLabel.superview!) { (noItemsLabel, noItemsLabelSuperview) in
            noItemsLabel.center == noItemsLabelSuperview.centerWithinMargins
            if #available(iOS 11.0, *) {
                noItemsLabel.leading >= noItemsLabelSuperview.safeAreaLayoutGuide.leadingMargin + BaseViewControllerConstants.noItemsLabelLeftMargin
                noItemsLabel.trailing <= noItemsLabelSuperview.safeAreaLayoutGuide.trailingMargin - BaseViewControllerConstants.noItemsLabelRightMargin
            } else {
                noItemsLabel.leading >= noItemsLabelSuperview.leadingMargin + BaseViewControllerConstants.noItemsLabelLeftMargin
                noItemsLabel.trailing <= noItemsLabelSuperview.trailingMargin - BaseViewControllerConstants.noItemsLabelRightMargin
            }
        }
        
        noItemsLabelHidden = true
        if showBackButton {
            addBackButton()
        }
    }
    
    public var showBackButton = false
    
    public func addRightButton(image: UIImage, tintColor: UIColor, selector: Selector) {
        let button = UIButton()
        let imageView = UIImageView()
        button.addSubview(imageView)
        constrain(button, imageView) { (button, imageView) in
            button.width == BaseViewControllerConstants.buttonWidth
            button.height == BaseViewControllerConstants.buttonHeight
            imageView.center == button.center
            imageView.width == BaseViewControllerConstants.imageWidth
            imageView.height == BaseViewControllerConstants.imageHeight
        }
        imageView.image = image
        imageView.tintColor = tintColor
        button.addTarget(self, action: selector, for: .touchUpInside)
        let naviItem = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = naviItem
    }
    
    //MARK: - Private
    private struct BaseViewControllerConstants {
        static let noItemsLabelLeftMargin:  CGFloat         = 10
        static let noItemsLabelRightMargin: CGFloat         = noItemsLabelLeftMargin
        static let animationsDuration:      TimeInterval    = 0.33
        static let buttonWidth:             CGFloat         = 24
        static let buttonHeight:            CGFloat         = 24
        static let imageWidth:              CGFloat         = 16
        static let imageHeight:             CGFloat         = 16
    }
    
    
    
    private var needTriggerProperty: Bool = true
    
    private func addBackButton() {
        let button = UIButton()
        let imageView = UIImageView()
        button.addSubview(imageView)
        constrain(button, imageView) { (button, imageView) in
            button.width == BaseViewControllerConstants.buttonWidth
            button.height == BaseViewControllerConstants.buttonHeight
            imageView.center == button.center
            imageView.width == BaseViewControllerConstants.imageWidth
            imageView.height == BaseViewControllerConstants.imageHeight
        }
        imageView.image = UIImage(named: "arrow_left_icon")
        imageView.tintColor = CommonConstants.iconEnabledTintColor
        button.addTarget(self, action: #selector(BaseViewController.actionBackDefault(button:)), for: .touchUpInside)
        let naviItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = naviItem
    }
    
    @objc func actionBackDefault(button: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
