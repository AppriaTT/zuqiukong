//
//  ZHTrophyCell.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/16.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHTrophyCell.h"
#import "TotalAPI.h"
#import "ZHTrophy.h"
@interface ZHTrophyCell()
@property (weak, nonatomic) IBOutlet UIImageView *winnerView;
@property (weak, nonatomic) IBOutlet UILabel *winnerL;
@property (weak, nonatomic) IBOutlet UILabel *nameL;

@property (weak, nonatomic) IBOutlet UIImageView *runnerupView;
@property (weak, nonatomic) IBOutlet UILabel *runnerL;

@end
@implementation ZHTrophyCell
- (instancetype) initWithTableView :(UITableView *)tableView
{
    static NSString *transferResult = @"trophyCell";
    ZHTrophyCell *cell = [tableView dequeueReusableCellWithIdentifier:transferResult];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZHTrophyCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}
+ (instancetype) cellWithTableView :(UITableView *)tableView
{
    return [[self alloc]initWithTableView:tableView];
}

-(void)setTrophy:(ZHTrophy *)trophy
{
    _trophy = trophy;
    self.winnerL.text = trophy.winner_name;
    self.runnerL.text = trophy.runnerup_name;
    NSString *name = [NSString stringWithFormat:@"%@.png",trophy.winner_team_id];
    [self.winnerView sd_setImageWithURL:[NSURL URLWithString:ZHTeamsIconURL(name)]];
    
    name = [NSString stringWithFormat:@"%@.png",trophy.runnerup_team_id];
    [self.runnerupView sd_setImageWithURL:[NSURL URLWithString:ZHTeamsIconURL(name)]];

    self.nameL.text = trophy.name;

}
@end
