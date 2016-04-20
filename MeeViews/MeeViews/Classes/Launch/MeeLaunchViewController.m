//
//  MeeLaunchViewController.m
//  MeeViews
//
//  Created by liwei on 16/4/20.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeeLaunchViewController.h"

#import "MeeTabBarController.h"

@interface MeeLaunchViewController ()

@end


// 自定义 软件启动的动画页面
@implementation MeeLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = nil;
    if (self.view.bounds.size.width == 414.0) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 260)];
    }else{
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, 250)];
    }
    
    UIImage *gifImage = [UIImage sd_animatedGIFNamed:@"iPhone-6-Crop"];
    imageView.image = gifImage;
    [self.view addSubview:imageView];
    
    
    [UIView animateWithDuration:0.3 delay:1.6 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        imageView.alpha = 0.001;
    } completion:^(BOOL finished) {
        
            // 设置转场动画
            CATransition *anim = [CATransition animation];
            // 动画类型
            anim.type = @"rippleEffect";  // 水滴效果
            // 转场时间
            anim.duration = 1.5;
            // 添加转场动画
            [self.view.window.layer addAnimation:anim forKey:nil];
            
            MeeTabBarController *tabVc = [[MeeTabBarController alloc]init];
            self.view.window.rootViewController = tabVc;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
