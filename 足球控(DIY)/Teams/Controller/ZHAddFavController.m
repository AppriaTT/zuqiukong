//
//  ZHAddFavController.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/7.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHAddFavController.h"
#import "ZHSeaResultController.h"
#import "UIView+Extension.h"
#import "ZHSectionHeader.h"
#import "ZHSearchViewController.h"
#import "ZHFavourite.h"
#import "ZHFavouriteCell.h"
#import "ZHMyFavs.h"
#import "ZHTools.h"
@interface ZHAddFavController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ZHAddFavController
{
    UISearchController *_seaController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self setupTableView];
    [self setupUI];
    [self setupSearchController];
    self.tableView.backgroundColor = ZHColor(235, 235, 235);
}
- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    self.tableView.y +=40;
    self.tableView.height = self.tableView.height - 40 - 64;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
- (void)setDataSource:(NSArray *)dataSource
{
    _dataSource = dataSource;
    [self.tableView reloadData];
}
 //创建子控件
- (void)setupUI
{
    //左键
    UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"topbar_left_ic_back_default"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"topbar_left_ic_back_pressed"] forState:UIControlStateHighlighted];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 20);
    [button addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0,0,40,40);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];

    //文字
    self.navigationItem.title = @"添加关注";
    //右键 点击完成是一样的效果
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

- (void)completeClick
{
    [self backBtnClick];
}
//创建搜索控制器
- (void)setupSearchController
{
    ZHSearchViewController *seaController = [[ZHSearchViewController alloc]initWithSearchResultsController:[[ZHSeaResultController alloc]init]];
#warning 搜索功能
    seaController.searchBar.hidden = YES;
    
    [self.view addSubview:seaController.searchBar];
    [self addChildViewController:seaController];
    _seaController = seaController;
}
//弹回控制器之后要调用的代码
- (void) backBtnClick
{
    [self dismissViewControllerAnimated:YES completion:^{
        //刷新我的关注tView
        self.refreshBlock();
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *norID = @"norCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:norID];
        if (cell == nil) {
            UITableViewCell *newC = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:norID];
            cell = newC;
        }
        switch (indexPath.row) {
            case 0:
                cell.imageView.image = [UIImage imageNamed:@"teams_choose_ic_nationalteam"];
                cell.textLabel.text = @"国家队";
                break;
            case 1:
                cell.imageView.image = [UIImage imageNamed:@"teams_choose_ic_allteams"];
                cell.textLabel.text = @"所有球队";
                break;
            case 2:
                cell.imageView.image = [UIImage imageNamed:@"teams_choose_ic_addleague"];
                cell.textLabel.text = @"关注联赛";
                break;
            default:
                break;
        }
        cell.accessoryView.hidden = YES;
        return cell;
    }
    ZHFavouriteCell *cell = [ZHFavouriteCell cellWithTableView:tableView];
    ZHFavourite *fav = self.dataSource[indexPath.row];
    //传递数据
    cell.favourite = fav;
    return cell;
}
#pragma mark UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {return nil;}
    ZHSectionHeader *header = [ZHSectionHeader header];
    header.titleLable.text = @"热门球队";
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section

{
    if (section == 1) {
        return 40;
    }
    return 0.1;
}

//点击了某一行就选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
    }
    
    if (indexPath.section == 1) {
        ZHFavouriteCell *cell = (id)[tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryBtnSel = !cell.isAccessoryBtnSel;
        if (cell.isAccessoryBtnSel) {
            //添加到关注
            [ZHMyFavs addObj:self.dataSource[indexPath.row]];
        }
        else{
            [ZHMyFavs deleteObj:self.dataSource[indexPath.row]];
        }
    }
    //立马进行归档,防止断电
    [ZHTools archiveObjecjsInSandBox:[ZHMyFavs myFavs] withName:@"myFavs.data"];
}
@end
