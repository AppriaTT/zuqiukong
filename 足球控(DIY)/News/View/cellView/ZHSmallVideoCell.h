//
//  ZHSmallVideoCell.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/6.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHSmallVideo.h"
@interface ZHSmallVideoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleBigL;
@property (weak, nonatomic) IBOutlet UILabel *titleTopL;
@property (weak, nonatomic) IBOutlet UILabel *titleBottomL;
@property (weak, nonatomic) IBOutlet UIImageView *bottomView;
@property (weak, nonatomic) IBOutlet UIImageView *bigView;
@property (weak, nonatomic) IBOutlet UIImageView *topView;
//模型数组
@property (nonatomic,copy)  NSArray *smallVideos;


- (instancetype) initWithTableView :(UITableView *)tableView;
+ (instancetype) cellWithTableView :(UITableView *)tableView;
@end
