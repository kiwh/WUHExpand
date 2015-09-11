//
//  UIImage+CommonExpand.h
//  Y9Mobile
//
//  Created by kinki on 15/7/13.
//  Copyright (c) 2015年 DJSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>
#import <UIKit/UIKit.h>

/** 二维码 */
@interface UIImage(QRImage)

/**
*  生成二维码
*
*  @param string    所扫描的二维码信息
*  @param imageSize 二维码的宽度和高度
*  @param icon      二维码中间添加icon图片的名字
*  @param iconSize  二维码中间icon图片的size
*
*  @return 二维码图像
*/
+ (UIImage *)imageWithQRCodeImageMessage:(NSString *)string imageSize:(CGFloat)imageSize icon:(NSString *)icon iconSize:(CGSize)iconSize;


@end

@interface UIImage(Blur)

/**
 * 默认效果(毛玻璃)
 */
- (UIImage *)imgWithBlur;

/**
*  设置为毛玻璃效果
*
*  @param alpha                 透明度 0~1 白色->深灰色
*  @param radius                半径：默认30 推荐3 越大越模糊，越小越清楚
*  @param colorSaturationFactor 饱和度(浓度) 0黑白灰->9浓彩色，1是原色，默认1.8
*         Saturation 即饱和度。将无彩色的黑白灰定为0，最鲜艳定为9s，这样大致分成十阶段，让数值和人的感官直觉一致。
*  @return 设置效果后的image
*/
- (UIImage *)imgWithLightAlpha:(CGFloat)alpha radius:(CGFloat)radius colorSaturationFactor:(CGFloat)colorSaturationFactor;

@end
