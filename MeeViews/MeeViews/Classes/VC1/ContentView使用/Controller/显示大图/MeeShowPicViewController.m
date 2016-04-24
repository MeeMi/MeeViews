//
//  MeeShowPicViewController.m
//  MeeViews
//
//  Created by 扬帆起航 on 16/4/24.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeeShowPicViewController.h"

@interface MeeShowPicViewController ()

@property (nonatomic, weak) UIScrollView *scrollView; /**< <#注释#> */

@end

@implementation MeeShowPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupScrollView];
}



- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 设置尺寸 因为View是重xib加载的宽度都是600
    // scrollView.frame = self.view.bounds;
    // 当设置 autoresizingMask ,当View 600 x 6000 缩放到屏幕大小时,scrollView 的尺寸也跟随一起缩放到屏幕大小
    
    // scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    // scrollView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    
    scrollView.frame = [UIScreen mainScreen].bounds;
    scrollView.backgroundColor = [UIColor colorWithRed:0.31 green:0.52 blue:0.34 alpha:1.00];
    self.scrollView = scrollView;
    
    // 这样添加会遮盖 掉 xib上面的空间的
    // [self.view addSubview:self.scrollView];
    [self.view insertSubview:scrollView atIndex:0];
    
    //    UIImageView *imageView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_person"]];
    //    //    imageView1.frame = CGRectMake(100, 100, 100, 100);
    //    //     [self.view addSubview:imageView1];
    //    [self.scrollView addSubview:imageView1];
    
    //    UIImageView *imageView = [[UIImageView alloc]init];
    //    self.imageView = imageView;

    
    // 处理图片
    //[self dealImageView];
}


- (IBAction)backClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
