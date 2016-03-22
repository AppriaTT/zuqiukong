//
//  ZHTransferCell.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/13.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHTransferCell.h"
#import "TotalAPI.h"
@implementation ZHTransferCell
- (instancetype) initWithTableView :(UITableView *)tableView
{
    static NSString *transferResult = @"transferCell";
    ZHTransferCell *cell = [tableView dequeueReusableCellWithIdentifier:transferResult];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZHTransferCell" owner:nil options:nil] firstObject];
    }
    return cell;
    
}
+ (instancetype) cellWithTableView :(UITableView *)tableView
{
    return [[self alloc]initWithTableView:tableView];
}
-(void)setPerson:(ZHPerson *)person
{
    _person = person;
    [self.playerView sd_setImageWithURL:[NSURL URLWithString:ZHScoutPersonSmallIcon(person.person_id)] placeholderImage:[UIImage imageNamed:@"profile"]];
    self.playerView.layer.cornerRadius = 17.5;
    self.playerView.layer.masksToBounds = YES;
    self.playerNameL.text = person.name;
    self.club_nameL.text = person.club_name;
    self.fromTeamL.text = person.from_club_name ;
    self.valueL.text = [NSString stringWithFormat:@"%lu 万欧", [person.value integerValue] / 10000 ];
}
@end
