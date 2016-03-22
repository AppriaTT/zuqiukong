//
//  ZHPlayerCell.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/16.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHPerson;
@interface ZHPlayerCell : UITableViewCell
@property (nonatomic,strong)  ZHPerson *person;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (nonatomic,copy)void(^optionBlock) ();


- (instancetype) initWithTableView :(UITableView *)tableView;
+ (instancetype) cellWithTableView :(UITableView *)tableView;
@end
