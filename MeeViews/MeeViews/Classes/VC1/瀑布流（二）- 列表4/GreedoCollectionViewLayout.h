//
//  GreedoCollectionViewLayout.h
//  500px
//  Copyright (c) 2016 500px. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol GreedoCollectionViewLayoutDataSource;

@interface GreedoCollectionViewLayout : NSObject

@property (nonatomic, weak) id <GreedoCollectionViewLayoutDataSource> dataSource;
@property CGFloat rowMaximumHeight;
@property CGFloat cellPadding;

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;
- (CGSize)sizeForPhotoAtIndexPath:(NSIndexPath *)indexPath;
- (void)clearCache;
- (void)clearCacheAfterIndexPath:(NSIndexPath *)indexPath;

@end


// 代理协议
@protocol GreedoCollectionViewLayoutDataSource <NSObject>

- (CGSize)greedoCollectionViewLayout:(GreedoCollectionViewLayout *)layout originalImageSizeAtIndexPath:(NSIndexPath *)indexPath;

@end