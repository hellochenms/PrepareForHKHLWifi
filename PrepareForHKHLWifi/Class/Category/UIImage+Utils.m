//
//  UIImage+Utils.h
//  M2Common
//
//  Created by chenms.m2 on 15/3/13.
//  Copyright (c) 2015年 chenms.m2 All rights reserved.
//


#import "UIImage+Utils.h"

@implementation UIImage (Utils)
+ (UIImage *)littleImageForColor:(UIColor *)color {
    if (!color) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(10, 10), NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, 10, 10));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
