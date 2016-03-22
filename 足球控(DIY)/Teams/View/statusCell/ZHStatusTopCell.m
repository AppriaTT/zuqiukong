//
//  ZHStatusTopCell.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/8.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHStatusTopCell.h"

@implementation ZHStatusTopCell

- (IBAction)moreClick:(id)sender {
}
- (instancetype) initWithTableView :(UITableView *)tableView
{
    static NSString *StatusTopCell = @"StatusTopCell";
    ZHStatusTopCell *cell = [tableView dequeueReusableCellWithIdentifier:StatusTopCell];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZHStatusTopCell" owner:nil options:nil] lastObject];
        
    }
    return cell;
    
}
+ (instancetype) cellWithTableView :(UITableView *)tableView
{
    return [[self alloc]initWithTableView:tableView];
}
//传入模型进行数据设置
-(void)setFavourite:(ZHFavourite *)favourite
{
    _favourite = favourite;
    
    
}
@end
