//
//  MeeRootTableViewCell.m
//  MeeViews
//
//  Created by liwei on 16/7/7.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeeRootTableView.h"

#define MeeClickBtnObjcKey @"clickBtnObjc"
#define MeeClickBtnNote @"clickBtn"


@implementation MeeRootTableView



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"cell ---- select");
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    
    // 当点击时，事件被tableView最先拦截，所以将判断的点是不是在tabBar上，将事件传递到 tabBarView上
    
    for (UIView *tabBarChildView in self.tabBar.subviews) {
        // 将在tabelView 上的点转换成 tabBarChildView上的点
        CGPoint childP = [self convertPoint:currentPoint toView:tabBarChildView];
        
       // 用pointInside方法判断点在不在控件上,point这个必须是方法调用者坐标系上的点
        if ([tabBarChildView pointInside:childP withEvent:event]) {
            // 点击按钮
            
            // 通知控制器切换内容视图
            [[NSNotificationCenter defaultCenter]postNotificationName:MeeClickBtnNote object:nil userInfo:@{MeeClickBtnObjcKey : tabBarChildView}];
            return;
        }
    }
    
    // 如果没有事件处理，就调用系统自带的处理方式
    [super touchesBegan:touches withEvent:event];
}

@end
