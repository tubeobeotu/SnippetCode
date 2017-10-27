//
//  UITabBarController+Custom.m
//  Sample
//
//  Created by Nguyen Van Tu on 10/27/17.
//  Copyright © 2017 ANPSOFT. All rights reserved.
//

#import "UITabBarController+Custom.h"

@implementation UITabBarController (Custom)
- (void)resize:(CGFloat)scale
{
    UIView *badgeView = [self badgeView];
    if (badgeView) {
        scale = scale == 0 ? 0.5 : scale;
        badgeView.layer.transform = CATransform3DMakeScale(scale, scale, 1);
    }
}
- (void)resize
{
    [self resize: 0];
}
- (void)changePosition:(CGPoint)position
{
    UIView *badgeView = [self badgeView];
    if (badgeView) {
        badgeView.layer.transform = CATransform3DIdentity;
        badgeView.layer.transform = CATransform3DMakeTranslation(position.x, position.y, 1.0);
    }
}

- (UIView *)badgeView
{
    for (UIView *tabBarButton in self.tabBar.subviews)
    {
        for (UIView *badgeView in tabBarButton.subviews)
        {
            NSString *className = NSStringFromClass([badgeView classForCoder]);
            // Looking for _UIBadgeView
            if ([className rangeOfString:@"BadgeView"].location != NSNotFound)
            {
                return badgeView;
            }
        }
    }
    return nil;
}
@end
