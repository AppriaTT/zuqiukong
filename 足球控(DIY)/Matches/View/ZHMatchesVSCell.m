//
//  ZHTableViewCell.m
//  tabController
//
//  Created by Aaron on 15/11/11.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import "ZHMatchesVSCell.h"
#import "TotalAPI.h"
#import "UIImageView+WebCache.h"
@interface ZHMatchesVSCell ()


@end


@implementation ZHMatchesVSCell
- (instancetype) initWithTableView :(UITableView *)tableView
{
    static NSString *MatchesVS = @"VSCell";
    ZHMatchesVSCell *cell = [tableView dequeueReusableCellWithIdentifier:MatchesVS];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZHMatchesVSCell" owner:nil options:nil] lastObject];
        
    }
    return cell;
    
}
+ (instancetype) cellWithTableView :(UITableView *)tableView
{
    return [[self alloc]initWithTableView:tableView];
}
//传入模型进行数据设置
-(void)setModel:(ZHMatchVS *)model
{
    _model = model;
    self.A_name.text = model.team_A_name;
    self.B_name.text = model.team_B_name;
    NSString *picName = [NSString stringWithFormat:@"%@.png",model.team_A_id];
    [self.imgA sd_setImageWithURL:[NSURL URLWithString:ZHTeamsIconURL(picName)]];
    picName = [NSString stringWithFormat:@"%@.png",model.team_B_id];
    [self.imgB sd_setImageWithURL:[NSURL URLWithString:ZHTeamsIconURL(picName)]];
    //判断是否有对阵数据
    if (![model.fs_A isEqualToString:@""]) {
        self.vsResult.text = [NSString stringWithFormat:@"%@:%@",model.fs_A,model.fs_B];
    }else
    {
        self.vsResult.text = @"V.S";
    }
    self.time.text = model.time_utc;
    self.competitionName.text = model.name;
}
@end
