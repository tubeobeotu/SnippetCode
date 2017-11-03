//
//  UINavigationController+FakeAnimation.m
//  SingleToMingle
//
//  Created by Nguyen Van Tu on 11/3/17.
//  Copyright © 2017 pehsys. All rights reserved.
//

#import "UINavigationController+FakeAnimation.h"

@implementation UINavigationController (FakeAnimation)
- (void)pushViewControllerWithFakeAnimation:(UIViewController *)viewcontroller
{
    [self.topViewController.view setHidden:true];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.001 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.topViewController.view setHidden:false];
        CATransition *transition = [[CATransition alloc] init];
        transition.duration = 0.3;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromRight;
        [self.view.layer addAnimation:transition forKey:kCATransition];
        [self pushViewController:viewcontroller animated:false];
    });
    
}
@end
