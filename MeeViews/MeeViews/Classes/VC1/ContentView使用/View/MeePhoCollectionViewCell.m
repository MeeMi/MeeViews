//
//  MeePhoCollectionViewCell.m
//  MeeViews
//
//  Created by 扬帆起航 on 16/4/23.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeePhoCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface MeePhoCollectionViewCell()

@property (nonatomic, strong) NSArray * imageUrls; /**< 图片url */
@property (nonatomic, weak) UIImageView *imageView; /**< <#注释#> */

@end


@implementation MeePhoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = MeeRandomColor;
        
        UIImageView *imageViwe = [[UIImageView alloc]init];
        imageViwe.frame = self.bounds;
        imageViwe.contentMode = UIViewContentModeScaleAspectFill;
        imageViwe.clipsToBounds = YES; // 超出部分裁剪掉
        self.imageView = imageViwe;
        
        [self addSubview:imageViwe];
        
        
        // 可以对 多个控制器cell写一个父类，里面放些公共属性
        
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 1;
    }
    return self;
}

- (NSArray *)imageUrls
{
    if (_imageUrls == nil) {
        _imageUrls = @[@"http://ww3.sinaimg.cn/mw1024/00654QmXjw1f2pmg0hi5vj311p1kwkfy.jpg",
                       @"http://ww1.sinaimg.cn/mw1024/00654QmXjw1f2pmh3jyp5j311p1kwx2o.jpg",
                       @"http://ww3.sinaimg.cn/mw1024/00654QmXjw1f2hpugnhfcj30o413r4bk.jpg",
                       @"http://ww1.sinaimg.cn/mw1024/00654QmXjw1f17u32hgzpj30sg0iz771.jpg",
                       @"http://ww1.sinaimg.cn/mw1024/00654QmXjw1f17u3410wqj30iz0sgq57.jpg",
                       @"http://ww2.sinaimg.cn/mw1024/00654QmXgw1f0wv5see0rj30qo141k0u.jpg",
                       @"http://ww3.sinaimg.cn/mw1024/00654QmXgw1f0qz1fhsiaj31410qotei.jpg",
                       @"http://ww1.sinaimg.cn/mw1024/00654QmXgw1f0qz1g6q5oj31410qon3m.jpg",
                       @"http://ww1.sinaimg.cn/mw1024/00654QmXgw1f0qz1j2juvj30qo0hrmz2.jpg",
                       @"http://ww1.sinaimg.cn/mw1024/00654QmXgw1f0qz1l2d5lj30qo141qbl.jpg",
                       @"http://ww4.sinaimg.cn/mw1024/00654QmXjw1f08d7yrvzcj30iy0lm776.jpg",
                       @"http://ww2.sinaimg.cn/mw1024/00654QmXjw1ezvaetvpkhj31jk111akc.jpg",
                       @"http://ww4.sinaimg.cn/mw1024/00654QmXjw1ezvaex6fh5j31111jkn80.jpg",
                       @"http://ww2.sinaimg.cn/mw1024/00654QmXjw1ezvaey5tedj31jk11148o.jpg",
                       @"http://ww1.sinaimg.cn/mw1024/00654QmXjw1exlfbzap12j31111jk156.jpg"];
    }
    return _imageUrls;
}


- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrls[indexPath.item]] placeholderImage:[UIImage imageWithColor:[UIColor purpleColor]]];
    
}

@end
