

#import "UIView+GLExtension.h"

@implementation UIView (GLExtension)

- (CGFloat)glh_height
{
    return self.frame.size.height;
}

- (void)setGlh_height:(CGFloat)glh_height
{
    CGRect temp = self.frame;
    temp.size.height = glh_height;
    self.frame = temp;
}

- (CGFloat)glw_width
{
    return self.frame.size.width;
}

- (void)setGlw_width:(CGFloat)glw_width
{
    CGRect temp = self.frame;
    temp.size.width = glw_width;
    self.frame = temp;
}


- (CGFloat)gly_y
{
    return self.frame.origin.y;
}

- (void)setGly_y:(CGFloat)gly_y
{
    CGRect temp = self.frame;
    temp.origin.y = gly_y;
    self.frame = temp;
}

- (CGFloat)glx_x
{
    return self.frame.origin.x;
}

- (void)setGlx_x:(CGFloat)glx_x
{
    CGRect temp = self.frame;
    temp.origin.x = glx_x;
    self.frame = temp;
}

- (CGFloat)glcx_centerX
{
    return self.center.x;
}

- (void)setGlcx_centerX:(CGFloat)glcx_centerX
{
    CGPoint center = self.center;
    center.x = glcx_centerX;
    self.center = center;
}

- (CGFloat)glcy_centerY
{
    return self.center.y;
}

- (void)setGlcy_centerY:(CGFloat)glcy_centerY
{
    CGPoint center = self.center;
    center.y = glcy_centerY;
    self.center = center;
}


/** 利用传入总宽度 - 控件自身的宽度 【获得自己相对父控件的x坐标】 */
- (void)setGlr_right:(CGFloat)glr_right
{
    self.glx_x = glr_right - self.glw_width;
}

/** 利用传入总高度 - 控件自身的高度 【获得自己相对父控件的y坐标】 */
- (void)setGlb_bottom:(CGFloat)glb_bottom
{
    self.gly_y = glb_bottom - self.glh_height;
}

/** 得到自己所在父控件的宽度 */
- (CGFloat)glr_right
{
    //    return self.glx_x + self.glw_width;
    return CGRectGetMaxX(self.frame);
}

/** 得到自己所在父控件的高度 */
- (CGFloat)glb_bottom
{
    //    return self.gly_y + self.glh_height;
   return CGRectGetMaxY(self.frame);
}

- (CGSize)gls_size
{
    return self.frame.size;
}

- (void)setGls_size:(CGSize)gls_size
{
    CGRect frame = self.frame;
    frame.size = gls_size;
    self.frame = frame;
}

@end
