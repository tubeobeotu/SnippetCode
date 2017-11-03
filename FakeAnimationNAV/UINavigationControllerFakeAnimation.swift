//
//  UINavigationControllerFakeAnimation.swift
//  SingleToMingle
//
//  Created by Nguyen Van Tu on 11/3/17.
//  Copyright © 2017 pehsys. All rights reserved.
//

import Foundation
extension UINavigationController {
    
    public func pushViewController(viewController: UIViewController,
                                   animated: Bool,
                                   completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    public func pushViewControllerWithFakeAnimation(viewcontroller: UIViewController) {
        self.topViewController?.view.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
            self.topViewController?.view.isHidden = false
            let transition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.view.layer.add(transition, forKey: kCATransition)
            self.pushViewController(viewcontroller, animated: false)
        }
    }
}
