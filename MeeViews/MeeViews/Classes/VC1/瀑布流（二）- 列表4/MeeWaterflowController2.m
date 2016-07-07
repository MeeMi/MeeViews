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

#import "SDPhotoBrowser.h"
// 可拖动
#import "XWDragCellCollectionView.h"

static NSString *const cellID = @"MeeWaterFlowCell2";

@interface MeeWaterflowController2 ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,GreedoCollectionViewLayoutDataSource,XWDragCellCollectionViewDataSource,XWDragCellCollectionViewDelegate,SDPhotoBrowserDelegate>

// PHFetchResult: 表示一系列的资源集合，也可以是相册的集合
@property (strong, nonatomic) PHFetchResult *assetFetchResults;
@property (strong, nonatomic) GreedoCollectionViewLayout *collectionViewSizeCalculator;
@property (nonatomic, weak)  UICollectionView  * collectionView;


@property (nonatomic, strong)  NSMutableArray  * photoes;  // 图片数组

@end

@implementation MeeWaterflowController2

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupCollectionView];
}

- (void)setupCollectionView
{
    // 布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(10.0f, 5.0f, 5.0f, 5.0f);
    // 这个方法设置 同意的 UICollectionViewCell的size （可以通过代理方法 设置对应位置上 cell的size）
    // layout.itemSize = CGSizeMake(200, 200);
    
    // 这样设置layout 报错（？）
//    UICollectionView *collectionView = [[UICollectionView alloc]init];
//    collectionView.collectionViewLayout = layout;
    
//    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    
    XWDragCellCollectionView *collectionView = [[XWDragCellCollectionView alloc]initWithFrame: CGRectZero collectionViewLayout:layout];
    
    collectionView.frame = self.view.bounds;
    collectionView.backgroundColor = MeeRandomColor;
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerClass:[MeeWaterFlowCell2 class] forCellWithReuseIdentifier:cellID];
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
    
    
    self.collectionViewSizeCalculator.rowMaximumHeight = CGRectGetHeight(self.collectionView.bounds) / 3;
    
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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MeeWaterFlowCell2 *cell = ( MeeWaterFlowCell2 *)[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
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
                                                       // 移除动画（防止动画被复用）
                                                      [cell.imageView.layer removeAllAnimations];
                                                       cell.imageView.image = result;
                                                       
                                                       // 将图片装到数组中
                                                       [self.photoes addObject:result];
                                                   }];
    
    return cell;
}




#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"图片 被选择----> %zd",indexPath.item);
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = indexPath.item;
    photoBrowser.imageCount = self.assetFetchResults.count;
    photoBrowser.sourceImagesContainerView = self.collectionView;
    [photoBrowser show];
}


#pragma mark  SDPhotoBrowserDelegate

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    // 不建议用此种方式获取小图，这里只是为了简单实现展示而已
    return self.photoes[index];
    
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    return nil;
}



#pragma mark - UICollectionViewDelegateFlowLayout
// 代理方法： 设置对应的 indexPath 位置上的 cell的对应的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.collectionViewSizeCalculator sizeForPhotoAtIndexPath:indexPath];
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



# pragma mark - XWDragCellCollectionViewDelegate
/**
 *  当数据源更新的到时候调用，必须实现，需将新的数据源设置为当前tableView的数据源(例如 :_data = newDataArray)
 *  @param newDataArray   更新后的数据源
 */
- (void)dragCellCollectionView:(XWDragCellCollectionView *)collectionView newDataArrayAfterMove:(NSArray *)newDataArray
{
    self.photoes = [NSMutableArray arrayWithArray:newDataArray];
}

#pragma mark - XWDragCellCollectionViewDataSource
/**
 *  返回整个CollectionView的数据，必须实现，需根据数据进行移动后的数据重排
 */
- (NSArray *)dataSourceArrayOfCollectionView:(XWDragCellCollectionView *)collectionView
{
    return self.photoes;
}



#pragma Mark - 懒加载
- (NSMutableArray *)photoes
{
    if (_photoes == nil) {
        _photoes = [NSMutableArray array];
    }
    return _photoes;
}



@end
