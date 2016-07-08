//
//  MeeChild2TableViewController.m
//  MeeViews
//
//  Created by liwei on 16/7/8.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeeChild2TableViewController.h"

@interface MeeChild2TableViewController ()

@end

@implementation MeeChild2TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTableView];
}

- (void)setupTableView
{
    self.tableView.rowHeight = 80;
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor colorWithRed:0.98 green:0.69 blue:0.71 alpha:1.00];
    cell.textLabel.text = [NSString stringWithFormat:@"第二个TableViewController - %zd",indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell2---->>> %zd",indexPath.row);
}


@end
