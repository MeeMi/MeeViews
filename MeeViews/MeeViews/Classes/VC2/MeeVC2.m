//
//  MeeVC2.m
//  MeeViews
//
//  Created by 扬帆起航 on 16/4/18.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeeVC2.h"
#import "MeeRootViewController.h"
#import "MeeChildViewController.h"

@interface MeeVC2 ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong)  NSArray  * titles;

@end

static NSString * const cellID = @"itemCell";

@implementation MeeVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.18 green:0.65 blue:0.97 alpha:1.00];
    self.titles = @[@"原始",@"导航渐变+LTNavigationBar"];
    [self setupTableView];
}

- (void)setupTableView
{
    // 表示尺寸更随父控件
    self.tableView.backgroundColor = [UIColor colorWithRed:0.98 green:0.69 blue:0.71 alpha:1.00];
    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
}



#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = MeeRandomColor;
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
            NSLog(@"1");
            MeeRootViewController *rootVc = [[MeeRootViewController alloc]init];
            [self.navigationController pushViewController:rootVc animated:YES];
            
            break;
        }
        case 1:{
            NSLog(@"2");
            MeeChildViewController *rootVc2 = [[MeeChildViewController alloc]init];
            [self.navigationController pushViewController:rootVc2 animated:YES];
            break;
        }

        default:
            break;
    }
}



//设置tableview的分割线没有开头的间距

//view布局完子控件的时候调用
- (void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
//cell即将展示的时候调用
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
