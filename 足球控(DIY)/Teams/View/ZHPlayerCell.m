//
//  ZHPlayerCell.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/16.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHPlayerCell.h"
#import "ZHPerson.h"
#import "TotalAPI.h"
#import "ZHLStatics.h"

@interface ZHPlayerCell ()
@property (weak, nonatomic) IBOutlet UILabel *ageL;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *appL;
@property (weak, nonatomic) IBOutlet UILabel *goalL;
@property (weak, nonatomic) IBOutlet UIView *coachView;
@property (weak, nonatomic) IBOutlet UILabel *yellowL;
@property (weak, nonatomic) IBOutlet UILabel *redL;
@property (weak, nonatomic) IBOutlet UIView *playerView;
@property (weak, nonatomic) IBOutlet UILabel *typeL;
@property (weak, nonatomic) IBOutlet UIImageView *typeView;

@property (weak, nonatomic) IBOutlet UIButton *btn;

@end
@implementation ZHPlayerCell
- (instancetype) initWithTableView :(UITableView *)tableView
{
    ZHPlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"playerCell"];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZHPlayerCell" owner:nil options:nil] firstObject];
    }
    return cell;
    
}
-(void)awakeFromNib
{
    self.iconView.cornerRadius = self.iconView.frame.size.width / 2;
    
//    self.iconView.layer.masksToBounds = YES;
}
+ (instancetype) cellWithTableView :(UITableView *)tableView
{
    return [[self alloc]initWithTableView:tableView];
}

- (void)setPerson:(ZHPerson *)person
{
    _person = person;
    if ([person.type containsString:@"教练"]) {
        self.playerView.hidden = YES;
        self.coachView.hidden =NO;
        NSArray *array = [person.date_of_birth componentsSeparatedByString:@"-"];
        NSInteger age = 2016 - [array[0] integerValue];
        self.ageL.text = [NSString stringWithFormat:@"%ld",age];
        self.typeView.image = [UIImage imageNamed:@"teams_coach_jersey_bg"];
    }
    else
    {
        self.playerView.hidden = NO;
        self.coachView.hidden = YES;
        self.appL.text = person.league_statistics.appearances;
        self.yellowL.text = person.league_statistics.yellow_cards;
        self.redL.text = person.league_statistics.red_cards ;
        self.goalL.text = person.league_statistics.goals;
        self.typeView.image = [UIImage imageNamed:@"teams_player_jersey_bg"];
    }
    self.typeL.text = person.type;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:ZHScoutPersonIcon(person.person_id)]placeholderImage:[UIImage imageNamed:@"player_avatar_default"]];
    self.nameL.text = person.name;
    
    
}


@end
