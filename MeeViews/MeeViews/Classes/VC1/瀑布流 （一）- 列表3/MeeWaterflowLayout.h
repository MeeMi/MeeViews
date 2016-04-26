//
//  MeeWaterflowLayour.h
//  MeeViews
//
//  Created by liwei on 16/4/25.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MeeWaterflowLayout ;

// 设置代理协议
@protocol MeeWaterflowLayoutDelegate <NSObject>

@required
// 必须实现的方法： 设置每个cell的高度
- (CGFloat)waterflowLayout:(MeeWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional

- (CGFloat)columnCountInWaterflowLayout:(MeeWaterflowLayout *)waterflowLayout;  // 列数
- (CGFloat)columnMarginInWaterflowLayout:(MeeWaterflowLayout *)waterflowLayout; // 列之间的间距
- (CGFloat)rowMarginInWaterflowLayout:(MeeWaterflowLayout *)waterflowLayout; // 行之间间距
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(MeeWaterflowLayout *)waterflowLayout; // 设置CollectionView的内边距


@end

@interface MeeWaterflowLayout : UICollectionViewLayout

// 创建代理属性
@property (nonatomic, weak) id<MeeWaterflowLayoutDelegate> delegate;

@end
