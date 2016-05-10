//
//  MeeLockView.h
//  MeeViews
//
//  Created by liwei on 16/5/9.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import <UIKit/UIKit.h>

// 添加代理
@class MeeLockView;
@protocol MeeLockViewDelegate <NSObject>

- (BOOL)reslutIsTure:(NSString *)result;

@end

@interface MeeLockView : UIView

@property (nonatomic, weak)  id<MeeLockViewDelegate>  delegate;

@end
