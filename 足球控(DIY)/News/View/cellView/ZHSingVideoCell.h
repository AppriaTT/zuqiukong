//
//  ZHSingVideoCell.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/10.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHSmallVideo;

@interface ZHSingVideoCell : UITableViewCell
//模型数组
@property (nonatomic,copy)  ZHSmallVideo *video;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIImageView *picView;


- (instancetype) initWithTableView :(UITableView *)tableView;
+ (instancetype) cellWithTableView :(UITableView *)tableView;
@end
