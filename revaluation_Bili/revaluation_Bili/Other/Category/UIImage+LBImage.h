//
//  UIImage+LBImage.h
//  彩票
//
//  Created by 林彬 on 16/3/5.
//  Copyright © 2016年 linbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LBImage)
+ (UIImage *)imageOriRenderNamed:(NSString *)name;
+ (UIImage*)originImage:(UIImage *)image scaleToSize:(CGSize)size;
+ (UIImage *)imageWithBorder:(CGFloat)borderW color:(UIColor *)boderColor image:(UIImage *)oriImage;
@end
