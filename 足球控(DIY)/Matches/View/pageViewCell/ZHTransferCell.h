//
//  ZHTransferCell.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/13.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHPerson.h"
@interface ZHTransferCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *playerNameL;
@property (weak, nonatomic) IBOutlet UIImageView *playerView;
@property (weak, nonatomic) IBOutlet UILabel *club_nameL;
@property (weak, nonatomic) IBOutlet UILabel *fromTeamL;
@property (weak, nonatomic) IBOutlet UILabel *valueL;

@property (nonatomic,strong)ZHPerson *person;
- (instancetype) initWithTableView :(UITableView *)tableView;
+ (instancetype) cellWithTableView :(UITableView *)tableView;

@end
