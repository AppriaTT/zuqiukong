//
//  ZHStatusViewController.h
//  足球控(DIY)
//
//  Created by Aaron on 15/12/30.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ZHStatusViewController : UIViewController
@property(nonatomic,weak)UITableView *tableView;
@property (nonatomic,strong) NSArray *statusesArray;

/**
 *  刷新视图中tableview的数据
 */
- (void)reloadTableViewData;
@end
