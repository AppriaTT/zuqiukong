//
//  ZHParkGuessCell.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/16.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHGuess;
@interface ZHParkGuessCell : UITableViewCell
@property (nonatomic,strong)  ZHGuess *guess;



- (instancetype) initWithTableView :(UITableView *)tableView;
+ (instancetype) cellWithTableView :(UITableView *)tableView;
@end
