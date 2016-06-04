//
//  UIImage+LBImage.m
//  彩票
//
//  Created by 林彬 on 16/3/5.
//  Copyright © 2016年 linbin. All rights reserved.
//

#import "UIImage+LBImage.h"

@implementation UIImage (LBImage)

// 添加类扩展,返回的是未被渲染的图片
+ (UIImage *)imageOriRenderNamed:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    
    
    // 返回不渲染的图片
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

+(UIImage*)originImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}


+ (UIImage *)imageWithBorder:(CGFloat)borderW color:(UIColor *)boderColor image:(UIImage *)oriImage
{
    
    //1.确定边框的宽度
    //CGFloat borderW = 10;
    //2.加载图片
    //UIImage *oriImage = [UIImage imageNamed:@"阿狸头像"];
    //3.开启位图上下文(大小 原始图片的宽高度+ 2 *边框宽度)
    CGSize size = CGSizeMake(oriImage.size.width + 2 * borderW, oriImage.size.height + 2 * borderW);
    UIGraphicsBeginImageContext(size);
    //4.绘制边框(大圆)
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [boderColor set];
    [path fill];
    //5.绘制小圆(把小圆设置成裁剪区域)
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderW, borderW, oriImage.size.width, oriImage.size.height)];
    [clipPath addClip];
    //6.把图片绘制到上下文当中
    [oriImage drawAtPoint:CGPointMake(borderW, borderW)];
    //7.从上下文当中生成图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //8.关闭上下文.
    UIGraphicsEndImageContext();
    
    return newImage;
    
}
@end
