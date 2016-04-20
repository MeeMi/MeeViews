//
//  MeeCollectionViewLayout.m
//  MeeViews
//
//  Created by liwei on 16/4/20.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeeCollectionViewLayout.h"

@implementation MeeCollectionViewLayout

// 自定义collecctionView的布局


// 重载父类的方法

// 默认情况下，改方法什么也没做，但是在自己的子类实现中，一般在该方法中设定一些必要的layout的结构和初始化需要的参数
- (void)prepareLayout
{
    [super prepareLayout];
    
    // 设置cell 滚动的方向
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 设置cell的尺寸
    self.itemSize = CGSizeMake(self.collectionView.width * 0.7, self.collectionView.height * 0.8);
    
    // 设置内边距
    CGFloat inset = (self.collectionView.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}

// 当边界发生改变时，是否应该刷新布局。如果YES则在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息。
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


/**
 
 UICollectionViewLayoutAttributes
 UICollectionViewLayoutAttributes是一个非常重要的类，先来看看property列表：
 @property (nonatomic) CGRect frame
 @property (nonatomic) CGPoint center
 @property (nonatomic) CGSize size
 @property (nonatomic) CATransform3D transform3D
 @property (nonatomic) CGFloat alpha
 @property (nonatomic) NSInteger zIndex
 @property (nonatomic, getter=isHidden) BOOL hidden
 可以看到，UICollectionViewLayoutAttributes的实例中包含了诸如边框，中心点，大小，形状，透明度，层次关系和是否隐藏等信息。和DataSource的行为十分类似，当UICollectionView在获取布局时将针对每一个indexPath的部件（包括cell，追加视图和装饰视图），向其上的UICollectionViewLayout实例询问该部件的布局信息（在这个层面上说的话，实现一个UICollectionViewLayout的时候，其实很像是zap一个delegate，之后的例子中会很明显地看出），这个布局信息，就以UICollectionViewLayoutAttributes的实例的方式给出。
 */


// 初始的layout的外观将由该方法返回的UICollectionViewLayoutAttributes来决定。
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 获取super已经计算好的布局属性
    NSArray *original = [super layoutAttributesForElementsInRect:rect];
    // 不要直接获取 父类的属性进行修改（会有警告），正确做法 拷贝一份进行修改在返回
    NSArray * attributes = [[NSArray alloc] initWithArray:original copyItems:YES];
    // 计算collectionView最中心的位置
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.width * 0.5;
    
    // UICollectionViewLayoutAttributes的实例中包含了诸如边框，中心点，大小，形状，透明度，层次关系和是否隐藏等信息
    // 在原来的布局属性上进行微调
    for(UICollectionViewLayoutAttributes * att in attributes){
    
        // cell中心点 x 与 collectionView 中心位置的centerX 的间距
        CGFloat delta = ABS(att.center.x - centerX);
        
        // 根据间距计算cell的缩放比
        // 间距越大缩放比越小
        float scale = 1.0 - delta / self.collectionView.width;

        att.transform =  CGAffineTransformMakeScale(scale, scale);
        
    }
    
    return attributes;
}


/**
  自动对齐到网格
 * 这个方法的返回值，就决定了collectionView停止滚动时的偏移量
 */
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
//{
//    // 计算出最终显示的矩形框
//    CGRect rect;
//    rect.origin.y = 0;
//    rect.origin.x = proposedContentOffset.x;
//    rect.size = self.collectionView.frame.size;
//
//    // 获得super已经计算好的布局属性
//    NSArray *array = [super layoutAttributesForElementsInRect:rect];
//
//    // 计算collectionView最中心点的x值
//    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
//
//    // 存放最小的间距值
//    CGFloat minDelta = MAXFLOAT;
//    for (UICollectionViewLayoutAttributes *attrs in array) {
//        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
//            minDelta = attrs.center.x - centerX;
//        }
//    }
//
//    // 修改原有的偏移量
//    proposedContentOffset.x += minDelta;
//    return proposedContentOffset;
//}





@end
