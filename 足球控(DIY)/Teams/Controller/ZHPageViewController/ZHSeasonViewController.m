//
//  ZHSeasonViewController.m
//  足球控(DIY)
//
//  Created by Aaron on 15/12/30.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import "ZHSeasonViewController.h"
#import "ZHMyFavs.h"
#import "TotalAPI.h"
#import "ZHFavourite.h"
#import "ZHLeague.h"
#import "ZHSeasonFooter.h"
#import "ZHSeasonResult.h"
#import "ZHTrophy.h"
#import "ZHMatchesPageViewController.h"

@interface ZHSeasonViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)ZHFavourite *currentTeam;
@property(nonatomic,weak)UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *seasonsArray;

@property (nonatomic,strong) NSMutableArray *footerDatas;
//用来回调数据
@property (nonatomic,copy) void (^dataRequestBlock)(ZHSeasonResult* result);

@end

@implementation ZHSeasonViewController
{
    ZHMatchesPageViewController *_pageVC;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
}
- (NSMutableArray *)footerDatas
{
    if (!_footerDatas) {
        _footerDatas = [NSMutableArray array];
    }
    return _footerDatas;
}
#pragma mark SETUPUI
- (void)setupTableView
{
    UITableView *tv = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tv.height = self.view.height - ZHTeamsTVTopViewHeight;
    tv.width = self.view.width;
    [self.view addSubview:tv];
    self.tableView = tv;
    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 35, 0);
    self.tableView.alwaysBounceVertical = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
//请求tableView的数据
- (void)requestData
{
    __weak typeof(self)weakSelf = self;
    
//请求球队参与的联赛赛季id
  [ZHHttpTool Get:ZHTeamsSeasonAllSeasonURL(self.currentTeam.team_id) parameters:nil acceptableContentTypes:@"text/html" success:^(id responseObject) {
      [ZHLeague mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
          return @{@"season_id":@"season.season_id",@"seasonName":@"season.name"};
          
      }];
      
      weakSelf.seasonsArray = [ZHLeague mj_objectArrayWithKeyValuesArray:responseObject];
      
      
      //用球队id和赛季信息 请求数据  整个赛季的数据
      for (int i = 0; i< self.seasonsArray.count; i++) {
          ZHLeague * league = (id)self.seasonsArray[i];
          [ZHHttpTool Get:ZHTeamsSeasonLeagueResult(league.season_id, self.currentTeam.team_id) parameters:nil acceptableContentTypes:@"application/json" success:^(id responseObject) {
              ZHSeasonResult *result = [ZHSeasonResult mj_objectWithKeyValues:responseObject[@"data"][@"list"][0]];
              //拿到赛季结果数据后 返回给 footerDatas
              league.result = result;
              //刷新每一个footerView
              [self.tableView reloadData];
              
          } failure:^(NSError *error) {
              NSLog(@"%@",error);
          }];
      }
      [self.tableView reloadData];
  } failure:^(NSError *error) {
      NSLog(@"%@",error);
      
  }];
}

/**
 *  受控制于pageView C
 */
- (void)reloadTableViewData
{
     //取出当前选中的team
    ZHFavourite *selTeam = [ZHMyFavs selectedTeam];
    self.currentTeam = selTeam;
    [self requestData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.seasonsArray.count;
}
//创造 圆饼图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    ZHSeasonFooter *footer = [ZHSeasonFooter footer];
        ZHLeague *league = self.seasonsArray[section];
        footer.footerData = league.result;
 
    for (ZHTrophy * trophy in self.currentTeam.trophies) {
        if ([trophy.competition_id isEqualToString:league.competition_id]) {
            //传入锦标数
            footer.winL.text = trophy.winner_count;
            footer.runnerL.text = trophy.runnerup_count;
        }
    }

    footer.backgroundColor = tableViewBGColor;
    return footer;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    //    取出数据
    ZHLeague *league = self.seasonsArray[indexPath.section];
    //    给cell传递模型数据
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:ZHMatchesAllMatchesLeagueIcon(league.competition_id)] placeholderImage:[UIImage imageNamed:@"teams_league_default_logo"]];

    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc]initWithString:league.seasonName attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc]initWithString:league.name];
    
    [string2 appendAttributedString:string1];

    cell.textLabel.attributedText = string2;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZHLeague *league = self.seasonsArray[indexPath.section];
    UINavigationController *NGVC = self.parentViewController.parentViewController.navigationController;
    
    ZHMatchesPageViewController *pageVC = [[ZHMatchesPageViewController alloc]init];
//    [self addChildViewController:pageVC];
    
    [NGVC pushViewController:pageVC animated:YES];
    pageVC.league = league;
}


#pragma mark 进入母控制器 就进行控件的配置
-(void)willMoveToParentViewController:(UIViewController *)parent
{
    [self setupTableView];
    [self reloadTableViewData];
}
@end
