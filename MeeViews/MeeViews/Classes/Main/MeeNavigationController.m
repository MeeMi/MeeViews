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


// 第一次使用（当类进行或者子类进行用于）
// 作用：初始化类
+ (void)initialize
{
    // 获取全世界的导航条
    UINavigationBar *navBar = [UINavigationBar appearance];
    // 设置导航条的颜色
//     navBar.barTintColor = [UIColor redColor];
    navBar.tintColor = [UIColor redColor]; // 设置导航条的主题颜色
    
    // 设置导航条上面的文字属性
    NSMutableDictionary *muDic = [NSMutableDictionary dictionary];
    muDic[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    muDic[NSForegroundColorAttributeName] = [UIColor redColor];
    [navBar setTitleTextAttributes:muDic];
    
    // 给导航条设置背景图片
    // UIBarMetricsDefault, //背景与图片保存一致
    // UIBarMetricsCompact, 颜色与控制器背景保持一致
    
    // 设置背景 - 解决push 子控制器进来显示阴影
    [navBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    navBar.translucent = YES;
    // 注意bug问题： 当设置 导航条背景图片 不是标准尺寸是 ，需要设置 translucent 为YES，要不然出现（控件增加内边距）
    
//     [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    
    
    
    // 获取取全世界导航条UIBarItem
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    
    // 按钮正常状态
    NSMutableDictionary *attrNormal = [NSMutableDictionary dictionary];
    // 设置字体的大小和颜色
    attrNormal[NSFontAttributeName] = [UIFont systemFontOfSize:20];  // 默认情况下是粗体
    // attrNormal[NSForegroundColorAttributeName] = [UIColor blackColor];
    [barItem setTitleTextAttributes:attrNormal forState:UIControlStateNormal];
    
    // 设置按钮不能点击状态
    NSMutableDictionary *attrDisable = [NSMutableDictionary dictionary];
    // 不设置字体大小，就默认用正常状态下的字体大小
    attrDisable[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [barItem setTitleTextAttributes:attrDisable forState:UIControlStateDisabled];
    
}


@end
