//
//  MeeWaterFlowCell2.m
//  MeeViews
//
//  Created by liwei on 16/4/27.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeeWaterFlowCell2.h"

#define  angelToRandian(angle) (angle / 180.0 * M_PI)

@implementation MeeWaterFlowCell2


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc]init];
        
        
        // imageView.userInteractionEnabled = YES;
        // 添加手势
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        [imageView addGestureRecognizer:longPress];
        self.imageView = imageView;
        [self addSubview:imageView];
    }
    return self;
}

// 1.当控件显示到屏幕上时会调用一次layoutSubviews
// 2.当控件的尺寸发生改变的时候会调用一次layoutSubviews
// 注意：一定要在 layoutSubviews中设置 尺寸
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}

// 长按图片抖动
-(void)longPress:(UILongPressGestureRecognizer*)longPress
{
    if (longPress.state==UIGestureRecognizerStateBegan) {
        
        CAKeyframeAnimation* anim=[CAKeyframeAnimation animation];
        anim.keyPath=@"transform.rotation";
        anim.values=@[@(angelToRandian(-5)),@(angelToRandian(5)),@(angelToRandian(-5))];
        anim.repeatCount=MAXFLOAT;
        anim.duration=0.5;
        [self.imageView.layer addAnimation:anim forKey:nil];
        // self.btn.hidden=NO;
    }
}

@end
