//
//  ZHAddFavController.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/7.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHAddFavController : UIViewController
@property (nonatomic,copy)void(^refreshBlock) (void);

/**
 *  存储着热门球队模型的数据组
 */
@property (nonatomic ,copy) NSArray *dataSource;
@property (nonatomic,weak)  UITableView *tableView;
@end
