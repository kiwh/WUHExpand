//
//  UIButton+WuhaoCategory.h
//  Y9Mobile
//
//  Created by kinki on 15/5/4.
//  Copyright (c) 2015年 DJSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIButton(FillColor)

/**
 *  设置相关状态下的按钮点击背景色
 *
 *  @param backgroundColor 相应的点击背景色
 *  @param state           状态
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state ;

/**
 *  返回相应颜色的图片
 *
 *  @param color 颜色
 *
 *  @return 纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color ;

@end

/**
 *  UIColor分类
 */
@interface UIColor(hexColor)

/**
 *  解析十六进制颜色
 *
 *  @param hexColor 十六进制颜色值
 *
 *  @return 相应的颜色
 */
+(UIColor *)getColorFromHex:(NSInteger)hexColor;

@end
