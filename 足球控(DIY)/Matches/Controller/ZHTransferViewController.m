//
//  ZHTransferViewController.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/12.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHTransferViewController.h"
#import "ZHLeague.h"
#import "ZHPerson.h"
#import "MJExtension.h"
#import "ZHTransferCell.h"
@interface ZHTransferViewController ()

@end

@implementation ZHTransferViewController
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
    [ZHHttpTool Get:ZHMatchesAllMatchesTransferTable(self.league.competition_id) parameters:nil acceptableContentTypes:@"text/html" success:^(id responseObject) {
        [ZHPerson mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"from_club_name":@"membership.transfer.from_club_name",@"value":@"membership.transfer.value",@"club_name":@"membership.club_name"};
            
        }];
        _dataSourceArray = [ZHPerson mj_objectArrayWithKeyValuesArray:responseObject ];
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
    ZHTransferCell *cell = [ZHTransferCell cellWithTableView:tableView];
    
    cell.person = _dataSourceArray[indexPath.row];
    cell.backgroundColor = indexPath.row % 2 ? tableViewBGColor:[UIColor whiteColor];
    
    [UIView animateWithDuration:0.5 animations:^{
        cell.playerView.size  = CGSizeMake(10, 10);
        
    }];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[[NSBundle mainBundle]loadNibNamed:@"ZHTransferCell" owner:nil options:nil]lastObject];
}
#pragma mark dealloc
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
