//
//  MeeTabBarController.m
//  MeeViews
//
//  Created by 扬帆起航 on 16/4/18.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeeTabBarController.h"
#import "MeeNavigationController.h"

#import "MeeVC1.h"
#import "MeeVC2.h"
#import "MeeVC3.h"

#import "MeePhtViewController.h"

@interface MeeTabBarController ()

@end

@implementation MeeTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    // 设置子控制器
    [self setupChildVc];
}


#pragma mark - 设置子控制
- (void)setupChildVc
{
//    MeeVC1 *vc1 = [[MeeVC1 alloc]init];
//    MeeNavigationController *nav = [[MeeNavigationController alloc]initWithRootViewController:vc1];
//    vc1.title = @"vc1";
//    vc1.tabBarItem.image = [UIImage imageNamed:@"tab_home_icon"];
//    [self addChildViewController:nav];
//    
//    
//    MeeVC2 *vc2 = [[MeeVC2 alloc]init];
//    MeeNavigationController *nav2 = [[MeeNavigationController alloc]initWithRootViewController:vc2];
//    vc2.title = @"vc2";
//    vc2.tabBarItem.image = [UIImage imageNamed:@"js"];
//    [self addChildViewController:nav2];
    
     MeeVC1 *vc1 = [[MeeVC1 alloc]init];
    [self setupOneChildVc:vc1 andImage:@"tab_home_icon" andTitle:@"功能列表"];
    
    MeeVC2 *vc2 = [[MeeVC2 alloc]init];
    [self setupOneChildVc:vc2 andImage:@"js" andTitle:@"vc2"];
    
    
    MeeVC3 *vc3 = [[MeeVC3 alloc]init];
    [self setupOneChildVc:vc3 andImage:@"qw" andTitle:@"CollectionView卡片"];
    
}

#pragma mark - 设置单独一个导航控制器
// 减少代码的复用性
- (void)setupOneChildVc:(UIViewController *)vc andImage:(NSString *)imageStr andTitle:(NSString *)title
{
    MeeNavigationController *nav = [[MeeNavigationController alloc]initWithRootViewController:vc];
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageStr];
    [self addChildViewController:nav];
}


@end
