//
//  ZHPlayerRankCell.h
//  足球控(DIY)
//
//  Created by qianfeng on 16/1/13.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHPerson;
@interface ZHPlayerRankCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sectionHeaderFirL;
@property (weak, nonatomic) IBOutlet UILabel *sectionHeaderEndL;

@property (weak, nonatomic) IBOutlet UILabel *rankL;
/**
 *  球员头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *playerIconView;
@property (weak, nonatomic) IBOutlet UIImageView *teamView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *teamNameL;
@property (weak, nonatomic) IBOutlet UILabel *countL;

@property (nonatomic,copy)NSDictionary *dataDict;
- (instancetype) initWithTableView :(UITableView *)tableView;
+ (instancetype) cellWithTableView :(UITableView *)tableView;
@end
