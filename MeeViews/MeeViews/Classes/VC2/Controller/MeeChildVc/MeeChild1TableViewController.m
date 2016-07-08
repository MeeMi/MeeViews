//
//  MeeChild1ViewController.m
//  MeeViews
//
//  Created by liwei on 16/7/8.
//  Copyright © 2016年 Mee. All rights reserved.
//

#import "MeeChild1TableViewController.h"

@interface MeeChild1TableViewController ()

@end

@implementation MeeChild1TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
}

- (void)setupTableView
{
    self.tableView.rowHeight = 64;
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor colorWithRed:0.71 green:0.63 blue:0.53 alpha:1.00];
    cell.textLabel.text = [NSString stringWithFormat:@"第一个TableViewController - %zd",indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell---->>> %zd",indexPath.row);
}

@end
