//
//  UIView+FindUIViewController.m
//  SingleToMingle
//
//  Created by Nguyen Van Tu on 11/13/17.
//  Copyright © 2017 pehsys. All rights reserved.
//

#import "UIView+FindUIViewController.h"

@implementation UIView (FindUIViewController)
- (UIViewController *) firstAvailableUIViewController {
    // convenience function for casting and to "mask" the recursive function
    return (UIViewController *)[self traverseResponderChainForUIViewController];
}

- (id) traverseResponderChainForUIViewController {
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBar = nextResponder;
        UINavigationController  *nav = tabBar.viewControllers[0];
        NSArray *viewControllers = nav.viewControllers;
        UIViewController *rootViewController = [viewControllers objectAtIndex:viewControllers.count - 2];
        return  rootViewController;
    } else if([nextResponder isKindOfClass:[UIViewController class]])
    {
         return nextResponder;
    }
    else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder traverseResponderChainForUIViewController];
    } else {
        return nil;
    }
}
@end
