//
//  NVTApplication.h
//  SingleToMingle
//
//  Created by Nguyen Van Tu on 11/13/17.
//  Copyright © 2017 pehsys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#define kApplicationTimeoutInMinutes 10
#define kApplicationDidTimeoutNotification @"ApplicationDidTimeout"
@interface NVTApplication : UIApplication
{
    NSTimer *_idleTimer;
}

- (void)resetIdleTimer;
@end
