//
//  ZHStatusSecCell.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/8.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHFavourite;
@interface ZHStatusSecCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *secTitleLable;
@property (weak, nonatomic) IBOutlet UILabel *firTitleLable;
//模型
@property (nonatomic,strong)  ZHFavourite *favourite;

- (instancetype) initWithTableView :(UITableView *)tableView;
+ (instancetype) cellWithTableView :(UITableView *)tableView;
@end
