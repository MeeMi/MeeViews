//
//  MeeWaterflowController1.m
//  MeeViews
//
//  Created by liwei on 16/4/25.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeeWaterflowController1.h"
#import "MeeWaterflowLayout.h"
#import "MeeWaterFlowCell.h"



static NSString * const cellID = @"MeeWaterFlowCell";

@interface MeeWaterflowController1 ()<UICollectionViewDelegate,UICollectionViewDataSource,MeeWaterflowLayoutDelegate>

@end

@implementation MeeWaterflowController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    MeeWaterflowLayout *layout = [[MeeWaterflowLayout alloc]init];
    layout.delegate = self;
    
    // 创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
 
    
    collectionView.backgroundColor = MeeRandomColor;
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [self.view addSubview:collectionView];
    
    // 注册cell
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MeeWaterFlowCell class]) bundle:nil] forCellWithReuseIdentifier:cellID];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MeeWaterFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
     cell.label.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    // cell.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%zd ---- > 被点击",indexPath.item);
}


#pragma mark - MeeWaterflowLayoutDelegate

// 必须实现每个cell的高度
- (CGFloat)waterflowLayout:(MeeWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth
{
    // arc4random_uniform会随机返回一个0到上界之间（不含上界）的整数。以2为上界会得到0或1，像投硬币一样
    return 50 + arc4random_uniform(50);
}

// 可选实现的方法

// 列数
- (CGFloat)columnCountInWaterflowLayout:(MeeWaterflowLayout *)waterflowLayout
{
    // 设置瀑布流有几列，默认是 3列
    return 4;
}

// 行间距
- (CGFloat)rowMarginInWaterflowLayout:(MeeWaterflowLayout *)waterflowLayout
{
    // 默认是 10
    return 5;
}

// 列间距
- (CGFloat)columnMarginInWaterflowLayout:(MeeWaterflowLayout *)waterflowLayout
{
    // 默认是 10
    return 5;
}

// 设置CollectionView的内边距
//- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(MeeWaterflowLayout *)waterflowLayout
//{
//    return UIEdgeInsetsMake(20, 10, 30, 15);
//}



@end
