//
//  MeeShowBigPicViewController.m
//  MeeViews
//
//  Created by 扬帆起航 on 16/4/23.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeeShowBigPicViewController.h"
#import "SDWebImageManager.h"

@interface MeeShowBigPicViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView; /**< <#注释#> */
@property (nonatomic, weak) UIImageView *imageView; /**< <#注释#> */

@end

@implementation MeeShowBigPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupScrollView];
}


//- (UIScrollView *)scrollView
//{
//    if (_scrollView == nil) {
//        UIScrollView *scrollView = [[UIScrollView alloc]init];
//        scrollView.frame = self.view.bounds;
//        scrollView.backgroundColor = [UIColor colorWithRed:0.99 green:0.83 blue:0.91 alpha:1.00];
//        _scrollView = scrollView;
//        [self.view addSubview:self.scrollView];
//    }
//    return _scrollView;
//}

- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = [UIColor colorWithRed:0.99 green:0.83 blue:0.91 alpha:1.00];
    self.scrollView = scrollView;
    scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 64, 60, 30);
    btn.backgroundColor = [UIColor colorWithRed:0.55 green:0.73 blue:0.95 alpha:1.00];
    [btn setTitle:@"退出" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    // [self.scrollView addSubview:btn];
    [self.view addSubview:btn];
    
    UIImageView *imageView = [[UIImageView alloc]init];

    self.imageView = imageView;
    [self.scrollView insertSubview:self.imageView atIndex:0];
    
    UIImage *image = nil;
    if (![self.picNumOrUrlStr hasPrefix:@"http"])
    {
        image = [UIImage imageNamed:self.picNumOrUrlStr];
        if (image == nil) {
            
            image = [UIImage sd_animatedGIFNamed:self.picNumOrUrlStr];
            self.imageView.image =  image;// gif
    
            if (self.imageView.image == nil) { // jpg
                NSString *newImageName = [NSString stringWithFormat:@"%@.jpg",self.picNumOrUrlStr];
                image = [UIImage imageNamed:newImageName];
                self.imageView.image = image;
            }
        }else {
            self.imageView.image = [UIImage imageNamed:self.picNumOrUrlStr];  // png
        }
    }else{  // 网络图片
        image = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:self.picNumOrUrlStr];
        
    }
    
    self.imageView.image = image;
    [self setImageVieWFrame:image];
}


- (void)setImageVieWFrame:(UIImage *)image
{
    // 设置图片的宽度 默认就是屏幕的宽度
    self.imageView.width = MeeScreenW;
    // 如果图片的高度小于屏幕的高度,就显示在屏幕的中央 (进行等比缩放)
    // 如果图片的高度大于屏幕的高度,就显示在左上角
    self.imageView.height = self.imageView.width / image.size.width * image.size.height;
    if(self.imageView.height >= MeeScreenH){
        self.imageView.x = 0;
        self.imageView.y = 0;
        
    } else{
        self.imageView.centerX = MeeScreenW * 0.5;
        self.imageView.centerY = MeeScreenH * 0.5;
    }
    
    // 设置scrollView内容的范围,使超出了可以滚动
    self.scrollView.contentSize = CGSizeMake(image.size.width, image.size.height);
    
    //[self.scrollView addSubview:self.imageView];
    
    // 设置scrollView的最大缩放和最小缩放比
    if(image.size.height > self.imageView.height){
        self.scrollView.maximumZoomScale = image.size.height / self.imageView.height;
    }
    self.scrollView.minimumZoomScale = 0.5;
    
}


//- (void)setPicNumOrUrlStr:(NSString *)picNumOrUrlStr
//{
//    _picNumOrUrlStr = picNumOrUrlStr;
//    
//    UIImage *image = nil;
//    
//    if (![picNumOrUrlStr hasPrefix:@"http"]) {
//        image = [UIImage imageNamed:picNumOrUrlStr];
//        if (image == nil) {
//            self.imageView.image = [UIImage sd_animatedGIFNamed:picNumOrUrlStr]; // gif
//            if (self.imageView.image == nil) { // jpg
//                NSString *newImageName = [NSString stringWithFormat:@"%@.jpg",picNumOrUrlStr];
//                image = [UIImage sd_animatedGIFNamed:newImageName];
//                self.imageView.image = image;
//            }
//        }else {
//            self.imageView.image = [UIImage imageNamed:picNumOrUrlStr];  // png
//        }
//    }else{
//        image = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:picNumOrUrlStr];
//    }
//    
//    self.imageView.image = image;
//    [self setImageVieWFrame:image];
//}


#pragma mark - UIScrollViewDelegate

// 返回scrollView中的子控件
// 返回要缩放的子控件
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    // 注意:scrollView中的滚动指示器也是View,不能直接获取subView获取子控件返回
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    self.imageView.centerX = MeeScreenW * 0.5;
    self.imageView.centerY = MeeScreenH * 0.5;
    
}



- (void)btnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)dealloc
{
    NSLog(@"控制器销毁");
}

@end
