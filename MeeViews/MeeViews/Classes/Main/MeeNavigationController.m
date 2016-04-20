//
//  MeeNavigationController.m
//  MeeViews
//
//  Created by 扬帆起航 on 16/4/18.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeeNavigationController.h"

@interface MeeNavigationController ()

@end

@implementation MeeNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// 当push进来子控制，都会调用这个方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 个数等于 0 ,进入主界面设置根控制器
    // 个数等于 1 ,表示压入子控制器
    if (self.childViewControllers.count != 0) {
        // 子控制器进栈之前，隐藏底部的 tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end
