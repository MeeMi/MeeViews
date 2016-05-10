//
//  MeeGestureLockCollectionView.m
//  MeeViews
//
//  Created by liwei on 16/5/9.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeeGestureLockCollectionView.h"
#import "MeeLockView.h"

@interface MeeGestureLockCollectionView() <MeeLockViewDelegate>

@end

@implementation MeeGestureLockCollectionView

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = MeeRandomColor;
    
    MeeLockView *lockView = [[MeeLockView alloc]init];
    lockView.delegate = self;
    lockView.x = 0;
    lockView.y = 100;
    lockView.width = MeeScreenW;
    lockView.height = (MeeScreenH - lockView.y * 2);
    lockView.backgroundColor = [UIColor colorWithRed:0.21 green:0.62 blue:0.44 alpha:1.00];
    [self.view addSubview:lockView];
}

#pragma mark - MeeLockViewDelegate
- (BOOL)reslutIsTure:(NSString *)result
{
    if (result.length < 4) {
        return NO;
    }
    return YES;
}

@end
