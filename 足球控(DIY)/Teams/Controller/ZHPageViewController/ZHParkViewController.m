//
//  ZHTransferViewController.m
//  足球控(DIY)
//
//  Created by Aaron on 15/12/30.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import "ZHParkViewController.h"
#import "ZHFavourite.h"
#import "TotalAPI.h"
#import "ZHMyFavs.h"
#import "ZHHttpTool.h"
#import "ZHGuess.h"
#import "ZHParkGuessCell.h"
@interface ZHParkViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)ZHFavourite *currentTeam;
@property(nonatomic,weak)UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation ZHParkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

//母控制器 刷新数据时调用的方法
- (void)reloadTableViewData
{
    self.currentTeam = [ZHMyFavs selectedTeam];
    
    [self requestData];
}
- (void)requestData
{
    [ZHHttpTool Get:ZHTeamsSeasonParkURL(self.currentTeam.team_id) parameters:nil acceptableContentTypes:@"application/json" success:^(id responseObject) {

        self.dataArray = [ZHGuess mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"funguess"]];
        if ([responseObject[@"data"][@"homegoods"] count]>0) {
           [self.dataArray addObject:[ZHGuess mj_objectWithKeyValues:responseObject[@"data"][@"homegoods"][0]]];
        }
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
#pragma mark SETUPUI
- (void)setupTableView
{
    UITableView *tv = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tv.height = self.view.height - ZHTeamsTVTopViewHeight;
    tv.width = self.view.width;
    [self.view addSubview:tv];
    self.tableView = tv;
    self.tableView.rowHeight = 200;
    tv.backgroundColor = tableViewBGColor;
    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 35, 0);
    self.tableView.alwaysBounceVertical = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
#pragma mark dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZHParkGuessCell *cell = [ZHParkGuessCell cellWithTableView:tableView];
    ZHGuess *guess = self.dataArray[indexPath.section];
    cell.guess = guess;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
    
}

#pragma mark deletegate
#pragma mark 进入母控制器 就进行控件的配置
-(void)willMoveToParentViewController:(UIViewController *)parent
{
    [self setupTableView];
    [self reloadTableViewData];
}
@end
