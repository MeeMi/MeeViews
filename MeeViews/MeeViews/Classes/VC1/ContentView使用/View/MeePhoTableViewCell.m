//
//  MeePhoTableViewCell.m
//  MeeViews
//
//  Created by liwei on 16/4/21.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeePhoTableViewCell.h"
#import "UIImageView+WebCache.h"

#import "MeeShowBigPicViewController.h"

@interface MeePhoTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *meeImageView;


// @property (nonatomic, strong)  NSArray  * imageUrls;

@end

@implementation MeePhoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 通过了 frame 设置了从 xib加载的View，就要禁止掉 View的自动拉伸
    // self.autoresizingMask = UIViewAutoresizingNone;
    
    // 保持图片的宽高比进行缩放,宽或者高度达到吻合就居中显示
    self.meeImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    // 让超出的部分剪切掉
    self.meeImageView.clipsToBounds = YES;
    
    // 给图片添加手势
    self.meeImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeBigPictureClick)];
    [self.meeImageView addGestureRecognizer:tap];
    
    
    // 设置cell 圆角白边
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 1;
}


- (void)seeBigPictureClick
{
    NSLog(@"手势点击");
    MeeShowBigPicViewController *showVc = [[MeeShowBigPicViewController alloc]init];
    showVc.picNumOrUrlStr = self.imageUrls[self.indexpath.row];
    [self.window.rootViewController presentViewController:showVc animated:YES completion:nil];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    // self.meeImageView.width = MeeScreenW * 0.5;
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
    //[self.meeImageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrls[indexpath.row]]];
    [self.meeImageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrls[indexpath.row]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //图片处理
        if (image == nil) return ; // 表示图片下载失败
        // 这个可以把图片处理成 圆角
        // self.meeImageView.image = [image drawRoundRectImage];
    }];
    
}

@end
