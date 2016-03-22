//
//  ZHPageRootNormalController.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/13.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TotalAPI.h"
#import "UIView+Extension.h"

@class ZHLeague;
/**
 *  pageViewController 中后四个控制器的父类
 */
@interface ZHPageRootNormalController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak)UITableView *tableView;

@property (nonatomic,strong)  ZHLeague *league;

-  (void)receiveModel:(NSNotification *)sender;
@end
