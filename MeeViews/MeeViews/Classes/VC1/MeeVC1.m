//
//  MeeVC1.m
//  MeeViews
//
//  Created by 扬帆起航 on 16/4/18.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeeVC1.h"

#import "MeePicViewController.h"
#import "MeePhtViewController.h"
#import "MeeWaterflowController1.h"
#import "MeeProViewController.h"

#import "MeeWaterflowController2.h"
#import "MeeGestureLockCollectionView.h"

@interface MeeVC1 ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)  NSArray  * titles;
@property (nonatomic, strong)  NSArray  * subTitles;
@end

@implementation MeeVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.31 green:0.52 blue:0.34 alpha:1.00];
    
    self.titles = @[@"功能1" , @"功能2" , @"功能3",@"功能4",@"功能5",@"功能6"];
    self.subTitles = @[@"图片轮播器",@"storyborad中Container View使用",@"瀑布流（一）",@"瀑布流（二）",@"进度条",@"手势解锁"];
    
    [self setupTableView];
}

- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc]init];
    tableView.frame = self.view.bounds;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor colorWithRed:0.40 green:0.78 blue:0.94 alpha:1.00];
    
    tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:tableView];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = MeeRandomColor;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.titles[indexPath.row];
    cell.detailTextLabel.text = self.subTitles[indexPath.row];
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
            NSLog(@"选中 0 ");
            MeePicViewController *vc = [[MeePicViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
             break;
        }
        case 1:{
            NSLog(@"选中 1 ");
            // 从storyboard中加载控制器
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MeePhtViewController" bundle:nil];
            // instantiateInitialViewController:加载箭头指向的控制器
            MeePhtViewController *vc = [sb instantiateInitialViewController];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:{
            NSLog(@"选中 2 ");
            MeeWaterflowController1 *vc = [[MeeWaterflowController1 alloc]init];
            vc.title = self.subTitles[2];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:{
            NSLog(@"选中 3 ");
            MeeWaterflowController2 *vc = [[MeeWaterflowController2 alloc]init];
            vc.title = self.subTitles[3];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 4:{
            NSLog(@"选中 4 ");
            MeeProViewController *vc = [[MeeProViewController alloc]init];
            vc.title = self.subTitles[4];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 5:{
            NSLog(@"选中 5 ");
            MeeGestureLockCollectionView *vc = [[MeeGestureLockCollectionView alloc]init];
            vc.title = self.subTitles[5];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}



@end
