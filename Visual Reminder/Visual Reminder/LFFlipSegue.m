//
//  LFFlipSegue.m
//  Visual Reminder
//
//  Created by Vincent on 10/09/13.
//  Copyright (c) 2013 Little Factory. All rights reserved.
//

#import "LFFlipSegue.h"

@implementation LFFlipSegue

- (void)perform
{
    UIView *sourceView = ((UIViewController *) self.sourceViewController).view;
    UIView *destinationView = ((UIViewController *) self.destinationViewController).view;
    [UIView transitionFromView:sourceView
                        toView:destinationView
                      duration:0.5
                       options:[self flipOption]
                    completion:nil];
}

@end
