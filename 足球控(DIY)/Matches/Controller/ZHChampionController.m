//
//  ZHTopViewController.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/12.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHChampionController.h"
#import "ZHLeague.h"
#import "ZHTrophy.h"
#import "ZHTrophyCell.h"
@interface ZHChampionController ()

@end

@implementation ZHChampionController
{
    NSArray *_dataSourceArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-  (void)receiveModel:(NSNotification *)sender
{
    
    [super receiveModel:sender];
    
    [ZHHttpTool Get:ZHMatchesAllMatchesTrophiesTable(self.league.competition_id) parameters:nil acceptableContentTypes:@"text/html" success:^(id responseObject) {
        [ZHTrophy mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"winner_name":@"trophy.winner_name",@"winner_team_id":@"trophy.winner_team_id",@"runnerup_name":@"trophy.runnerup_name",@"runnerup_team_id":@"trophy.runnerup_team_id"};
            
        }];
        
        _dataSourceArray = [ZHTrophy mj_objectArrayWithKeyValuesArray:responseObject[@"season"]];
        
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
    ZHTrophyCell *cell = [ZHTrophyCell cellWithTableView:tableView];
    cell.trophy = _dataSourceArray[indexPath.row];
    cell.backgroundColor = indexPath.row % 2? tableViewBGColor:[UIColor whiteColor];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[[NSBundle mainBundle]loadNibNamed:@"ZHTrophyCell" owner:nil options:nil]firstObject];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
#pragma mark dealloc
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
