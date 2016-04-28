//
//  MeeProViewController.m
//  MeeViews
//
//  Created by liwei on 16/4/26.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeeProViewController.h"

#import "MeeProgressView.h"

@interface MeeProViewController ()

@end

@implementation MeeProViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    MeeProgressView *proView = [[MeeProgressView alloc]init];
    proView.width = MeeScreenW;
    proView.height = MeeScreenH * 0.7;
    proView.x = 0;
    proView.y = (MeeScreenH - proView.height) * 0.5;
    
    [self.view addSubview:proView];
}



@end
