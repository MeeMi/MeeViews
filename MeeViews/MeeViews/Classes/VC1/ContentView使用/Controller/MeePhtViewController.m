//
//  MeePhtViewController.m
//  MeeViews
//
//  Created by liwei on 16/4/21.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeePhtViewController.h"
#import "MeePhoTableViewCell.h"

#import "MeeShowBigPicViewController.h"

//#import "MeeShowPicViewController.h"

@interface MeePhtViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MeePhtViewController


- (void)viewDidLoad {
    [super viewDidLoad];

//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];

    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = MeeRandomColor;
    self.tableView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MeePhoTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MeePhoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.indexpath = indexPath;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选中 ----> %zd",indexPath.row);
    
    // 当点击cell modal 感觉要延迟
    
    // 自己的做法 ：添加手势;
    // [self.view.window.rootViewController presentViewController:self animated:YES completion:nil];
    
    /*
    MeePhoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    MeeShowBigPicViewController *showVc = [[MeeShowBigPicViewController alloc]init];
    
    // MeeShowPicViewController *showVc = [[MeeShowPicViewController alloc]init];
    showVc.picNumOrUrlStr = cell.imageUrls[indexPath.row];
    [self presentViewController:showVc animated:YES completion:nil];
     */
    
}



@end
