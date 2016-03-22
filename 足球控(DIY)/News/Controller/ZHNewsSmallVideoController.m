//
//  ZHNewsSmallVideoController.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/10.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHNewsSmallVideoController.h"
#import "ZHSingVideoCell.h"
#import "UIBarButtonItem+Extension.h"
#import "ZHNewsSmallVideoShowController.h"
#import "UIView+Extension.h"
@interface ZHNewsSmallVideoController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak)UITableView *tableView;
@property (nonatomic,strong)  ZHNewsSmallVideoShowController *showVideoVC;

@end

@implementation ZHNewsSmallVideoController
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setupTableView];
        [self setupNVBar];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
#pragma mark setupUI
- (void)setupNVBar
{
    self.navigationItem.title = @"视频集锦";

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImageName:@"topbar_left_ic_back_default" highlitedImageName:@"topbar_left_ic_back_pressed" imageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 20) andTarget:self action:@selector(backClick)];
}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setupTableView
{
    //创建tableView
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView = tableView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.height -=64;
    _tableView.rowHeight = 150;
    [self.view addSubview:tableView];
}
-(ZHNewsSmallVideoShowController *)showVideoVC
{
    if (!_showVideoVC) {
        
        _showVideoVC = [[ZHNewsSmallVideoShowController alloc]init];
    }
    return _showVideoVC ;
}
- (void)setVideos:(NSArray *)videos
{
    _videos = videos;
    [self.tableView reloadData];
}

#pragma mark 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.videos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZHSingVideoCell *cell = [ZHSingVideoCell cellWithTableView:tableView];
    cell.video = self.videos[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [self.navigationController pushViewController:self.showVideoVC animated:YES];
    self.showVideoVC.video = self.videos[indexPath.row];
}

@end
