//
//  MeeRootViewController.m
//  MeeViews
//
//  Created by liwei on 16/7/7.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeeRootViewController.h"
#import "MeeRootTableViewController.h"

#define MeeClickBtnObjcKey @"clickBtnObjc"
#define MeeClickBtnNote @"clickBtn"

@interface MeeRootViewController ()

@property (weak, nonatomic) IBOutlet UIView *tabBarView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIView *contentView;/** 子控制内容View */

// 顶部图片的高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewHeightCons;


@property (nonatomic, weak) UILabel *titleLabel;

/** 记录选中的按钮 */
@property (nonatomic, weak)  UIButton  *selectBtn;

@end

@implementation MeeRootViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:@"MeeRootViewController" bundle:nibBundleOrNil]) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MeeRandomColor;
    // 不自动添加额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 接受按钮的点击通知
    [[NSNotificationCenter defaultCenter]addObserverForName:MeeClickBtnNote object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        UIButton *btn = note.userInfo[MeeClickBtnObjcKey];
        [self btnClick:btn];
    }];
}


#pragma mark - 设置导航条
- (void)setupNav
{
    // 设置导航条背景透明
    // UIBarMetricsDefault, //背景与图片保存一致
    // UIBarMetricsCompact, 颜色与控制器背景保持一致
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    
    // 设置中间的View
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont boldSystemFontOfSize:18];
    label.text = self.title;
    [label setTextColor:[UIColor colorWithWhite:1.0 alpha:0]];
    [label sizeToFit];
    self.titleLabel = label;
    self.navigationItem.titleView = label;
    
    
    self.navigationItem.leftBarButtonItem.customView.alpha = 0.3;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear - 0");
    // 即将显示的时候做一次初始化操作
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"viewWillAppear - 1");
    });
    
    
    // 设置导航条
    [self setupNav];

    
    // 设置子控制器
    [self setupChildController];
    
    // 设置tabBar
    [self setupTabBar];
}


#pragma mark - 设置子控制器
- (void)setupChildController
{
    
    // 跟控制上添加的 UITableViewController的子控制器
    
    for (MeeRootTableViewController *rootChildVc in self.childViewControllers) {
        
        self.headerImageView.image = self.headerImage;
        // 传递tabBar,来判断哪个按钮点击
        rootChildVc.tabBar = self.tabBarView;
        
        // 传递高度约束，用来移动头部视图
        rootChildVc.headHCons = self.headerViewHeightCons;
        
        // 传递标题控件，设置文字透明
        rootChildVc.titleLabel = self.titleLabel;
        
    }
}

#pragma mark - 设置tabBar
- (void)setupTabBar
{
    // 遍历子控制器
    for (UIViewController *childVc in self.childViewControllers) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = self.tabBarView.subviews.count;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [btn setTitle:childVc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        // 点击事件
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        // 默认显示第一个视图
        if(btn.tag == 0){
            [self btnClick:btn];
        }
        
        [self.tabBarView addSubview:btn];
    }
}

- (void)btnClick:(UIButton *)btn
{
    // 如果是点击当前的按钮，就不执行
    if (btn == self.selectBtn) {
        return;
    }
    
    // 将上一次的选中的控器的View移除内容视图
    UITableView *lastTableView = (UITableView *)self.childViewControllers[btn.tag].view;
    [lastTableView removeFromSuperview];
    
    // 设置选中按钮
    self.selectBtn.selected = NO;
    btn.selected = YES;
    self.selectBtn = btn;
    
    // 切换内容视图显示
    UITableViewController *tableViewVc = (UITableViewController *)self.childViewControllers[btn.tag];
    tableViewVc.view.frame = self.contentView.bounds;
    [self.contentView addSubview:tableViewVc.view];
    
    // 设置tableView的滚动区域
    // contentOffset 属性用来表示UIScrollView滚动的位置
    tableViewVc.tableView.contentOffset = lastTableView.contentOffset;
}

// 控制器View改变调用
#pragma mark - 这个方法也是专门用来布局子控件（当控制器的view尺寸发生改变的时候会调用）
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // 布局tabBarView上的子控件的位置和尺寸
    NSUInteger count = self.tabBarView.subviews.count;
    
    CGFloat btnW = self.view.width / count;
    CGFloat btnH = self.tabBarView.height;
    CGFloat btnY = 0;
    CGFloat btnX = 0;
    for (int i = 0; i < count; i++) {
        btnX = i * btnW;
        UIView *childBtn = self.tabBarView.subviews[i];
        childBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
