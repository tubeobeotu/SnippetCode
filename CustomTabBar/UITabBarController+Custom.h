//
//  UITabBarController+Custom.h
//  Sample
//
//  Created by Nguyen Van Tu on 10/27/17.
//  Copyright © 2017 ANPSOFT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (Custom)
- (void)resize;
- (void)resize:(CGFloat)scale;
- (void)changePosition:(CGPoint)position;
@end
