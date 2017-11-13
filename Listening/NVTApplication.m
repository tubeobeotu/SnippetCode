//
//  NVTApplication.m
//  SingleToMingle
//
//  Created by Nguyen Van Tu on 11/13/17.
//  Copyright © 2017 pehsys. All rights reserved.
//

#import "NVTApplication.h"
#import "AppDelegate.h"
#import "UIView+FindUIViewController.h"
@implementation NVTApplication
- (void)sendEvent:(UIEvent *)event
{
    NSLog(@"%@", event.classForCoder);
    [super sendEvent:event];
    // Fire up the timer upon first event
    if(!_idleTimer) {
        [self resetIdleTimer];
    }
    
    // Check to see if there was a touch event
    NSSet *allTouches  = [event allTouches];
    
    if  ([allTouches count] > 0)
    {
        UITouchPhase phase  = ((UITouch *)[allTouches anyObject]).phase;
        if  (phase == UITouchPhaseBegan)
        {
            [self resetIdleTimer];
        }
        if (phase == UITouchPhaseEnded)
        {
            UIView *mainView = [[UIApplication sharedApplication] keyWindow];
            CGPoint location = [[allTouches anyObject] locationInView:mainView];
            CGRect fingerRect = CGRectMake(location.x-5, location.y-5, 10, 10);
            
            for(UIView *view in mainView.subviews){
                CGRect subviewFrame = view.frame;
                
                if(CGRectIntersectsRect(fingerRect, subviewFrame)){
                    //we found the finally touched view
                    UIViewController *vc = [view firstAvailableUIViewController];
                    NSLog(@"");
//                    NSLog(@"Yeah !, i found it %@",NSStringFromClass([[view firstAvailableUIViewController] class]));
                }
                
            }
        }
    }
}

- (void)resetIdleTimer
{
    NSString *sourceString = [[NSThread callStackSymbols] objectAtIndex:1];
    // Example: 1   UIKit                               0x00540c89 -[UIApplication _callInitializationDelegatesForURL:payload:suspended:] + 1163
    NSCharacterSet *separatorSet = [NSCharacterSet characterSetWithCharactersInString:@" -[]+?.,"];
    NSMutableArray *array = [NSMutableArray arrayWithArray:[sourceString  componentsSeparatedByCharactersInSet:separatorSet]];
    [array removeObject:@""];
    
    NSLog(@"Stack = %@", [array objectAtIndex:0]);
    NSLog(@"Framework = %@", [array objectAtIndex:1]);
    NSLog(@"Memory address = %@", [array objectAtIndex:2]);
    NSLog(@"Class caller = %@", [array objectAtIndex:3]);
    NSLog(@"Function caller = %@", [array objectAtIndex:4]);
    if  (_idleTimer)
    {
        [_idleTimer invalidate];
    }
    
    // Schedule a timer to fire in kApplicationTimeoutInMinutes * 60
    
    //  int timeout =   [AppDelegate getInstance].m_iInactivityTime;
    int timeout =   3;
    _idleTimer = [NSTimer scheduledTimerWithTimeInterval:timeout
                                                  target:self
                                                selector:@selector(idleTimerExceeded)
                                                userInfo:nil
                                                 repeats:NO];
    
}

- (void)idleTimerExceeded
{
    /* Post a notification so anyone who subscribes to it can be notified when
     * the application times out */
    
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:kApplicationDidTimeoutNotification object:nil];
}

//Register a notification for your corresponding view controller
//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidTimeout:) name:kApplicationDidTimeoutNotification object:nil];

//once the timeout occur the notification will fire and handle the event like this
//- (void) applicationDidTimeout:(NSNotification *) notif //inactivity lead to any progress
//{
//    NSArray *syms = [NSThread  callStackSymbols];
//    if ([syms count] > 1) {
//        NSLog(@"NVT_LOG:<%@ %p> %@ - caller: %@ ", [self class], self, NSStringFromSelector(_cmd),[syms objectAtIndex:1]);
//    } else {
//        NSLog(@"NVT_LOG:<%@ %p> %@", [self class], self, NSStringFromSelector(_cmd));
//    }
//
//}
@end
