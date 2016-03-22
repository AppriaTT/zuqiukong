//
//  ZHTeamThemeViewController.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/5.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHTeamThemeViewController.h"
#import "ZHTheme.h"
#import "ZHThemeCell.h"
#import "TotalAPI.h"
#import "ZHSkinTool.h"
#import "UIImage+ZH.h"
#import "UIBarButtonItem+Extension.h"
@interface ZHTeamThemeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak)UITableView *tableView;
@property (nonatomic ,copy) NSArray  * dataArray;
@end

@implementation ZHTeamThemeViewController
{
    ZHThemeCell *_selCell;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupNVbar];
    self.navigationItem.title = @"球队主题";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupTableView
{
    UITableView *tv = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tv ];
    self.tableView = tv;
    self.tableView.height -= 64;
    self.tableView.rowHeight = 75;
    self.tableView.delegate =self;
    self.tableView.dataSource   = self;
    self.tableView.bounces = NO;
//    tv.backgroundColor = [UIColor redColor];
    
    
}
- (void)setupNVbar
{
    self.navigationItem.title = @"所有联赛";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImageName:@"topbar_left_ic_back_default" highlitedImageName:@"topbar_left_ic_back_pressed" imageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 20) andTarget:self action:@selector(backClick)];
}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSArray *)dataArray
{
    if (!_dataArray) {
        NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"Theme.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:plistPath];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            ZHTheme *theme = [ZHTheme themeWithDict:dict];
            
            [arrM addObject:theme];
        }
        _dataArray = arrM;
    }
    return _dataArray;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHThemeCell *cell = [ZHThemeCell cellWithTableView:tableView];
    cell.model = self.dataArray[indexPath.row];
    [UIView animateWithDuration:0.5 animations:^{
        cell.teamBGView.size  = CGSizeMake(10, 10);
    }];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    ZHThemeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!_selCell) {
        for (int i = 0; i < self.dataArray.count; i ++) {
            ZHThemeCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cell.leftBtn.selected = NO;
        }
    }else
    {
        _selCell.leftBtn.selected = NO;
    }
    
    cell.leftBtn.selected = YES;
    _selCell = cell;
    ZHTheme *theme = cell.model;
    //进行换肤
    [ZHSkinTool setThemeName:theme.address team_id:theme.teamId];
    [self changeTheme];
}

- (void)changeTheme
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage colorfulPicture:[ZHSkinTool skinToolWithNorBGColor] withSize:CGSizeMake(375, 64)] forBarMetrics:UIBarMetricsDefault];
}
@end
