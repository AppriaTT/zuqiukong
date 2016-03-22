//
//  ZHTableResultCell.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/12.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHTableResultCell.h"
#import "ZHTeamPerformance.h"
#import "UIImageView+WebCache.h"
#import "TotalAPI.h"
@implementation ZHTableResultCell

- (instancetype) initWithTableView :(UITableView *)tableView
{
    static NSString *MatchesTableResult = @"resultCell";
    ZHTableResultCell *cell = [tableView dequeueReusableCellWithIdentifier:MatchesTableResult];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZHTableResultCell" owner:nil options:nil] firstObject];
    }
    return cell;
    
}
+ (instancetype) cellWithTableView :(UITableView *)tableView
{
    return [[self alloc]initWithTableView:tableView];
}

-(void)setPerformance:(ZHTeamPerformance *)performance
{
    _performance = performance;
    self.cellRowNumL.text = performance.rank;
    self.teamNameL.text = performance.club_name;
    NSString *picName = [NSString stringWithFormat:@"%@.png-small",performance.team_id];
    [self.teamIconView sd_setImageWithURL:[NSURL URLWithString:ZHTeamsIconURL(picName)] placeholderImage:[UIImage imageNamed:@"teams_zqkong_ic_logo"]];
    self.totalL.text = performance.matches_total;
    self.wonL.text = performance.matches_won;
    self.drawL.text = performance.matches_draw;
    self.loseL.text = performance.matches_lost;
    self.pro_againstL.text = [NSString stringWithFormat:@"%@/%@",performance.goals_pro,performance.goals_against];
    self.pureWonL.text = [NSString stringWithFormat:@"%ld",[performance.goals_pro integerValue] - [performance.goals_against integerValue]];
    self.pointsL.text = performance.points;
    //给背景染色
    if ([performance.rank integerValue] % 2) {
        self.backgroundColor = tableViewBGColor;
    }else
    {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    //给前三名 染色
    if ([performance.rank integerValue] <= 3) {
        self.cellRowNumL.textColor = [UIColor orangeColor];
    }else
    {
        self.cellRowNumL.textColor = [UIColor blackColor];
    }
}

@end
