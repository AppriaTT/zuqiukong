//
//  ZHTableResultCell.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/12.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHTeamPerformance;
@interface ZHTableResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellRowNumL;
@property (weak, nonatomic) IBOutlet UIImageView *teamIconView;
@property (weak, nonatomic) IBOutlet UILabel *teamNameL;
@property (weak, nonatomic) IBOutlet UILabel *totalL;
@property (weak, nonatomic) IBOutlet UILabel *wonL;
@property (weak, nonatomic) IBOutlet UILabel *drawL;
@property (weak, nonatomic) IBOutlet UILabel *loseL;
@property (weak, nonatomic) IBOutlet UILabel *pro_againstL;
// 净胜 
@property (weak, nonatomic) IBOutlet UILabel *pureWonL;
@property (weak, nonatomic) IBOutlet UILabel *pointsL;
@property (nonatomic,strong)  ZHTeamPerformance *performance;


- (instancetype) initWithTableView :(UITableView *)tableView;
+ (instancetype) cellWithTableView :(UITableView *)tableView;
@end
