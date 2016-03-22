//
//  ZHAllLeagueController.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/13.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHAllLeagueController.h"
#import "UIBarButtonItem+Extension.h"
#import "TotalAPI.h"
#import "ZHArea.h"
#import "ZHCountry.h"
#import "ZHLeague.h"
#import "ZHMatchesPageViewController.h"
@interface ZHAllLeagueController ()
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation ZHAllLeagueController
{
    NSArray *_array;
    NSArray *_newCell;//用于保存新的cell中的数据
    NSArray *_indexPathArray;//用于保存更新过的indexPath
    UITableViewCell *_lastCell;//用于保存之前更新过的cell
    UITableViewCell *_presentCell;
//    NSIndexPath *_presentIndexPath;//用于保存现在的indexPath
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    [self setupNVbar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (void)requestData
{
    [ZHHttpTool Get:ZHMatchesAllLeaguesURL parameters:nil acceptableContentTypes:@"text/html" success:^(id responseObject) {
        [ZHArea mj_setupObjectClassInArray:^NSDictionary *{
          return @{@"area":@"ZHCountry",@"":@""};
        }];
        self.dataArray = [ZHArea mj_objectArrayWithKeyValuesArray:responseObject[@"area"]];
        for (int i = 0; i < self.dataArray.count - 1; i++) {
            ZHArea *area1 = self.dataArray[i];
            for (int j = i+1; j < self.dataArray.count; j++) {
                
                ZHArea *area2 = self.dataArray[j];
                if (area1.area.count < area2.area.count) {
                    [self.dataArray exchangeObjectAtIndex:i withObjectAtIndex:j];
                }
                
            }
            
        }
        _array = @[[self.dataArray[0] area][0]];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZHArea *area = self.dataArray[section];
    return area.area.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault     reuseIdentifier:@"cell"];
        
        //副cell 不同颜色
        cell.backgroundColor = [UIColor lightGrayColor];
    }
    ZHArea *area = self.dataArray[indexPath.section];
    ZHCountry *country = area.area[indexPath.row];
    cell.textLabel.text = country.name;

    if ([country isKindOfClass:NSClassFromString(@"ZHCountry")]) {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:ZHMatchesAllLeaguesCountriesIconURL(country.area_id)] placeholderImage:[UIImage imageNamed:@"teams_xcong_ic_close"]];
        cell.backgroundColor = [UIColor whiteColor];
    }else
    {   ZHLeague *league = (id)country;
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:ZHMatchesAllMatchesLeagueIcon(league.competition_id)]placeholderImage:[UIImage imageNamed:@"teams_league_default_logo"]];
        cell.backgroundColor = tableViewBGColor;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ZHArea *area = self.dataArray[section];
    return area.name;
}


#warning 有一点bug
//点击后添加与删除cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //判断点到的是哪个cell
    ZHArea *nowArea = self.dataArray[indexPath.section];
    ZHCountry *nowCountry = nowArea.area[indexPath.row];
    if ([nowCountry isKindOfClass:NSClassFromString(@"ZHCountry")]) {
        _presentCell = [tableView cellForRowAtIndexPath:indexPath];
        
        //如果上个cell是开的那么关闭
        if (_lastCell && !nowCountry.isOpen) {
            [self closeCellAtIndexPath:[tableView indexPathForCell:_lastCell]];
            //并打开现在的cell
            [self openCellAtIndexPath:[tableView indexPathForCell:_presentCell]];
        }else if (!nowCountry.isOpen) {//关
            [self openCellAtIndexPath:[tableView indexPathForCell:_presentCell]];
        }else
        {//开
            [self closeCellAtIndexPath:indexPath];
        }
    }else//这是副cell
    {
        ZHMatchesPageViewController *p = [[ZHMatchesPageViewController alloc]init];
        
        ZHLeague *league = (id)nowCountry;
        
        //请求season_id
        [ZHHttpTool Get:ZHMatchesAllMatchesGetSeasonID(league.competition_id) parameters:nil acceptableContentTypes:@"application/json" success:^(id responseObject) {
            league.season_id = responseObject[@"data"][@"season_id"];
            //传入数据
            p.league = league;
            //刷新数据
            [p sendDataToChildController];
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        [self.navigationController pushViewController:p animated:YES];
        p.title = league.name;
    }
    
    
}

// 打开
- (void)openCellAtIndexPath:(NSIndexPath *)indexPath
{
   
    ZHArea *area = self.dataArray[indexPath.section];
    ZHCountry *country = area.area[indexPath.row];
    //    //用于更改的可变数组
    //发送请求 加载国家中的联赛
    [ZHHttpTool Get:ZHMatchesAllLeaguesCountriesLeaguesURL(country.area_id) parameters:nil acceptableContentTypes:@"text/html" success:^(id responseObject) {
        
        country.leagues = [ZHLeague mj_objectArrayWithKeyValuesArray:responseObject];
        //用于后期删除
        _newCell = country.leagues;
        //创建多个cell新位置的indexSet
        NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndexesInRange:NSMakeRange(indexPath.row + 1, country.leagues.count)];
        [area.area insertObjects:country.leagues atIndexes:indexSet];
        // 1.添加cell 的位置数据
        NSMutableArray *indexPathArray = [NSMutableArray array];
//        _indexPathArray = indexPathArray;
        for (int i = 0; i < country.leagues.count; i++) {
            [indexPathArray addObject:[NSIndexPath indexPathForItem:indexPath.row+ 1 + i inSection:indexPath.section]];
        }
        //2.添加动画
        [self.tableView insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationAutomatic];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    _lastCell = [self.tableView cellForRowAtIndexPath:indexPath];
    country.open = YES;
}
// 关闭
-(void)closeCellAtIndexPath:(NSIndexPath *)indexPath
{
    ZHArea *area = self.dataArray[indexPath.section];
    ZHCountry *country = area.area[indexPath.row];
    //去掉这些cell
    for (ZHLeague *league in _newCell) {
        [area.area removeObject:league];
    }
    NSMutableArray *indexPathArray = [NSMutableArray array];
    
    for (int i = 0; i < country.leagues.count; i++) {
        [indexPathArray addObject:[NSIndexPath indexPathForItem:indexPath.row+ 1 + i inSection:indexPath.section]];
    }
    //添加动画
    [self.tableView deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationAutomatic];
    
    _lastCell = nil;
    country.open = NO;
}
@end
