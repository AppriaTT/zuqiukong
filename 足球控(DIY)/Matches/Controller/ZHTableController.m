//
//  ZHTableController.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/12.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHTableController.h"
#import "UIView+Extension.h"
#import "ZHTableResultCell.h"
#import "TotalAPI.h"
#import "ZHLeague.h"
#import "ZHTeamPerformance.h"
@interface ZHTableController ()
@end

@implementation ZHTableController
{
    NSArray *_dataSourceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

//请求数据
-  (void)receiveModel:(NSNotification *)sender
{
    [super receiveModel:sender];
    
    [ZHHttpTool Get:ZHMatchesAllMatchesResultsTable(self.league.season_id) parameters:nil acceptableContentTypes:@"text/html" success:^(id responseObject) {
        _dataSourceArray = [ZHTeamPerformance mj_objectArrayWithKeyValuesArray:responseObject[@"season"][@"round"][@"resultstable"][0][@"ranking"]];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZHTableResultCell *cell = [ZHTableResultCell cellWithTableView:tableView];
    cell.performance = _dataSourceArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[[NSBundle mainBundle]loadNibNamed:@"ZHTableResultCell" owner:nil options:nil]lastObject];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark dealloc
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
