//
//  ZHBaseSettingViewController.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/5.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHBaseSettingViewController.h"
#import "ZHSettingItemGroup.h"
#import "ZHSettingItem.h"
#import "ZHSettingCell.h"
#import "ZHSettingSwitchItem.h"
#import "ZHSettingArrowItem.h"
#import "UIBarButtonItem+Extension.h"
#import "TotalAPI.h"
#import "ZHSkinTool.h"
#import "UIImage+ZH.h"
#import "ZHSettingButtonItem.h"
@interface ZHBaseSettingViewController ()

@end

@implementation ZHBaseSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNaviBar];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeTheme) name:@"theme" object:nil];
}
- (void)changeTheme
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage colorfulPicture:[ZHSkinTool skinToolWithNorBGColor] withSize:CGSizeMake(375, 64)] forBarMetrics:UIBarMetricsDefault];
}

//创建子控件
- (void)setupNaviBar
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImageName:@"topbar_left_ic_back_default" highlitedImageName:@"topbar_left_ic_back_pressed" imageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 20) andTarget:self action:@selector(back)];
}

- (void) back
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 懒加载
- (NSMutableArray *)ItemsGroupDatas
{
    if (_ItemsGroupDatas == nil) {
        _ItemsGroupDatas = [NSMutableArray array];
    }
    return _ItemsGroupDatas;
}

      
#pragma mark - 初始化方法
- (id)init
{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        self.tableView.backgroundColor = tableViewBGColor;
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStylePlain];
}


#pragma mark - UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.ItemsGroupDatas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 先取出对应组的小数组
    ZHSettingItemGroup *g = self.ItemsGroupDatas[section];
    // 返回小数组的长度
    return g.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    ZHSettingCell *cell = [ZHSettingCell cellWithTableView:tableView];
    
    // 先取出对应组的组模型
    ZHSettingItemGroup *g = self.ItemsGroupDatas[indexPath.section];
    //  从组模型中取出对应行的模型
    ZHSettingItem *item = g.items[indexPath.row];
    cell.item = item;
    
    // 3.返回cell
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 立即取消选中
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 先取出对应组的组模型
    ZHSettingItemGroup *g = self.ItemsGroupDatas[indexPath.section];
    //  从组模型中取出对应行的模型
    ZHSettingItem *item = g.items[indexPath.row];
    // 判断block中是否保存了代码
    if (item.optionBlock) {
        // 如果保存,就执行block中保存的代码
        item.optionBlock();
    }else if ([item isKindOfClass:[ZHSettingArrowItem class]]||[item isKindOfClass:[ZHSettingButtonItem class]]) {
        // 创建目标控制并且添加到栈中
        ZHSettingArrowItem *arrowItem = (ZHSettingArrowItem *)item;
        
        UIViewController *vc = [[arrowItem.destVC alloc] init];
        // 设置目标控制器导航条的标题
        vc.title = arrowItem.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    ZHSettingItemGroup *g = self.ItemsGroupDatas[section];
    return g.footerTitle;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    ZHSettingItemGroup *g = self.ItemsGroupDatas[section];
//
    if (g.footerTitle) {
        return 20;
    }
    return 0.1;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

#pragma mark dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
