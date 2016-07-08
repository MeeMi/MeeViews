//
//  MeeRootTableTableViewController.m
//  MeeViews
//
//  Created by liwei on 16/7/7.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeeRootTableViewController.h"
#import "MeeRootTableView.h"

#define MeeHeadViewH 200
#define MeeHeadViewMinH 64
#define MeeTabBarH 44

@interface MeeRootTableViewController ()

@property (nonatomic, assign) CGFloat lastOffsetY;/** y方向上的偏移量 */

@end

@implementation MeeRootTableViewController

- (void)loadView
{
    // 替换点原来的 tableView
    MeeRootTableView *meeTableView = [[MeeRootTableView alloc]init];
    meeTableView.frame = [UIScreen mainScreen].bounds;
    meeTableView.delegate = self;
    meeTableView.dataSource = self;
    self.tableView = meeTableView;
    self.view = meeTableView;
    meeTableView.autoresizingMask = UIViewAutoresizingNone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lastOffsetY = - (MeeHeadViewH + MeeTabBarH);
    
    // 设置tableView 滚动的范围
    self.tableView.contentInset = UIEdgeInsetsMake(MeeHeadViewH + MeeTabBarH, 0, 0, 0);
    
    
    MeeRootTableView *tableView = (MeeRootTableView *)self.tableView;
    tableView.tabBar = self.tabBar;
}

// 监听 ScroolView 的滚动，不断的改变图片的高度 和 导航条的透明度
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取tableView 拖动后的最新偏移位置
    CGFloat offsetY = scrollView.contentOffset.y;
    // 最新的偏移量减去最初的偏移量，为偏移差
    CGFloat delta = offsetY - self.lastOffsetY;
    // 改变图片的高度约束
    CGFloat headH = MeeHeadViewH - delta;
    if (headH < MeeHeadViewMinH) {
        headH = MeeHeadViewMinH;
    }
    self.headHCons.constant = headH;
    
    // 计算透明度
    CGFloat alpha = delta / (MeeHeadViewH - MeeHeadViewMinH);
    // 获取透明颜色
    UIColor *alphaColor = [UIColor colorWithWhite:0 alpha:alpha];
    [self.titleLabel setTextColor:alphaColor];
    
    // 设置导航条背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:1.0 alpha:alpha]] forBarMetrics:UIBarMetricsDefault];
    
}


@end
