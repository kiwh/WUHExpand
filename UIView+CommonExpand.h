/*
 *  UIView的常用扩展
 *  Created by kiwuh on 15/7/11.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView(Frame)

-(CGFloat)x;
-(void)setX:(CGFloat)x;

-(CGFloat)y;
-(void)setY:(CGFloat)y;

-(CGPoint)origin;
-(void)setOrigin:(CGPoint)point;

-(CGFloat)width;
-(void)setWidth:(CGFloat)wdith;

-(CGFloat)height;
-(void)setHeight:(CGFloat)height;

-(CGSize)size;
-(void)setSize:(CGSize)size;

-(CGRect)frameInWindow;

@end

@interface UIView(layer)

-(void)setCornerRadius:(CGFloat)cornerRadius;

-(void)setBorderColor:(UIColor*)borderColor;

-(void)setBorderWidth:(CGFloat)borderWidth;

@end

@interface UIView(subView)

-(void)removeAllSubViews;

@end

