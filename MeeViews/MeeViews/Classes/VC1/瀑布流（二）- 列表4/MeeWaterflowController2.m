//
//  MeeWaterflowController2.m
//  MeeViews
//
//  Created by liwei on 16/4/27.
//  Copyright © 2016年 Mee. All rights reserved.
//

@import Photos;

#import "MeeWaterflowController2.h"
#import "MeeWaterFlowCell2.m"

#import "GreedoCollectionViewLayout.h"

static NSString *const cellID = @"MeeWaterFlowCell2";

@interface MeeWaterflowController2 ()<UICollectionViewDelegate,UICollectionViewDataSource,GreedoCollectionViewLayoutDataSource>

// PHFetchResult: 表示一系列的资源集合，也可以是相册的集合
@property (strong, nonatomic) PHFetchResult *assetFetchResults;
@property (strong, nonatomic) GreedoCollectionViewLayout *collectionViewSizeCalculator;
@property (nonatomic, weak)  UICollectionView  * collectionView;

@end

@implementation MeeWaterflowController2

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupCollectionView];
}

- (void)setupCollectionView
{
    self.collectionViewSizeCalculator.rowMaximumHeight = CGRectGetHeight(self.collectionView.bounds) / 3;

    // 布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(10.0f, 5.0f, 5.0f, 5.0f);
    // layout.itemSize = CGSizeMake(200, 200);
    
//    UICollectionView *collectionView = [[UICollectionView alloc]init];
//    collectionView.collectionViewLayout = layout;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.frame = self.view.bounds;
    collectionView.backgroundColor = MeeRandomColor;
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerClass:[MeeWaterFlowCell2 class] forCellWithReuseIdentifier:cellID];
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
    
    
    // 获取设备上的所有图片
    [self getAllPhotoFromDevice];
    
}

- (void)getAllPhotoFromDevice
{
    // PHFetchOptions: 获取资源时的参数
    PHFetchOptions *allPhotoOptions = [[PHFetchOptions alloc]init];
    allPhotoOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    self.assetFetchResults = [PHAsset fetchAssetsWithOptions:allPhotoOptions];
    [self.collectionView reloadData];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assetFetchResults.count;
}

#pragma mark - UICollectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MeeWaterFlowCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    // PHAsset: 代表照片库中的一个资源
    PHAsset *asset = self.assetFetchResults[indexPath.item];
    // 配置选项
    // 控制资源的输出尺寸等规格
    // PHImageRequestOptions: 如上面所说，控制加载图片时的一系列参数
    
    PHImageRequestOptions *options = [PHImageRequestOptions new];
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    options.version = PHImageRequestOptionsVersionCurrent;
    options.synchronous = NO;
    
    CGFloat scale = MIN(2.0, [[UIScreen mainScreen] scale]);
    CGSize requestImageSize = CGSizeMake(CGRectGetWidth(cell.bounds) * scale, CGRectGetHeight(cell.bounds) * scale);
    // PHImageManager: 用于处理资源的加载，加载图片的过程带有缓存处理，可以通过传入一个
    [[PHCachingImageManager defaultManager] requestImageForAsset:asset
                                                      targetSize:requestImageSize
                                                     contentMode:PHImageContentModeAspectFit
                                                         options:options
                                                   resultHandler:^(UIImage *result, NSDictionary *info) {
                                                        cell.imageView.image = result;
                                                   }];

    return cell;
}


#pragma mark - <GreedoCollectionViewLayoutDataSource>

- (CGSize)greedoCollectionViewLayout:(GreedoCollectionViewLayout *)layout originalImageSizeAtIndexPath:(NSIndexPath *)indexPath
{
    // Return the image size to GreedoCollectionViewLayout
    if (indexPath.item < self.assetFetchResults.count) {
        PHAsset *asset = self.assetFetchResults[indexPath.item];
        return CGSizeMake(asset.pixelWidth, asset.pixelHeight);
    }
    
    return CGSizeMake(0.1, 0.1);
}

#pragma mark - Lazy Loading

- (GreedoCollectionViewLayout *)collectionViewSizeCalculator
{
    if (!_collectionViewSizeCalculator) {
        _collectionViewSizeCalculator = [[GreedoCollectionViewLayout alloc] initWithCollectionView:self.collectionView];
        _collectionViewSizeCalculator.dataSource = self;
    }
    
    return _collectionViewSizeCalculator;
}
@end
