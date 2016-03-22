//
//  ZHTableViewCell.h
//  tabController
//
//  Created by Aaron on 15/11/11.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHMatchVS.h"
@interface ZHMatchesVSCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgA;
@property (weak, nonatomic) IBOutlet UIImageView *imgB;
@property (weak, nonatomic) IBOutlet UILabel *vsResult;
@property (weak, nonatomic) IBOutlet UILabel *A_name;
@property (weak, nonatomic) IBOutlet UILabel *B_name;
@property (weak, nonatomic) IBOutlet UILabel *competitionName;
@property (weak, nonatomic) IBOutlet UILabel *time;

//对阵模型
@property (nonatomic,strong)  ZHMatchVS *model;

- (instancetype) initWithTableView :(UITableView *)tableView;
+ (instancetype) cellWithTableView :(UITableView *)tableView;
@end
