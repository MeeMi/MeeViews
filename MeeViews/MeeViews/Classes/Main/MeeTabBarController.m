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
#import "MeeVC2.h"

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
    MeeVC1 *vc1 = [[MeeVC1 alloc]init];
    MeeNavigationController *nav = [[MeeNavigationController alloc]initWithRootViewController:vc1];
    [self addChildViewController:nav];
}


@end
