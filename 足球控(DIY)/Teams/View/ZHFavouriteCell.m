//
//  ZHHotTeamTableViewCell.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/7.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHFavouriteCell.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
#import "ZHTools.h"
#import "TotalAPI.h"
@implementation ZHFavouriteCell
{
    UIButton *_accessoryBtn;
}
- (instancetype) initWithTableView :(UITableView *)tableView
{
    static NSString *addFavID = @"addFavCell";
    
    ZHFavouriteCell *cell = [tableView dequeueReusableCellWithIdentifier:addFavID];
    if (cell == nil) {
        ZHFavouriteCell *newC = [[ZHFavouriteCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addFavID];
//        cell.imageView.size = CGSizeMake(50, 50);
        cell = newC;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"teams_addmy_but_default"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"teams_addmy_but_selected"] forState:UIControlStateSelected];
        button.userInteractionEnabled = NO;
        button.size = CGSizeMake(30, 30);
        //设置辅助按钮
        cell.accessoryView = button;
    }
    return cell;
}

+ (instancetype) cellWithTableView :(UITableView *)tableView
{
    return [[self alloc]initWithTableView:tableView];
}

-(void)setFavourite:(ZHFavourite *)favourite
{
    _favourite = favourite;
    
    //设置图标
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:ZHTeamsIconURL(_favourite.logourl)   ] placeholderImage:[UIImage imageNamed:@"team_logo_default"]];
    //设置名字
    self.textLabel.text = _favourite.club_name;
    //从偏好设置里取出是否被选中
    self.accessoryBtnSel = [[ZHTools objectForKeyInUserDefault:_favourite.club_name] boolValue];
}

//重写选中状态
-(void)setAccessoryBtnSel:(BOOL)accessoryBtnSel
{
    _accessoryBtnSel = accessoryBtnSel;
    _accessoryBtn = (id)self.accessoryView;
    _accessoryBtn.selected = accessoryBtnSel;
    [ZHTools saveObject:@(_accessoryBtn.selected) forKeyInUserDefault:self.favourite.club_name];
}
@end
