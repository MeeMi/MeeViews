//
//  MeeWaterflowLayour.m
//  MeeViews
//
//  Created by liwei on 16/4/25.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeeWaterflowLayout.h"

// 设置默认值
/** 默认的列数 */
static const NSInteger MeeDefaultColumnCount = 3;
/** 每一列之间的间距 */
static const CGFloat MeeDefaultColumnMargin = 10;
/** 每一行之间的间距 */
static const CGFloat MeeDefaultRowMargin = 10;
/** 边缘间距 */
static const UIEdgeInsets MeeDefaultEdgeInsets = {10, 10, 10, 10};


@interface MeeWaterflowLayout()

/** 存放所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;
/** 存放所有列的当前高度 */
@property (nonatomic, strong) NSMutableArray *columnHeights;
/** 内容的高度 */
@property (nonatomic, assign) CGFloat contentHeight;

- (CGFloat)rowMargin;
- (CGFloat)columnMargin;
- (NSInteger)columnCount;
- (UIEdgeInsets)edgeInsets;

@end


@implementation MeeWaterflowLayout

#pragma mark - 处理常见数据
- (CGFloat)rowMargin
{
    // 行间距，如果代理设置了 行间距就用代理中提供的，没有就用默认的
    if([self.delegate respondsToSelector:@selector(rowMarginInWaterflowLayout:)]){
        return [self.delegate rowMarginInWaterflowLayout:self]; // 通知代理，去调用代理中的方法
    }else{
        return MeeDefaultRowMargin;
    }
}

// 2.列间距
- (CGFloat)columnMargin
{
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterflowLayout:)]) {
        return [self.delegate columnMarginInWaterflowLayout:self];
    }else{
        return MeeDefaultColumnMargin;
    }
}

// 3.列数
- (NSInteger)columnCount
{
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterflowLayout:)]) {
        return [self.delegate columnCountInWaterflowLayout:self];
    }else{
        return MeeDefaultColumnCount;
    }
}

// 4.边缘间距
- (UIEdgeInsets)edgeInsets
{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterflowLayout:)]) {
        return [self.delegate edgeInsetsInWaterflowLayout:self];
    }else{
        return MeeDefaultEdgeInsets;
    }
}



#pragma mark - 懒加载 （初始化数据）

// 存放所以布局属性的数组
- (NSMutableArray *)attrsArray
{
    if (_attrsArray == nil) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

// 存放每列高度的数组
- (NSMutableArray *)columnHeights
{
    if (_columnHeights == nil) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}


#pragma mark - 重载父类方法

// 一些必要的layout的结构和初始化需要的参数
- (void)prepareLayout
{
    [super prepareLayout];
    
    self.contentHeight = 0;
    // 清除以前计算的所有高度
    [self.columnHeights removeAllObjects];
    
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }
    
    // 清除之前的所有的布局属性
    [self.attrsArray removeAllObjects];
    
    // 获取cell的个数
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0 ; i < cellCount; i++ ) {
        // 设置出每个cell的位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        // 根据位置获取到collectionView中的cell的布局属性
        UICollectionViewLayoutAttributes *cellAttr = [self layoutAttributesForItemAtIndexPath:indexPath]; // 返回对应于indexPath的位置的cell的布局属性
        [self.attrsArray addObject:cellAttr];
    }
}

// 初始的layout的外观将由该方法返回的UICollectionViewLayoutAttributes来决定。
// 重载 父类方法 - 对cell的布局进行设置
// 返回对应于indexPath的位置的cell的布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    // 创建布局属性
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // 获得CollectionView的宽度
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    
    // 设置cell的 frame
    CGFloat cellW = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / (self.columnCount);
    // cell的高度是有提供的代理方法 获得的
    CGFloat cellH = [self.delegate waterflowLayout:self heightForItemAtIndex:indexPath itemWidth:cellW];
    
    
    // 核心关键 - 找出最短那一列
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < self.columnCount; i++) {
        // 获取对应的 第i列的高度
        CGFloat currentColumHeight = [self.columnHeights[i] doubleValue];
        if (minColumnHeight > currentColumHeight) {
            minColumnHeight = currentColumHeight;
            destColumn = i;
        }
    }
    
    // 将cell 填补在最短列的下面
    CGFloat x = self.edgeInsets.left + destColumn * (cellW + self.columnMargin);
    CGFloat y = minColumnHeight;
    
    attributes.frame = CGRectMake(x, y, cellW, cellH);
    
    // 更新最短那列的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attributes.frame));
    
    // 记录内容的高度
    
    
    
    return attributes;
}



/** 决定cell的排布  */
// 返回rect中的所有的元素的布局属性
// 返回的是包含UICollectionViewLayoutAttributes的NSArray
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return nil;
}

@end
