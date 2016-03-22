//
//  ZHThemeCell.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/17.
//  Copyright © 2016年 叶无道. All rights reserved.
//

#import "ZHThemeCell.h"
#import "ZHTheme.h"
#import "TotalAPI.h"
@interface ZHThemeCell()

@property (weak, nonatomic) IBOutlet UILabel *teamName;

@property (weak, nonatomic) IBOutlet UIImageView *teamView;



@end
@implementation ZHThemeCell

- (instancetype) initWithTableView :(UITableView *)tableView
{
    static NSString *themeID = @"themeCell";
    ZHThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:themeID];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZHThemeCell" owner:nil options:nil] lastObject];
        
    }
    return cell;
    
}
+ (instancetype) cellWithTableView :(UITableView *)tableView
{
    return [[self alloc]initWithTableView:tableView];
}
-(void)setModel:(ZHTheme *)model
{
    _model = model;
    NSString *picName = [NSString stringWithFormat:@"%@/setting_teams_bg.jpg",model.address];
    self.teamBGView.image = [UIImage imageNamed:picName];
    picName = [NSString stringWithFormat:@"%@.png",model.teamId];
    [self.teamView sd_setImageWithURL:[NSURL URLWithString:ZHTeamsIconURL(picName)]];
    self.teamName.text = model.name;
    
    NSString *theme = [[NSUserDefaults standardUserDefaults]objectForKey:@"themeName"];
    
    if ([_model.address isEqualToString:theme]) {
        self.leftBtn.selected = YES;
    }
}

@end
