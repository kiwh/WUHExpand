//
//  UIButton+WuhaoCategory.m
//  Y9Mobile
//
//  Created by kinki on 15/5/4.
//  Copyright (c) 2015年 DJSoft. All rights reserved.
//

#import "UIButton+CommonExpand.h"

@implementation UIButton(FillColor)
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

@implementation UIColor(hexColor)

+(UIColor *)getColorFromHex:(NSInteger)hexColor
{
    return [UIColor colorWithRed:((hexColor >> 16) & 0xFF)/255.0f
                    green:((hexColor >>  8) & 0xFF) /255.0f
                     blue:((hexColor >>  0) & 0xFF) / 255.0f
                           alpha:((hexColor >> 24) & 0xFF) / 255.0f];
}

@end
