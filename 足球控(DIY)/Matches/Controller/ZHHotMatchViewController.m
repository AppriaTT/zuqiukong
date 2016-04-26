//
//  ZHViewController.m
//  UIFengzhuang
//
//  Created by Aaron on 15/12/21.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import "ZHHotMatchViewController.h"
#import "ZHMatchesVSCell.h"
#import "ZHMatchVS.h"
#import "UIView+Extension.h"
#import "ZHSectionHeader.h"
#import "ZHHttpTool.h"
#import "TotalAPI.h"
#import "MJExtension.h"
#import "ZHRefreshGifFooter.h"
#import "ZHRefreshGifHeader.h"
#import "ZHNGMainTool.h"
@interface ZHHotMatchViewController ()<UITableViewDataSource,UITableViewDelegate>
@end
@implementation ZHHotMatchViewController
{
     NSInteger _lastContentOffSetY;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self requestData : 1 later:7 ];
    self.tableView.rowHeight = 64;
}
- (void)setupTableView
{
    UITableView *tv = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:tv];
    self.tableView = tv;
    self.tableView.height = self.tableView.height - 49;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //设置刷新控件
    //设置下拉 refreshing
    ZHRefreshGifHeader *header = [ZHRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    //闲置状态
    [header setTitle:@"下拉加载前七天赛程" forState:MJRefreshStateIdle];
    //拉紧状态
    [header setTitle:@"释放加载前七天赛程" forState:MJRefreshStatePulling];
    //刷新状态
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    self.tableView.mj_header = header;
    
    ZHRefreshGifFooter *footer = [ZHRefreshGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    //闲置状态
    [footer setTitle:@"下拉加载后七天赛程" forState:MJRefreshStateIdle];
    //拉紧状态
    [footer setTitle:@"释放加载后七天赛程" forState:MJRefreshStatePulling];
    //刷新状态
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    
    self.tableView.mj_footer = footer;
}

//下拉刷新
- (void)headerRefresh
{
    NSLog(@"headerRefresh");
    [self.tableView.mj_header endRefreshing];
}
//上拉刷新
-(void)footerRefresh
{
    NSLog(@"footerRefresh");
    [self.tableView.mj_footer endRefreshing];
}

//加载最新数据
- (void)requestData:(long )before later:(long)later
{
    [ZHHttpTool Get:ZHMatchesHotTeamURL(before, later) parameters:nil acceptableContentTypes:@"application/json" success:^(id responseObject) {
        //数据分析!!!
        NSMutableArray *m = [NSMutableArray array];
        NSArray *competitions = responseObject[@"data"][@"list"];
        for (NSDictionary *dictCom in competitions) {
           NSArray *VSArray = [ZHMatchVS mj_objectArrayWithKeyValuesArray:dictCom[@"match"]];
            for (ZHMatchVS *matchVS in VSArray) {
                matchVS.name = dictCom[@"name"];
            }
            [m addObjectsFromArray:VSArray];
        }
        //排序数据 得到各个天数的比赛对阵
        self.dataSourceArray = [self sortArrayWithDataAndTime:m];
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

/**
 *  用日期和时间排序
 *
 *  @param array 传入需要进行排序的数组,此为模型
 *
 *  @return 返回排序好的数据
 */
- (NSArray *)sortArrayWithDataAndTime:(NSArray *)array
{
    //排序
    NSSortDescriptor *des1 = [NSSortDescriptor sortDescriptorWithKey:@"date_utc" ascending:YES];
    NSSortDescriptor *des2 = [NSSortDescriptor sortDescriptorWithKey:@"time_utc" ascending:YES];
    NSArray *desc = @[des1,des2];
    array = [array sortedArrayUsingDescriptors:desc];
    for (int i = 0; i < array.count; i++) {
        ZHMatchVS *vs = array[i];
        //对所有模型进行时间的调整,变成中国时区! +8个时区
        NSDateFormatter *f = [[NSDateFormatter alloc]init];
        [f setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSDate *date1 = [f dateFromString:[NSString stringWithFormat:@"%@ %@",vs.date_utc,vs.time_utc]];
        //八个时区 timeInterval
        NSTimeInterval timeInerval = 60*60*8;
        NSDate *date2 = [date1 dateByAddingTimeInterval:timeInerval];
        NSDateFormatter *fDate = [[NSDateFormatter alloc]init];
        NSDateFormatter *fTime = [[NSDateFormatter alloc]init];
        [fDate setDateFormat:@"MM-dd"];
        [fTime setDateFormat:@"HH:mm"];
        vs.date_utc = [fDate stringFromDate:date2];
        vs.time_utc = [fTime stringFromDate:date2];        
    }
    
    ZHMatchVS *vs = [array firstObject];
    
    //分组
    NSMutableArray *arrayM = [NSMutableArray array];
    NSMutableArray *mainMarray = [NSMutableArray array];
    
    NSString *date = vs.date_utc;
    for (int i = 0; i < array.count; i++) {
        ZHMatchVS *VS = array[i] ;
        if ([date isEqualToString:VS.date_utc]) {
            [arrayM addObject:VS];
            
        }else
        {
            [mainMarray addObject:arrayM];
            arrayM = [NSMutableArray array];
            [arrayM addObject:VS];
            date = VS.date_utc;
        }
    }
    array = mainMarray;
    return array;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    return [self.dataSourceArray[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZHMatchesVSCell *cell = [ZHMatchesVSCell cellWithTableView:tableView];

    ZHMatchVS *model = self.dataSourceArray[indexPath.section][indexPath.row];
    
    //    给cell传递模型数据
    cell.model = model;
    return cell;
}


#pragma mark UITableView代理方法
//设置header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

//设置headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ZHSectionHeader *header = [ZHSectionHeader header];
//    header.backgroundColor = tableViewBGColor;
    ZHMatchVS *vs = [self.dataSourceArray[section] firstObject];
    header.titleLable.text = vs.date_utc;
    return header;
}

#pragma mark UIScrollViewDelegate
//上拉隐藏导航栏, 下拉显示
- (void)scrollViewDidScroll:(UIScrollView*)scrollView{
    //_lastcontentoffset上一次滑动的距离
    if(scrollView.contentOffset.y>0) {
        
        [[ZHNGMainTool sharedVCTool].mainTabVC.selectedViewController setNavigationBarHidden:YES animated:YES];
        self.extendedLayoutIncludesOpaqueBars = YES;
        if(scrollView.contentOffset.y-_lastContentOffSetY<=0) {
            [[ZHNGMainTool sharedVCTool].mainTabVC.selectedViewController setNavigationBarHidden:NO animated:YES];
//            self.view.height -=44;
        }
    }
    _lastContentOffSetY=scrollView.contentOffset.y;
}
@end
