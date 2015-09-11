/*
 *  UIView的常用扩展
 *  Created by kiwuh on 15/7/11.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIView(Frame)

/** self.frame.origin.x */
-(CGFloat)x;
-(void)setX:(CGFloat)x;

/** self.frame.origin.y */
-(CGFloat)y;
-(void)setY:(CGFloat)y;

/** self.frame.origin */
-(CGPoint)origin;
-(void)setOrigin:(CGPoint)point;

/** self.bounds.size.width */
-(CGFloat)width;
-(void)setWidth:(CGFloat)wdith;

/** self.bounds.size.height */
-(CGFloat)height;
-(void)setHeight:(CGFloat)height;

/** self.bounds.size */
-(CGSize)size;
-(void)setSize:(CGSize)size;

/** 
 * 自身frame相对于window中的frame
 */
-(CGRect)frameInWindow;

@end

@interface UIView(layer)

/** 圆角 */
-(void)setCornerRadius:(CGFloat)cornerRadius;

/** 边线颜色 */
-(void)setBorderColor:(UIColor*)borderColor;

/** 边线宽度 */
-(void)setBorderWidth:(CGFloat)borderWidth;

@end

@interface UIView(subView)

/** remove所有的子视图 */
-(void)RemoveAllSubViews;

/** 取出相应tag的子视图 */
-(UIView*)GetSubViewByTag:(NSInteger)tag;

@end

