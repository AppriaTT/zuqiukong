//
//  ZHViewController.h
//  UIFengzhuang
//
//  Created by Aaron on 15/12/21.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHHotMatchViewController : UIViewController
@property(nonatomic,weak)UITableView *tableView;
@property (nonatomic,strong) NSArray *dataSourceArray;
/**
 *  用日期和时间排序
 *
 *  @param array 传入需要进行排序的数组,此为模型
 *
 *  @return 返回排序好的数据
 */
- (NSArray *)sortArrayWithDataAndTime:(NSArray *)array;
@end
