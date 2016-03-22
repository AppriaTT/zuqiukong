//
//  ZHStatusCell.h
//  无道博博
//
//  Created by Aaron on 15/12/23.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHStatus.h"
#import "ZHStatusFrame.h"
#import "ZHStatusDetailView.h"
#import "ZHStatusToolBar.h"

@interface ZHStatusCell : UITableViewCell
@property (nonatomic,strong)  ZHStatus *status;
@property (nonatomic,strong)  ZHStatusFrame *statusFrame;
@property (nonatomic,strong)  ZHStatusDetailView *detailView;
@property (nonatomic,strong)  ZHStatusToolBar *toolBar;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
