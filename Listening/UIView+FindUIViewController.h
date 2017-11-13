//
//  UIView+FindUIViewController.h
//  SingleToMingle
//
//  Created by Nguyen Van Tu on 11/13/17.
//  Copyright © 2017 pehsys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FindUIViewController)
- (UIViewController *) firstAvailableUIViewController;
- (id) traverseResponderChainForUIViewController;
@end
