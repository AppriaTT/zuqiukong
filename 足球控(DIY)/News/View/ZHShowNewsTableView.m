//
//  ZHShowNewsTableView.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/5.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHShowNewsTableView.h"
#import "ZHAdvertisementSView.h"
#import "ZHSectionHeaderView.h"
#import "ZHNewsCell.h"
#import "ZHSmallVideoCell.h"
#import "ZHRefreshGifHeader.h"
#import "ZHRefreshGifFooter.h"
#import "UIView+ViewController.h"
@interface ZHShowNewsTableView ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation ZHShowNewsTableView
{
    NSInteger _lastContentOffSetY;
}
- (void)setNewsArray:(NSArray *)newsArray
{
    _newsArray = newsArray;
    [self reloadData];
}

#pragma mark 顶部广告条
- (void)setBannersArray:(NSArray *)bannersArray
{
    _bannersArray = bannersArray;
    ZHAdvertisementSView *adV = (id)self.tableHeaderView;
    //传入 imgURL数组
    NSMutableArray *imgArray = [NSMutableArray array];
    for (ZHNews *news in _bannersArray) {
        [imgArray addObject:news.img];
    }

    [adV addImages:imgArray];
    //创建回调的block ,返回数据给原始控制器
    [adV setImgViewClickHandler:^(NSInteger index) {
        self.adSViewClickHandler(_bannersArray[index]);
        
    }];
}

//外部传递数据进来
- (void)setSmallVideoArray:(NSArray *)smallVideoArray
{
    _smallVideoArray = smallVideoArray;
    [self reloadData];
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        ZHAdvertisementSView *adV = [ZHAdvertisementSView advertisementScrollVeiw];
        
        self.tableHeaderView = adV;
        [self setupRefreshUI];
    }
    return self;
}

#pragma setup刷新控件
- (void)setupRefreshUI
{
    //设置下拉 refreshing
    ZHRefreshGifHeader *header = [ZHRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    //闲置状态
    [header setTitle:@"下拉刷新最新消息" forState:MJRefreshStateIdle];
    //拉紧状态
    [header setTitle:@"释放加载最新消息" forState:MJRefreshStatePulling];
    //刷新状态
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    self.mj_header = header;

    ZHRefreshGifFooter *footer = [ZHRefreshGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    //闲置状态
    [footer setTitle:@"上拉加载更多消息" forState:MJRefreshStateIdle];
    //拉紧状态
    [footer setTitle:@"释放加载更多消息" forState:MJRefreshStatePulling];
    //刷新状态
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    
    self.mj_footer = footer;

}
//下拉刷新
- (void)headerRefresh
{
    NSLog(@"headerRefresh");
    self.refreshBlock();
    
   
}
//上拉刷新
-(void)footerRefresh
{
    NSLog(@"footerRefresh");
    self.refreshBlock();
}
#pragma mark 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
    }
    return self.newsArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ZHSmallVideoCell *cell = [ZHSmallVideoCell cellWithTableView:tableView];
        cell.smallVideos = self.smallVideoArray;
        return cell;
    }
    ZHNewsCell *cell = [ZHNewsCell cellWithTableView:tableView];
    ZHNews *news = self.newsArray[indexPath.row];
    
    cell.news = news;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 150;
    }
    return 100;
}
#pragma mark UITableView代理
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        ZHSectionHeaderView *headerView = [ZHSectionHeaderView headerViewWithIndex:section];
        [headerView setMoreClickblock:^{
            NSLog(@"点击了更多按钮");
            
        }];
        return headerView;
    }
    else
    {
        ZHSectionHeaderView *headerView = [ZHSectionHeaderView headerViewWithIndex:section];
        [headerView setNewsClickblock:^{
            NSLog(@"点击了 流言官宣按钮");
            
        }];
        return headerView;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 1) {
        //调用 tableView的cell点击block
        self.cellClickHandler(self.newsArray[indexPath.row],indexPath);
    }
    else
    {
        self.cellClickHandler(self.smallVideoArray,indexPath);
    }
}
@end
