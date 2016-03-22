//
//  ZHSingVideoCell.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/10.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHSingVideoCell.h"
#import "ZHSmallVideo.h"
#import "UIImageView+WebCache.h"
@implementation ZHSingVideoCell

- (instancetype) initWithTableView :(UITableView *)tableView
{
    static NSString *singleVideoCellID = @"singleVideoCell";
    ZHSingVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:singleVideoCellID];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZHSingVideoCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}
+ (instancetype) cellWithTableView :(UITableView *)tableView
{
    return [[self alloc]initWithTableView:tableView];
}

//传入模型进行数据设置
-(void)setVideo:(ZHSmallVideo *)video
{
    _video = video;
    self.titleL.text = video.gameweek;
    [self.picView sd_setImageWithURL:[NSURL URLWithString:video.source1]];
}

@end
