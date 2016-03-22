//
//  ZHHotTeamTableViewCell.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/7.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHFavourite.h"
@interface ZHFavouriteCell : UITableViewCell
@property (nonatomic,copy)void(^accessoryHandler) (ZHFavouriteCell*cell);
//是否被选中
@property (nonatomic,assign,getter=isAccessoryBtnSel)BOOL accessoryBtnSel;


//模型
@property (nonatomic,strong)  ZHFavourite *favourite;

- (instancetype) initWithTableView :(UITableView *)tableView;
+ (instancetype) cellWithTableView :(UITableView *)tableView;
@end
