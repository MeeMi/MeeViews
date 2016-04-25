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

/** 标记属性 */
@property(nonatomic, assign)BOOL flag;

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
    //设置轻拍手势
    //首先打开imageView的用户交互,默认是关闭
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapImageView:)];
    tapGesture.numberOfTapsRequired = 2;
    [imageView addGestureRecognizer:tapGesture];
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

//   正在缩放的时候调用 （调用频率非常高）
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    // 放大缩小图片时候，图片的中心位置设定
    // 方式一：
//    self.imageView.centerX = MeeScreenW * 0.5;
//    self.imageView.centerY = MeeScreenH * 0.5;
    
    
    // 方式二：
    CGFloat t_zs = scrollView.zoomScale;
    t_zs = MAX(t_zs, 0.9f);
    t_zs = MIN(t_zs, 5.0f);
    
    CGFloat x = scrollView.frame.size.width/2;
    CGFloat y = scrollView.frame.size.height/2;
    
    x = scrollView.contentSize.width > scrollView.frame.size.width? scrollView.contentSize.width/2: x;
    y = scrollView.contentSize.height > scrollView.frame.size.height? scrollView.contentSize.height/2: y;
    
    [self.imageView setCenter:CGPointMake(x, y)];
    
    // 方式三：
//    CGFloat x = scrollView.contentSize.width < scrollView.bounds.size.width ? (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
//    CGFloat y = scrollView.contentSize.height < scrollView.bounds.size.height ? (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
//    self.imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + x, scrollView.contentSize.height * 0.5 + y);
}


//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale
//{
//    [scrollView setZoomScale:scale+0.01 animated:NO];
//    [scrollView setZoomScale:scale animated:NO];
//}

#pragma mark 轻拍方法 - 轻点放大，放大位置不变

- (void)didTapImageView:(UITapGestureRecognizer *)tap
{
    //这个是要获取当前点击的小滚动视图,而小滚动视图我们没有设置属性,无法在这儿获取
    //当前点击视图的父视图,其实就是当前点击的小滚动视图,就通过这种方法获取滚动视图对象
    UIScrollView *scroll = (UIScrollView *)tap.view.superview;
    if (_flag == NO) {
        CGRect newRect = [self zoomRectByScale:2.0 Center:[tap locationInView:tap.view]];
        //zoomToRect方法是UIScrollVie对象的方法,将图片相对放大
        [scroll zoomToRect:newRect animated:YES];
        _flag = YES;
    }else {
        [scroll setZoomScale:1 animated:YES];
        _flag = NO;
    }
}

#pragma mark 自定义方法,获取放大后显示的矩形区域
- (CGRect)zoomRectByScale:(CGFloat)scale Center:(CGPoint)center
{
    CGRect zoomRect;
    //求出新的长和宽
    zoomRect.size.width = MeeScreenW / scale;
    zoomRect.size.height = MeeScreenH / scale;
    
    //找到新的原点
    zoomRect.origin.x = center.x * (1 - 1/scale);
    zoomRect.origin.y = center.y * (1 - 1/scale);
    
    return zoomRect;
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
