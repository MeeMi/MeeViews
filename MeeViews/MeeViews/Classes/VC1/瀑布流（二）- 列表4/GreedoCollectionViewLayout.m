//
//  GreedoCollectionViewLayout.h
//  500px
//  Copyright (c) 2015 500px. All rights reserved.
//

#import "GreedoCollectionViewLayout.h"

@interface GreedoCollectionViewLayout ()

@property (nonatomic, strong) NSMutableDictionary *sizeCache;
@property (nonatomic, strong) NSMutableArray *leftOvers;
@property (nonatomic, strong) NSIndexPath *lastIndexPathAdded;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation GreedoCollectionViewLayout

// 通过 CollectionView 来初始化
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
{
    self = [super init];
    if (self) {
        _collectionView = collectionView;
        _rowMaximumHeight = 100;
    }
    return self;
}

// 计算每个 Photo的 size
- (CGSize)sizeForPhotoAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.sizeCache[indexPath]) {  // 如果缓存 Photo 的size为 空
        self.lastIndexPathAdded = indexPath;
        [self computeSizesAtIndexPath:indexPath];  // 计算size
    }
    CGSize size = [[self.sizeCache objectForKey:indexPath] CGSizeValue];
    if (size.width < 0.0 || size.height < 0.0) {
        size = CGSizeZero;
    }
    return size;
}

// 清除 缓存的size
- (void)clearCache
{
    [self.sizeCache removeAllObjects];
}

- (void)clearCacheAfterIndexPath:(NSIndexPath *)indexPath
{
    // Remove the indexPath
    [self.sizeCache removeObjectForKey:indexPath];
    
    // Remove the indexPath for anything after
    for (NSIndexPath *existingIndexPath in [self.sizeCache allKeys]) {
        if ([indexPath compare:existingIndexPath] == NSOrderedDescending) {
            [self.sizeCache removeObjectForKey:existingIndexPath];
        }
    }
}

#pragma mark - Private methods
// 计算 indexPath 位置上的 photo的size
- (void)computeSizesAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat contentWidth  = self.collectionView.bounds.size.width;
    CGFloat interitemSpacing = 0.0;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    if (layout) {
        contentWidth -= (layout.sectionInset.left + layout.sectionInset.right);
        interitemSpacing = layout.minimumInteritemSpacing;
    }

    CGSize  photoSize     = [self.dataSource greedoCollectionViewLayout:self originalImageSizeAtIndexPath:indexPath];
    
    [self.leftOvers addObject:[NSValue valueWithCGSize:photoSize]];
    
    if (photoSize.width < 1 || photoSize.height < 1) {
        // Photo with no height or width
        photoSize.width  = self.rowMaximumHeight;
        photoSize.height = self.rowMaximumHeight;
    }
    
    CGFloat totalWidth = 0.0;
    
    for (NSValue *leftOver in self.leftOvers) {
        CGSize leftOverSize = [leftOver CGSizeValue];
        totalWidth += (leftOverSize.width / leftOverSize.height);
    }
    
    contentWidth -= (self.leftOvers.count - 1) * self.cellPadding;

    CGFloat heightThatFits = contentWidth / totalWidth;
    
    if (heightThatFits > self.rowMaximumHeight) {
        // The line is not full, let's ask the next photo and try to fill up the line
        [self computeSizesAtIndexPath:[NSIndexPath indexPathForItem:(indexPath.item + 1) inSection:indexPath.section]];
        
    } else {
        // The line is full!
        CGFloat availableSpace = contentWidth;
        
        for (NSValue *leftOver in self.leftOvers) {
        
            CGSize leftOverSize = [leftOver CGSizeValue];

            CGFloat newWidth = ceil((heightThatFits * leftOverSize.width) / leftOverSize.height);
            newWidth = MIN(availableSpace, newWidth);
            
            // Add the size in the cache
            [self.sizeCache setObject:[NSValue valueWithCGSize:CGSizeMake(newWidth, heightThatFits)] forKey:self.lastIndexPathAdded];
            
            availableSpace = availableSpace - newWidth - interitemSpacing;
            
            // We need to keep track of the last index path added
            self.lastIndexPathAdded = [NSIndexPath indexPathForItem:(self.lastIndexPathAdded.item + 1) inSection:self.lastIndexPathAdded.section];
        }
        
        [self.leftOvers removeAllObjects];
    }
}

#pragma mark - Custom accessors

- (NSMutableArray *)leftOvers
{
    if (!_leftOvers) {
        _leftOvers = [NSMutableArray array];
    }
    
    return _leftOvers;
}


// 创建缓存 Photo位置上的 size
- (NSMutableDictionary *)sizeCache
{
    if (!_sizeCache) {
        _sizeCache = [NSMutableDictionary dictionary];
    }
    return _sizeCache;
}

@end