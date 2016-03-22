//
//  ZHDetailSettingViewController.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/4.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHSettingViewController.h"
#import "ZHSettingArrowItem.h"  
#import "ZHSettingButtonItem.h" 
#import "ZHSettingItemGroup.h"
#import "ZHSettingSwitchItem.h"
#import "SDImageCache.h"
#import "MBProgressHUD+MJ.h"
#import "NSString+Extension.h"
@interface ZHSettingViewController ()

@end

@implementation ZHSettingViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    [self addGroup0Item];
    [self addGroup1Item];
    [self addGroup2Item];
    [self addGroup3Item];
}
#pragma mark 添加第0组的模型数据
- (void)addGroup0Item
{
    ZHSettingItemGroup *g0 = [[ZHSettingItemGroup alloc]init];
    ZHSettingButtonItem *buttonItem = [[ZHSettingButtonItem alloc]initWithTitle:@"账号管理" destClass:nil iconName:@"public_user_avatar_circle" rightTitle:@"登陆/注册"];
    g0.items = @[buttonItem];
    [self.ItemsGroupDatas addObject:g0];
}
#pragma mark 添加第1组的模型数据
- (void)addGroup1Item
{
    ZHSettingItemGroup *g1 = [[ZHSettingItemGroup alloc]init];
    ZHSettingSwitchItem *switchItem = [[ZHSettingSwitchItem alloc]initWithTitle:@"接收通知"];
    ZHSettingButtonItem *buttonItem = [[ZHSettingButtonItem alloc]initWithTitle:@"球队主题" destClass:NSClassFromString(@"ZHTeamThemeViewController") iconName:@"arsenal" rightTitle:nil];
    buttonItem.destVC = NSClassFromString(@"ZHTeamThemeViewController");
    
    //清除缓存
    ZHSettingItem *clearCacheItem = [[ZHSettingItem alloc]initWithTitle:@"清除缓存"];
    
    NSString *clearCachePath = [[SDImageCache sharedImageCache] diskCachePath];
    long long fileSize = [clearCachePath fileSize];
    
    clearCacheItem.subTitle = [NSString stringWithFormat:@"竟然有(%.1fM)赶紧清除", fileSize / (1000.0 * 1000.0)];
    
    __weak typeof(clearCacheItem) weakClearCache = clearCacheItem;
    __weak typeof(self) weakVc = self;
    clearCacheItem.optionBlock = ^{
        [MBProgressHUD showMessage:@"正在清除缓存...."];
        
        // 清除缓存
        NSFileManager *mgr = [NSFileManager defaultManager];
        [mgr removeItemAtPath:clearCachePath error:nil];
        
        // 设置subtitle
        weakClearCache.subTitle = @"我已经空空如也";
        
        // 刷新表格
        [weakVc.tableView reloadData];
        
        [MBProgressHUD hideHUD];
    };
    
    
    
    g1.items = @[switchItem,buttonItem,clearCacheItem];
    [self.ItemsGroupDatas addObject:g1];
}
#pragma mark 添加第2组的模型数据
- (void)addGroup2Item
{
    ZHSettingItemGroup *g2 = [[ZHSettingItemGroup alloc]init];
    ZHSettingArrowItem *arrowItem = [[ZHSettingArrowItem alloc]initWithTitle:@"赛程日历" destClass:NSClassFromString(@"")];//(@"ZHScheduleViewController")];
    g2.footerTitle = @"把主队的赛程添加到手机日历中";
    g2.items = @[arrowItem];
    [self.ItemsGroupDatas addObject:g2];
}
#pragma mark 添加第3组的模型数据
- (void)addGroup3Item
{
    ZHSettingItemGroup *g3 = [[ZHSettingItemGroup alloc]init];

    ZHSettingArrowItem *arrowItem1 = [[ZHSettingArrowItem alloc]initWithTitle:@"关于有球必火" destClass:NSClassFromString(@"")];//(@"ZHAboutViewController")];
    ZHSettingArrowItem *arrowItem2 = [[ZHSettingArrowItem alloc]initWithTitle:@"给我们建议" destClass:NSClassFromString(@"")];//(@"ZHFeedbackViewController")];
    
    g3.items = @[arrowItem1,arrowItem2];
    [self.ItemsGroupDatas addObject:g3];
}
@end
