//
//  ZHSettingCell.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/5.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHSettingItem.h"
@interface ZHSettingCell : UITableViewCell

@property (nonatomic,strong)  ZHSettingItem *item;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
