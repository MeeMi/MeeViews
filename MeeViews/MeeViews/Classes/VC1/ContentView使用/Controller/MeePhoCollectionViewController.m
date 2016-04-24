//
//  MeePhoCollectionViewController.m
//  MeeViews
//
//  Created by liwei on 16/4/21.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeePhoCollectionViewController.h"
#import "MeePhoCollectionViewCell.h"
#import "MeeShowBigPicViewController.h"

@interface MeePhoCollectionViewController ()

@end

@implementation MeePhoCollectionViewController

static NSString * const reuseIdentifier = @"Cell11";

// 设置控制器的布局 - 流水布局
//  注意：这是通过代码创建是指layout才有用，如果是通过 xib 或者是 storyBorad创建的需要在上面设置布局
//- (instancetype)init
//{
//    // 设置流水布局
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    // 设置cell的尺寸
//    layout.itemSize = CGSizeMake(120, self.collectionView.height);
//    // 每行的间距
//    layout.minimumLineSpacing = 8;
//    // 每个cell之间的间距
//    layout.minimumInteritemSpacing = 8;
//    
//    return  [self initWithCollectionViewLayout:layout];
//    
//}





- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTableView];
   
}

- (void)setupTableView
{
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.55 green:0.73 blue:0.95 alpha:1.00];

    self.collectionView.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[MeePhoCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 15;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MeePhoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"UICollectionView ----> %zd",indexPath.row);
    MeeShowBigPicViewController *showVc = [[MeeShowBigPicViewController alloc]init];
    //MeePhoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    MeePhoCollectionViewCell *cell = (MeePhoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    showVc.picNumOrUrlStr = cell.imageUrls[indexPath.item];
    [self presentViewController:showVc animated:YES completion:nil];

}

@end
