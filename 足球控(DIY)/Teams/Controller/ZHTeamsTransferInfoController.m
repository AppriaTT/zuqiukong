//
//  ZHTeamsTransferInfoController.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/17.
//  Copyright © 2016年 叶无道. All rights reserved.
//

#import "ZHTeamsTransferInfoController.h"
#import "TotalAPI.h"
#import "ZHTeamsTransferCell.h"
#import "MJExtension.h"
#import "ZHPerson.h"
#import "ZHFavourite.h"
#import "UIBarButtonItem+Extension.h"
@interface ZHTeamsTransferInfoController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataInArray;
@property (nonatomic,strong) NSMutableArray *dataOutArray;
@end

@implementation ZHTeamsTransferInfoController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupNVbar
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNormalImageName:@"topbar_right_ic_share_default" highlitedImageName:@"topbar_right_ic_share_pressed" andTarget:self action:@selector(shareClick)];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImageName:@"topbar_left_ic_back_default" highlitedImageName:@"topbar_left_ic_back_pressed" imageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 20) andTarget:self action:@selector(backClick)];
}

- (void)shareClick
{
    NSLog(@"点击了分享");
}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setCurrentTeam:(ZHFavourite *)currentTeam
{
    _currentTeam = currentTeam;
    [self requestData];
}
#pragma mark SETUPUI
- (void)setupTableView
{
    UITableView *tv = [[UITableView alloc]initWithFrame:self.view.bounds];
    tv.height = self.view.height - 44-20;
//    tv.width = self.view.width;
    [self.view addSubview:tv];
    self.tableView = tv;
    self.tableView.rowHeight = 55;
    //    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 35, 0);
    self.tableView.alwaysBounceVertical = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)requestData
{
    __weak typeof(self)weakSelf = self;

    [ZHHttpTool Get:ZHTeamsAllPlayerTransferInURL(self.currentTeam.team_id) parameters:nil acceptableContentTypes:@"application/json" success:^(id responseObject) {
        
        [ZHPerson mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"transfer":@"transfer[0]"};
        }];
        
        self.dataInArray = [ZHPerson mj_objectArrayWithKeyValuesArray:responseObject ];
        
        weakSelf.dataInArray = [ZHPerson mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"error");
        
    }];
    
    [ZHHttpTool Get:ZHTeamsAllPlayerTransferOutURL(self.currentTeam.team_id) parameters:nil acceptableContentTypes:@"application/json" success:^(id responseObject) {
        self.dataOutArray = [ZHPerson mj_objectArrayWithKeyValuesArray:responseObject ];
        weakSelf.dataOutArray  = [ZHPerson mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"error");
        
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}// Default is 1 if not implemented

#pragma mark dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   if (section == 0)
        {
       return     self.dataInArray.count;
        }
    return self.dataOutArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZHTeamsTransferCell *cell = [ZHTeamsTransferCell cellWithTableView:tableView];
    if (!indexPath.section) {
        cell.player = self.dataInArray[indexPath.row];
    }else
    {
         cell.player = self.dataOutArray[indexPath.row];
    }
    cell.backgroundColor = indexPath.row % 2? tableViewBGColor:[UIColor whiteColor];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[NSBundle mainBundle]loadNibNamed:@"ZHTeamsTransferCell" owner:nil options:nil][section+1];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

#pragma mark deletegate
#pragma mark 进入母控制器 就进行控件的配置
-(void)willMoveToParentViewController:(UIViewController *)parent
{
    [self setupTableView];
    [self setupNVbar];  
    [self requestData];
}

@end
