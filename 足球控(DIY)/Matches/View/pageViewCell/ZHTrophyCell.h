//
//  ZHTrophyCell.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/16.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHTrophy;
@interface ZHTrophyCell : UITableViewCell
- (instancetype) initWithTableView :(UITableView *)tableView;
+ (instancetype) cellWithTableView :(UITableView *)tableView;
/**
 *  每年的锦标模型
 */
@property (nonatomic,strong)  ZHTrophy  *trophy;


@end
