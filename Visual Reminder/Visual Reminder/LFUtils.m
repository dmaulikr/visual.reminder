//
//  LFUtils.m
//  Visual Reminder
//
//  Created by Vincent on 10/09/13.
//  Copyright (c) 2013 Little Factory. All rights reserved.
//

#import "LFUtils.h"

@implementation LFUtils

+ (UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    return alertView;
}

@end
