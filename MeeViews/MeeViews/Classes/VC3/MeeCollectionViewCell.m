//
//  MeeCollectionViewCell.m
//  MeeViews
//
//  Created by liwei on 16/4/20.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeeCollectionViewCell.h"

@interface MeeCollectionViewCell ()

@property (nonatomic, weak)  UIImageView  * imageView;

@end


@implementation MeeCollectionViewCell

// 进行cell的一些初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        
        // 圆角/白边
        self.layer.cornerRadius = 20;
        self.layer.masksToBounds = YES;
        
        self.layer.borderWidth = 2;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        
        
        // 添加一个 UIImageView
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = self.bounds;
        self.imageView = imageView;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:imageView];
    }
    return self;
}

- (void)setImageNameStr:(NSString *)imageNameStr
{
    _imageNameStr = imageNameStr;
    UIImage *image = [UIImage imageNamed:imageNameStr];
    if (image == nil) {
        self.imageView.image = [UIImage sd_animatedGIFNamed:imageNameStr]; // gif
        if (self.imageView.image == nil) { // jpg
            NSString *newImageName = [NSString stringWithFormat:@"%@.jpg",imageNameStr];
            self.imageView.image = [UIImage imageNamed:newImageName];
        }
    }else {
        self.imageView.image = [UIImage imageNamed:imageNameStr];  // png
    }
}


@end
