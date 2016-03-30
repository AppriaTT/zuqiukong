//
//  ZHPlayerRankCell.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/13.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHPlayerRankCell.h"
#import "ZHPerson.h"
#import "TotalAPI.h"

@implementation ZHPlayerRankCell
- (instancetype) initWithTableView :(UITableView *)tableView
{
    static NSString *PlayersTableResult = @"playerCell";
    ZHPlayerRankCell *cell = [tableView dequeueReusableCellWithIdentifier:PlayersTableResult];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZHPlayerRankCell" owner:nil options:nil] firstObject];
        
//        cell.teamView.clipsToBounds = YES;
    }
    return cell;
    
}
+ (instancetype) cellWithTableView :(UITableView *)tableView
{
    return [[self alloc]initWithTableView:tableView];
}
- (void)setDataDict:(NSDictionary *)dataDict
{
    _dataDict = dataDict;
    self.nameL.text = dataDict[@"name"];
    [self.playerIconView sd_setImageWithURL:[NSURL URLWithString:ZHScoutPersonSmallIcon(dataDict[@"person_id"])] placeholderImage:[UIImage imageNamed:@"profile"]];
    
    NSString *teamUrl = [NSString stringWithFormat:@"%@.png",dataDict[@"team_id"]];
    [self.teamView sd_setImageWithURL:[NSURL URLWithString:ZHTeamsIconURL(teamUrl)] placeholderImage:[UIImage imageNamed:@"scout_login_input_ic_right"]];
    self.playerIconView.cornerRadius = 17.5;
//    self.playerIconView.layer.masksToBounds = YES;
    
    self.teamNameL.text = dataDict[@"team_name"];
    self.countL.text = dataDict[@"count"];
    
   
}

@end
