//
//  ZHMatchDetailViewController.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/12.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHMatchDetailViewController.h"
#import "TotalAPI.h"
#import "ZHLeague.h"
#import "MJExtension.h"
#import "ZHMatchVS.h"
@interface ZHMatchDetailViewController ()

@end

@implementation ZHMatchDetailViewController
{
    UITableView *_tableView;
    NSArray *_dataSourceArray;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
- (void)requestData:(long )before later:(long)later
{
    //覆盖此方法使他无法请求数据
    
}

//接收通知中心来的数据
-  (void)receiveModel:(NSNotification *)sender
{
    self.league = sender.object;
        [ZHHttpTool Get:ZHMatchesAllMatchesLeagueMatchesURL(self.league.season_id) parameters:nil acceptableContentTypes:@"text/html" success:^(id responseObject) {
            self.dataSourceArray = [ZHMatchVS mj_objectArrayWithKeyValuesArray:responseObject];
            //排序数据 得到各个天数的比赛对阵
            self.dataSourceArray = [self sortArrayWithDataAndTime:self.dataSourceArray];
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
            
        }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
#pragma mark dealloc
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
