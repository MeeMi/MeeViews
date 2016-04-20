//
//  MeeVC3.m
//  MeeViews
//
//  Created by 扬帆起航 on 16/4/18.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeeVC3.h"
#import "MeeCollectionViewLayout.h"
#import "MeeCollectionViewCell.h"

@interface MeeVC3 ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end


static NSString *const cellID = @"collectionCell";

@implementation MeeVC3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.75 green:0.80 blue:0.81 alpha:1.00];
    
    [self setupCollectionView];
}

#pragma mark- 初始化CollectionView
- (void)setupCollectionView
{
    // 获取布局
    MeeCollectionViewLayout *layout = [[MeeCollectionViewLayout alloc]init];
 
    // 禁止掉设置scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    // 设置collectionView的尺寸
    collectionView.height = MeeScreenH * 0.5;
    collectionView.width = MeeScreenW;
    collectionView.centerX = MeeScreenW * 0.5;
    collectionView.centerY = MeeScreenH * 0.5;
    
    
    // 设置CollectionView的背景颜色
    collectionView.backgroundColor = [UIColor colorWithRed:0.21 green:0.62 blue:0.44 alpha:1.00];
    
    // 设置collectionView的代理
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [self.view addSubview:collectionView];
    
    // 注册collectionViewCell
    [collectionView registerClass:[MeeCollectionViewCell class] forCellWithReuseIdentifier:cellID];
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MeeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
     cell.imageNameStr = @"ermilio";  
//    cell.imageNameStr = @"we.jpg";
//    cell.imageNameStr = @"we";
//    cell.imageNameStr = @"icon_person";
    cell.backgroundColor = MeeRandomColor;
    return cell;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选中 --- > %zd",indexPath.item);
}




@end
