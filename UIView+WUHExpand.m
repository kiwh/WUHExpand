
#import "UIView+WUHExpand.h"

@implementation UIView(Frame)

-(CGFloat)x
{
    return self.frame.origin.x;
}

-(void)setX:(CGFloat)x
{
    self.frame = CGRectMake(x, self.frame.origin.y, self.bounds.size.width, self.bounds.size.height);
}

-(CGFloat)y
{
    return self.frame.origin.y;
}

-(void)setY:(CGFloat)y
{
    self.frame = CGRectMake(self.frame.origin.x, y, self.bounds.size.width, self.bounds.size.height);
}

-(CGPoint)origin
{
    return self.frame.origin;
}

-(void)setOrigin:(CGPoint)point
{
    self.frame = CGRectMake(point.x, point.y, self.width, self.height);
}

-(CGFloat)width
{
    return self.bounds.size.width;
}

-(void)setWidth:(CGFloat)width
{
    self.frame = CGRectMake(self.x, self.y, width, self.height);
}

-(CGFloat)height
{
    return self.bounds.size.height;
}

-(void)setHeight:(CGFloat)height
{
    self.frame = CGRectMake(self.x, self.y, self.width, height);
}

-(CGSize)size
{
    return self.bounds.size;
}

-(void)setSize:(CGSize)size
{
    self.frame = CGRectMake(self.x, self.y, size.width, size.height);
}

-(CGRect)frameInWindow
{
    return [self.superview convertRect:self.frame toView:self.window];
}

@end

@implementation UIView(layer)

-(void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
}

-(void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

-(void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

@end

@implementation UIView(subView)

-(void)RemoveAllSubViews
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

-(UIView *)GetSubViewByTag:(NSInteger)tag
{
    __block UIView * subView;
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([[obj valueForKey:@"tag"] integerValue] == tag) {
            subView = obj;
        }
    }];
    return subView;
}

@end
