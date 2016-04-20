//
//  MeeViewController.m
//  MeeViews
//
//  Created by liwei on 16/4/20.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeePicViewController.h"
#import "SDCycleScrollView.h"

@interface MeePicViewController ()<SDCycleScrollViewDelegate>

@end

@implementation MeePicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.73 green:0.82 blue:0.71 alpha:1.00];
   
    [self setupUI];
}


- (void)setupUI
{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(0, 1200);
    scrollView.backgroundColor = [UIColor colorWithRed:0.23 green:0.56 blue:0.62 alpha:1.00];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:scrollView];
    
    
    // 设置轮播器 图片数据
    // 情景一：采用本地图片实现
    NSArray *imageNames = @[@"0.jpg",
                            @"1.jpg",
                            @"2.jpg",
                            @"3.jpg",
                            @"4.jpg" // 本地图片请填写全名
                            ];
    
    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    // 情景三：图片配文字
    NSArray *titles = @[@"新建交流QQ群：185534916 ",
                        @"感谢您的支持，如果下载的",
                        @"如果代码在使用过程中出现问题",
                        @"您可以发邮件到gsdios@126.com"
                        ];
    
    
     // 本地加载 图片数据的轮播器
    SDCycleScrollView *cycleScrollView1 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, MeeScreenW, 240) imageNamesGroup:imageNames];
    cycleScrollView1.delegate = self;
    //设置轮播器图片滚动方向
    cycleScrollView1.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置轮播器动画样式
    cycleScrollView1.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    // 自动滚动间隔时间,默认2s
    cycleScrollView1.autoScrollTimeInterval = 3;
    // 设置轮播器 - 图片带文字
    cycleScrollView1.titlesGroup = titles;
    cycleScrollView1.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    [scrollView addSubview:cycleScrollView1];
    
    
}


#pragma mark - SDCycleScrollViewDelegate

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"轮播图片 ---> %zd",index);
}


@end
