//
//  ZHTransferCell.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/17.
//  Copyright © 2016年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHPerson;
@interface ZHTeamsTransferCell : UITableViewCell
//模型
@property (nonatomic,strong)  ZHPerson *player;

- (instancetype) initWithTableView :(UITableView *)tableView;
+ (instancetype) cellWithTableView :(UITableView *)tableView;
@end
