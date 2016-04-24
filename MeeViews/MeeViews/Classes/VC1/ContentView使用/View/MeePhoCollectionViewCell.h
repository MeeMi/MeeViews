//
//  MeePhoCollectionViewCell.h
//  MeeViews
//
//  Created by 扬帆起航 on 16/4/23.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeeCollectionViewCell.h"

@interface MeePhoCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) NSIndexPath *indexPath; /**< NSIndexPath */
@property (nonatomic, strong) NSArray * imageUrls;

@end
