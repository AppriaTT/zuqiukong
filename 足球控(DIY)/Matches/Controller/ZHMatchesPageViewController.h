//
//  ZHMatchesPageViewController.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/12.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHLeague;
@interface ZHMatchesPageViewController : UIViewController
@property (nonatomic,strong)  ZHLeague *league;

/**
 *  刷新各个子视图中tableview的数据
 */
- (void)reloadData;

- (void) sendDataToChildController;
@end
