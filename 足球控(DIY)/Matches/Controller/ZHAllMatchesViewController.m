//
//  ZHViewController.m
//  UIFengzhuang
//
//  Created by Aaron on 15/12/21.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import "ZHAllMatchesViewController.h"
#import "ZHLeague.h"
#import "ZHSectionHeader.h"
#import "TotalAPI.h"

@interface ZHAllMatchesViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataSourceArray;
@end

@implementation ZHAllMatchesViewController
{
     NSInteger _lastContentOffSetY;
}
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:YES];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self loadData];
}
- (void)setupTableView
{
    UITableView *tv = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:tv];
    self.tableView = tv;
    self.tableView.height -=64;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
#pragma mark 获得cell数据源
- (void)loadData
{
    [ZHHttpTool Get:ZHMatchesAllMatchesHotLeagueURL parameters:nil acceptableContentTypes:@"text/html" success:^(id responseObject) {
        _dataSourceArray = [ZHLeague mj_objectArrayWithKeyValuesArray:responseObject];
        
        //再请求所有的season_id
        for (ZHLeague *league in _dataSourceArray) {
            
            [ZHHttpTool Get:ZHMatchesAllMatchesGetSeasonID(league.competition_id) parameters:nil acceptableContentTypes:@"application/json" success:^(id responseObject) {
                NSString *season_id = responseObject[@"data"][@"season_id"];
                //保存season_id
                league.season_id = season_id;
                
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
                
            }];
            
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!section) {
        return 1;
    }
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *allMatches = @"allMatchesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:allMatches];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:allMatches];
    }
    //    设置数据
    if (indexPath.section == 0) {
        cell.textLabel.text = @"所有联赛";
        cell.imageView.image = [UIImage imageNamed:@"teams_choose_ic_allteams"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    ZHLeague *model = self.dataSourceArray[indexPath.row];
    
//    给cell传递模型数据
    cell.textLabel.text = model.name;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:ZHMatchesAllMatchesLeagueIcon(model.competition_id)] placeholderImage:[UIImage imageNamed:@"team_logo_default"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


#pragma mark UITableView代理方法
//设置headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section) {
        ZHSectionHeader *header = [ZHSectionHeader header];
        header.titleLable.text = @"热门赛事";
//        header.backgroundColor = tableViewBGColor;
        return header;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.CellClickHandler(self.dataSourceArray[indexPath.row],indexPath);
}
//设置header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (!section) {
        return 0.1;
    }
    return 40;
}
@end
