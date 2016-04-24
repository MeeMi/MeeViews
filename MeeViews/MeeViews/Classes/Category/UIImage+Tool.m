//
//  UIImage+Tool.m
//  MeeViews
//
//  Created by liwei on 16/4/22.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "UIImage+Tool.h"

@implementation UIImage (Tool)

// 通过颜色生产一张图片
+ (instancetype)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}

// 生产带圆角的图片
- (UIImage *)drawRoundRectImage
{
     CGRect rect = CGRectMake(0, 0, self.size.width,self.size.height);
    
    // 开启图像
    UIGraphicsBeginImageContext(self.size);
    
    //切圆角(半径)
    float radius = self.size.width / 10;
    // 设置路径
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                cornerRadius:radius];
    // 设置裁剪区
    [path addClip];
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

// 生成圆形的图片
- (instancetype)ImageCrile
{
    // 1.开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    // 2.画圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(context, rect);
    // 3.裁剪
    CGContextClip(context);

    // 4.将下载好的图片画到圆上
    [self drawInRect:rect];
    // 5.获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    // 6.关闭上下文
    UIGraphicsEndImageContext();
    
    // 7.返回图片
    return image;
}

@end
