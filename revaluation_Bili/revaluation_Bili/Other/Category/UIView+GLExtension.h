

#import <UIKit/UIKit.h>

@interface UIView (GLExtension)

/** 控件的宽度 */
@property (nonatomic, assign) CGFloat glw_width;
/** 控件的高度 */
@property (nonatomic, assign) CGFloat glh_height;

/** 控件的左边 */
@property (nonatomic, assign) CGFloat glx_x;
/** 控件的顶部 */
@property (nonatomic, assign) CGFloat gly_y;

/** 控件的中心点坐标X,建议设置宽高再设置本属性 */
@property (nonatomic, assign) CGFloat glcx_centerX;
/** 控件的中心点坐标Y,建议设置宽高再设置本属性 */
@property (nonatomic, assign) CGFloat glcy_centerY;

/** 控件的右边 */
@property (nonatomic, assign) CGFloat glr_right;
/** 控件的底部 */
@property (nonatomic, assign) CGFloat glb_bottom;

/** 控件的【宽和高】 */
@property (nonatomic, assign) CGSize gls_size;

@end
