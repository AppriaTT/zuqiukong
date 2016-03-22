//
//  ZHPlayerViewController.m
//  足球控(DIY)
//
//  Created by Aaron on 15/12/30.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import "ZHPlayerViewController.h"
#import "ZHPlayerCell.h"
#import "ZHFavourite.h"
#import "ZHMyFavs.h"
#import "TotalAPI.h"
#import "ZHPerson.h"
#import "ZHTeamsTransferInfoController.h"
@interface ZHPlayerViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)ZHFavourite *currentTeam;
@property(nonatomic,weak)UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation ZHPlayerViewController

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
    [ZHHttpTool Get:ZHTeamsAllPlayerURL(self.currentTeam.team_id) parameters:nil acceptableContentTypes:@"text/html" success:^(id responseObject) {
        [ZHPerson mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"league_statistics":@"membership[0].statistics[0]"};
            
        }];
        
        self.dataArray = [ZHPerson mj_objectArrayWithKeyValuesArray:responseObject];
        //将教练拿到最前面
        NSMutableArray *array = [NSMutableArray array];
        NSMutableArray *array2 = [NSMutableArray array];
        for (ZHPerson *person in self.dataArray) {
            if ([person.type containsString:@"教练"]) {
                [array addObject:person];
            }else
            {
                [array2 addObject:person];
            }
        }
         [array addObjectsFromArray:array2];
        self.dataArray = array;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
#pragma mark SETUPUI
- (void)setupTableView
{
    UITableView *tv = [[UITableView alloc]initWithFrame:self.view.bounds];
    tv.height = self.view.height - ZHTeamsTVTopViewHeight;
    tv.width = self.view.width;
    [self.view addSubview:tv];
    self.tableView = tv;
    self.tableView.rowHeight = 200;
//    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 35, 0);
    self.tableView.alwaysBounceVertical = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZHPlayerCell *cell = [ZHPlayerCell cellWithTableView:tableView];
    cell.person = self.dataArray[indexPath.row];
    [UIView animateWithDuration:0.5 animations:^{
        cell.iconView.size  = CGSizeMake(10, 10);
        
    }];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ZHPlayerCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"ZHPlayerCell" owner:nil options:nil]lastObject];
    cell.backgroundColor = tableViewBGColor;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushClick:)];
        [cell addGestureRecognizer:tap];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

//监听sectionHeader的点击效果
- (void)pushClick:(id)sender {
    //回调的block
    __weak typeof(self)weakSelf = self;
    ZHFavourite *team = weakSelf.currentTeam;
    
    UINavigationController *NGVC = weakSelf.parentViewController.parentViewController.navigationController;
    
    ZHTeamsTransferInfoController *pageVC = [[ZHTeamsTransferInfoController alloc]init];
    pageVC.currentTeam = team;
    [NGVC pushViewController:pageVC animated:YES];
    pageVC.title = [NSString stringWithFormat:@"%@转会",team.club_name];
}

#pragma mark deletegate
#pragma mark 进入母控制器 就进行控件的配置
-(void)willMoveToParentViewController:(UIViewController *)parent
{
    [self setupTableView];
    [self reloadTableViewData];
}

@end
