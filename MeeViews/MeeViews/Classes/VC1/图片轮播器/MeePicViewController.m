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

@property (nonatomic, weak)  SDCycleScrollView  * cycleScrollView1;
@property (nonatomic, weak)  SDCycleScrollView  * cycleScrollView3;

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
                                  @"http://ww3.sinaimg.cn/mw1024/00654QmXjw1er0kabvl2rj31jk111n4v.jpg",
                                  @"http://ww2.sinaimg.cn/mw1024/00654QmXjw1eqxffywbcjj31jk111av8.jpg",
                                  @"http://ww4.sinaimg.cn/mw1024/00654QmXjw1eqxfg4lnckj31jk111x3b.jpg",
                                  @"http://ww3.sinaimg.cn/mw1024/00654QmXjw1eqxfg31wlej31jk1117mj.jpg"
                                  ];
    
    // 情景三：图片配文字
    NSArray *titles = @[@"新建交流QQ群：185534916 ",
                        @"感谢您的支持，如果下载的",
                        @"如果代码在使用过程中出现问题",
                        @"您可以发邮件到gsdios@126.com"
                        ];
    
#pragma mark - 本地图片轮播器
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
    
    self.cycleScrollView1 = cycleScrollView1;
    
    [scrollView addSubview:cycleScrollView1];
    
    
#pragma mark - 网络图片轮播器
    // SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:<#(CGRect)#> imageURLStringsGroup:<#(NSArray *)#>];
    
    SDCycleScrollView *cycleScrollView3 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 310, MeeScreenW, 180) delegate:self placeholderImage:[UIImage imageNamed:@"ermilio"]];
    // 自定义分组控件小圆圈的颜色
    cycleScrollView3.currentPageDotColor = [UIColor colorWithRed:0.31 green:0.76 blue:0.91 alpha:1.00];
    // 自定义分组控件的图片
    // cycleScrollView3.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    // cycleScrollView3.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    // 设置网络图片数据
    cycleScrollView3.imageURLStringsGroup = imagesURLStrings;
    // 滚动方向
    cycleScrollView3.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.cycleScrollView3 = cycleScrollView3;
    [scrollView addSubview:cycleScrollView3];
    
    /*
     block监听点击方式
     
     cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
     NSLog(@">>>>>  %ld", (long)index);
     };
     
     */
}




#pragma mark - SDCycleScrollViewDelegate

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (cycleScrollView == self.cycleScrollView1) {
        NSLog(@"cycleScrollView1 - 轮播图片 ---> %zd",index);
    }else{
        NSLog(@"cycleScrollView3 - 轮播图片 ---> %zd",index);
    }
    
}


@end
