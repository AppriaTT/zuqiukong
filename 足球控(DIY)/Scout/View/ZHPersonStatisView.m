//
//  ZHPersonStatisView.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/17.
//  Copyright © 2016年 叶无道. All rights reserved.
//

#import "ZHPersonStatisView.h"
#import "ZHPerson.h"
#import "ZHLStatics.h"
#import "TotalAPI.h"
@interface ZHPersonStatisView()



@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *appL;
@property (weak, nonatomic) IBOutlet UILabel *goalL;

@property (weak, nonatomic) IBOutlet UILabel *yellowL;
@property (weak, nonatomic) IBOutlet UILabel *redL;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *typeL;
@property (weak, nonatomic) IBOutlet UIImageView *teamView;

@end

@implementation ZHPersonStatisView

+(instancetype)view
{
    return [[[NSBundle mainBundle]loadNibNamed:@"ZHPersonStatisView" owner:nil options:nil]firstObject];
}
-(void)awakeFromNib
{
    self.iconView.layer.cornerRadius = self.iconView.frame.size.width / 2;
    self.iconView.layer.masksToBounds = YES;
}

- (void)setPerson:(ZHPerson *)person
{
    _person = person;

        self.appL.text = person.league_statistics.appearances;
        self.yellowL.text = person.league_statistics.yellow_cards;
        self.redL.text = person.league_statistics.red_cards ;
        self.goalL.text = person.league_statistics.goals;
    
    self.typeL.text = person.position;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:ZHScoutPersonIcon(person.person_id)]placeholderImage:[UIImage imageNamed:@"player_avatar_default"]];
    self.nameL.text = person.name;
    NSString *name = [NSString stringWithFormat:@"%@.png",person.team_id];
    [self.teamView sd_setImageWithURL:[NSURL URLWithString:ZHTeamsIconURL(name)]];
}


@end
