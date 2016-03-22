//
//  ZHTeamsTransferCell.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/17.
//  Copyright © 2016年 叶无道. All rights reserved.
//

#import "ZHTeamsTransferCell.h"
#import "ZHPerson.h"
#import "TotalAPI.h"
#import "ZHTransfer.h"
@interface ZHTeamsTransferCell()
@property (weak, nonatomic) IBOutlet UIImageView *playerView;
@property (weak, nonatomic) IBOutlet UILabel *playerName;
@property (weak, nonatomic) IBOutlet UILabel *transINFOL;
@property (weak, nonatomic) IBOutlet UILabel *valueL;

@end

@implementation ZHTeamsTransferCell
- (instancetype) initWithTableView :(UITableView *)tableView
{
    ZHTeamsTransferCell *cell = [tableView dequeueReusableCellWithIdentifier:@"teamsTransferCell"];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZHTeamsTransferCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
    
}
-(void)awakeFromNib
{
    self.playerView.layer.cornerRadius = self.playerView.frame.size.width / 2;
    self.playerView.layer.masksToBounds = YES;
}
+ (instancetype) cellWithTableView :(UITableView *)tableView
{
    return [[self alloc]initWithTableView:tableView];
}

-(void)setPlayer:(ZHPerson *)player
{
    _player = player;
    self.playerName.text  = player.name;
    
    [self.playerView sd_setImageWithURL:[NSURL URLWithString:ZHScoutPersonIcon(player.person_id)] placeholderImage:[UIImage imageNamed:@"player_avatar_default"]];
    
    if ([_player.transfer.value isEqualToString:@""]) {
        self.transINFOL.text = [NSString stringWithFormat:@"转出:%@",_player.transfer.to_team_name];
        self.valueL.text = _player.transfer.type;
    }else
    {
       self.transINFOL.text = [NSString stringWithFormat:@"转自:%@",_player.transfer.from_team_name];
        self.valueL.text = [NSString stringWithFormat:@"%ld万欧",[_player.transfer.value integerValue]/10000];
    }
    
    
    
    
    
}
@end
