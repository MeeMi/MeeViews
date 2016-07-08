//
//  MeeChildViewController.m
//  MeeViews
//
//  Created by liwei on 16/7/8.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeeChildViewController.h"
#import "MeeChild1TableViewController.h"
#import "MeeChild2TableViewController.h"

@interface MeeChildViewController ()

@end

#pragma mark - MeeChildViewController继承MeeRootViewController，是它的子类，对父类的相关的属性进行设置，如：头部图片、导航条上面的名称

@implementation MeeChildViewController


- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 设置头部的 图片
//     self.headerImage = [UIImage sd_animatedGIFNamed:@"joy.gif"];
     self.headerImage = [UIImage imageNamed:@"lol"];
    
    // 设置导航条的标题
    self.title = @"vveii.li";
    
    
    // 添加子控制
    MeeChild1TableViewController *vc1 = [[MeeChild1TableViewController alloc]init];
    vc1.title = @"VC1";
    [self addChildViewController:vc1];
    
    MeeChild2TableViewController *vc2 = [[MeeChild2TableViewController alloc]init];
    vc2.title = @"VC2";
    [self addChildViewController:vc2];
    
}


@end
