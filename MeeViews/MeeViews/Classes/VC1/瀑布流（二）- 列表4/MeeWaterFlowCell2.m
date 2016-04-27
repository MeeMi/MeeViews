//
//  MeeWaterFlowCell2.m
//  MeeViews
//
//  Created by liwei on 16/4/27.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeeWaterFlowCell2.h"

@implementation MeeWaterFlowCell2


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = self.bounds;
        self.imageView = imageView;
        [self addSubview:imageView];
    }
    return self;
}

@end
