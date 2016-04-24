//
//  MeePhoCollectionFlowLayout.m
//  MeeViews
//
//  Created by 扬帆起航 on 16/4/23.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeePhoCollectionFlowLayout.h"

@implementation MeePhoCollectionFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置cell的尺寸
    self.itemSize = CGSizeMake(self.collectionView.width * 0.5 - 10, self.collectionView.height - 10);
    // 每行的间距
    // self.minimumLineSpacing = 8;
    // 每个cell之间的间距
    // self.minimumInteritemSpacing = 0;
    
    // 设置cell内边距
    // 注意：设置内边距，不能超过 collectionView 宽高，要不然会有警告报错
//    self.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
}

@end
