//
//  ZHPlayersViewController.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/12.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHPlayersViewController.h"
#import "ZHLeague.h"
#import "ZHPlayerRankCell.h"
@interface ZHPlayersViewController ()

@end

@implementation ZHPlayersViewController
{
    NSArray *_goalsArray;
    NSArray *_assistsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-  (void)receiveModel:(NSNotification *)sender
{
    [super receiveModel:sender];
    [ZHHttpTool Get:ZHMatchesAllMatchesPlayersTable(self.league.season_id) parameters:nil acceptableContentTypes:@"text/html" success:^(id responseObject) {
        _goalsArray = responseObject[@"season"][@"goals"][@"person"];
        _assistsArray = responseObject[@"season"][@"assists"][@"person"];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZHPlayerRankCell *cell = [ZHPlayerRankCell cellWithTableView:tableView];
    if (indexPath.section) {
        
        cell.dataDict = _assistsArray[indexPath.row];
    }else
    {
        cell.dataDict = _goalsArray[indexPath.row];
    }
    
    cell.rankL.text = [NSString stringWithFormat:@"%lu",indexPath.row + 1];
    cell.backgroundColor = indexPath.row % 2 ? tableViewBGColor:[UIColor whiteColor];
    [UIView animateWithDuration:0.5 animations:^{
        cell.playerIconView.size  = CGSizeMake(10, 10);
        
    }];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    ZHPlayerRankCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"ZHPlayerRankCell" owner:nil options:nil]lastObject];
    cell.sectionHeaderFirL.text = section % 2 ? @"助攻榜":@"射手榜";
    cell.sectionHeaderEndL.text = section % 2 ? @"助攻":@"进球";
    return cell;
}
#pragma mark dealloc
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
