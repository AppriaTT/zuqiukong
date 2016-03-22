//
//  ZHTopView.m
//  足球控(DIY)
//
//  Created by Aaron on 15/12/30.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import "ZHTopView.h"
#import "UIImageView+WebCache.h"
#import "ZHHttpTool.h"
#import "TotalAPI.h"
@implementation ZHTopView

- (IBAction)leftButtonClick:(id)sender {
    NSLog(@"leftButtonClick");
    self.leftButtonClickBlock();
}
- (IBAction)shareBtnClick:(id)sender {
    self.shareButtonClickBlick();
}

+(instancetype)topView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"ZHTopView" owner:nil options:nil]lastObject];
}
//传进来数据然后自己进行加载
-(void)setSelectedTeam:(ZHFavourite *)selectedTeam
{
    _selectedTeam = selectedTeam;
    //名字
    self.teamNameL.text = selectedTeam.club_name;
    
    //图标
    [self.teamIcon sd_setImageWithURL:[NSURL URLWithString:ZHTeamsIconURL(selectedTeam.logourl)]];
    
    //背景
    [self.bgView sd_setImageWithURL:[NSURL URLWithString:ZHTeamsVenueURL(selectedTeam.team_id)] placeholderImage:[UIImage imageNamed:@"footballfield_default"]];
    
    //最近赛况
    [ZHHttpTool Get:ZHTeamsRecentResult(selectedTeam.team_id) parameters:nil acceptableContentTypes:@"application/json" success:^(id responseObject) {
        //设置近况
        NSArray *listArray = responseObject[@"data"][@"list"];
        int i = 0;
        for (UIImageView *imgView in self.recentResultsView.subviews) {
            NSString *picName = [NSString stringWithFormat:@"teams_recently_%@",[listArray[i][@"result"] lowercaseString]];
            imgView.image = [UIImage imageNamed:picName];
            i++;
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
