//
//  MeePhoTableViewCell.m
//  MeeViews
//
//  Created by liwei on 16/4/21.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeePhoTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface MeePhoTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *meeImageView;


@property (nonatomic, strong)  NSArray  * imageUrls;

@end

@implementation MeePhoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 通过了 frame 设置了从 xib加载的View，就要禁止掉 View的自动拉伸
//    self.autoresizingMask = UIViewAutoresizingNone;
    self.meeImageView.contentMode = UIViewContentModeScaleAspectFill;
    // 让超出的部分剪切掉
    self.meeImageView.clipsToBounds = YES;
 
}

- (NSArray *)imageUrls
{
    if (_imageUrls == nil) {
        _imageUrls = @[@"http://ww4.sinaimg.cn/mw1024/00654QmXjw1euu6jhhnl3j31111jkn56.jpg",
                       @"http://ww1.sinaimg.cn/mw1024/00654QmXjw1esxn7s7re9j30ud1jkqej.jpg",
                       @"http://ww2.sinaimg.cn/mw1024/00654QmXjw1estewoxqcij30qo0zkwlx.jpg",
                       @"http://ww3.sinaimg.cn/mw1024/00654QmXjw1estex7xay1j30qo0zkn4h.jpg",
                       @"http://ww2.sinaimg.cn/mw1024/00654QmXjw1erossy4bg2j31121jkk3v.jpg",
                       @"http://ww1.sinaimg.cn/mw1024/00654QmXjw1eri3138rlvj31jk112jzg.jpg",
                       @"http://ww3.sinaimg.cn/mw1024/00654QmXjw1er3c4oni68j30ww1jkguq.jpg",
                       @"http://ww1.sinaimg.cn/mw1024/00654QmXjw1er0kab2zjwj31111jkteo.jpg"];
    }
    return _imageUrls;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 5;
    frame.origin.x = 5;
    frame.size.width = MeeScreenW - 10;
    [super setFrame:frame];
}

- (void)setIndexpath:(NSIndexPath *)indexpath
{
    _indexpath = indexpath;
    [self.meeImageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrls[indexpath.row]]];
    
}

@end
