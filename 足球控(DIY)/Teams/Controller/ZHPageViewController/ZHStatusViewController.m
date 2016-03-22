//
//  ZHStatusViewController.m
//  足球控(DIY)
//
//  Created by Aaron on 15/12/30.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import "ZHStatusViewController.h"
#import "ZHTeamsTableView.h"
#import "ZHRefreshGifHeader.h"
#import "ZHRefreshGifFooter.h"
#import "ZHStatus.h"
#import "MJExtension.h"
#import "ZHStatusCell.h"
#import "ZHStatusSecCell.h"
#import "ZHStatusTopCell.h"
#import "ZHMyFavs.h"
#import "UIView+Extension.h"
#import "ZHHttpTool.h"
#import "TotalAPI.h"
#import "ZHFavourite.h"
#import "ZHStatusFrame.h"
typedef enum
{
    ZHStatusRefreshTypeLastest,
    ZHStatusRefreshTypeBefore,
    
} ZHStatusRefreshType;


@interface ZHStatusViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)ZHFavourite *currentTeam;
@end

@implementation ZHStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    ZHFavourite *fav = [ZHMyFavs selectedTeam];
    //设置当前球队
    self.currentTeam = fav;
    [self loadStatuses:ZHStatusRefreshTypeLastest];
}
#pragma mark SETUPUI
- (void)setupTableView
{
    UITableView *tv = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];

    tv.height = self.view.height - ZHTeamsTVTopViewHeight - self.tabBarController.tabBar.height;
    tv.width = self.view.width;
//    tv.backgroundColor = ZHColor(239, 239, 239);
    [self.view addSubview:tv];
    self.tableView = tv;
    self.tableView.alwaysBounceVertical = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.contentInset = UIEdgeInsetsMake(0.1, 0, -0.1, 0);
    //设置刷新控件
    //设置下拉 refreshing
    ZHRefreshGifHeader *header = [ZHRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    //闲置状态
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    //拉紧状态
    [header setTitle:@"释放刷新" forState:MJRefreshStatePulling];
    //刷新状态
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    self.tableView.mj_header = header;
    
    ZHRefreshGifFooter *footer = [ZHRefreshGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    //闲置状态
    [footer setTitle:@"上拉加载" forState:MJRefreshStateIdle];
    //拉紧状态
    [footer setTitle:@"释放加载" forState:MJRefreshStatePulling];
    //刷新状态
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    
    self.tableView.mj_footer = footer;
}
//下拉刷新
- (void)headerRefresh
{
    [self loadStatuses:ZHStatusRefreshTypeLastest];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView.mj_header endRefreshing];
    });
}
//上拉刷新
-(void)footerRefresh
{
    [self loadStatuses:ZHStatusRefreshTypeBefore];
}
#pragma mark 加载微博 最新或者之前的 或者第一次
- (void)loadStatuses:(ZHStatusRefreshType)type
{   //存储现在的微博id
    ZHStatus *status;
    NSString *IDstr;
    //取到第一条或者最后的微博的id号 发送请求 请求这之后的所有微博
//    if (self.statusesArray.count) {
        if (type == ZHStatusRefreshTypeLastest) {
            IDstr = @"0";
        }
        else{
            status = [self.statusesArray lastObject];
            IDstr =status.idstr;
        }
//    }
    //请求微博数据
    [ZHHttpTool Get:ZHTeamsLastestStutasURL(self.currentTeam.team_id, IDstr) parameters:nil acceptableContentTypes:@"application/json" success:^(id responseObject) {
        //将新数据添加进模型数组
        //利用第三方框架进行模型字典转换
//        //        [ZHStatus mj_s]
//        [ZHStatus mj_setupObjectClassInArray:^NSDictionary *{
//            return @{
//                     @"pic_urls" : @"ZHStatusPic"//这个数组pic_urls里要存有[ZHStatusPic class]
//                     };
//        }];
        NSArray *statuses =[ZHStatus mj_objectArrayWithKeyValuesArray: responseObject[0][@"data"][@"weibo"]];
        NSMutableArray *mArray = [NSMutableArray arrayWithArray:statuses];
        //判断是最新还是之前的微博进行数据的存储与刷新
        if (type == ZHStatusRefreshTypeLastest) {
            
            //去重..
            NSString *timeEarliest;
            NSMutableArray *lastestStatus = [NSMutableArray array];
            if (self.statusesArray.count > 0) {
                timeEarliest = [[self.statusesArray firstObject] created_at];
                NSDateFormatter *fm = [[NSDateFormatter alloc]init];
                [fm setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
                NSDate *date1 = [fm dateFromString:timeEarliest];
                for (ZHStatus *status in mArray) {
                    NSString *time = status.created_at;
                    //判断是否有之前的早
                    NSDate *date2 = [fm dateFromString:time];
                    NSTimeInterval timeInterval = [date2 timeIntervalSinceDate:date1];
                    if (timeInterval >0) {
                        [lastestStatus addObject:status];
                    }
                    else{
                        break;
                    }
                }
            }else
            {
                lastestStatus = mArray;
            }
            
            [lastestStatus addObjectsFromArray:self.statusesArray];
            self.statusesArray = lastestStatus;
        }
        else
        {
            //删除重复的第一条
            self.statusesArray = [self.statusesArray arrayByAddingObjectsFromArray:mArray];
            [_tableView.mj_footer endRefreshing];
        }
        NSLog(@"%lu",self.statusesArray.count);
        [_tableView reloadData];
        if (!type) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.statusesArray.count + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        ZHStatusTopCell *cell = [ZHStatusTopCell cellWithTableView:tableView];
        cell.favourite = self.currentTeam;
        return cell;
    }
    if (indexPath.section == 1) {
        ZHStatusSecCell *cell = [ZHStatusSecCell cellWithTableView:tableView];
        cell.favourite = self.currentTeam;
        return cell;
    }
    //    取出数据
    ZHStatus *status = self.statusesArray[indexPath.section - 2];
    ZHStatusFrame *statusFrame = [ZHStatusFrame statusFrameWithStatus:status];
    ZHStatusCell *cell = [ZHStatusCell cellWithTableView:tableView];
    //    给cell传递模型数据
    cell.status = status;
    //    传递 frame
    cell.statusFrame = statusFrame;
    return cell;
}


#pragma mark 代理方法
//设置header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section <2) {
        return 50;
        
    }
    ZHStatusFrame *statusFrame = [ZHStatusFrame statusFrameWithStatus:self.statusesArray[indexPath.section - 2]];
    return statusFrame.viewHeight;
}
- (void)reloadTableViewData
{
    ZHFavourite *fav = [ZHMyFavs selectedTeam];
    //重置当前球队
    if ([fav isEqual:self.currentTeam]) {
        
    }else
    {
        self.currentTeam = fav;
        //重置数据
        self.statusesArray = [NSArray array];
    }
//    self.tableView.contentOffset = CGPointMake(0, 0);
    [self loadStatuses:ZHStatusRefreshTypeLastest];
}
@end
