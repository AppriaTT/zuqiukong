//
//  ZHPageRootNormalController.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/13.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHPageRootNormalController.h"
#import "ZHLeague.h"
#import "ZHTeamPerformance.h"
@interface ZHPageRootNormalController ()

@end

@implementation ZHPageRootNormalController
{
    NSArray *_dataSourceArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupTableView
{
    UITableView *tv = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:tv];
    self.tableView = tv;
    self.tableView.height = self.tableView.height - self.navigationController.navigationBar.height - 20 - self.tabBarController.tabBar.height;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

//请求数据
-  (void)receiveModel:(NSNotification *)sender
{
    self.league = sender.object;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    return cell;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDragging%s",__func__);
}
@end
