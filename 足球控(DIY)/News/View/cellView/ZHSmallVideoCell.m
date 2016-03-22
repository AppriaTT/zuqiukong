//
//  ZHSmallVideoCell.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/6.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHSmallVideoCell.h"
#import "UIImageView+WebCache.h"
@implementation ZHSmallVideoCell

- (instancetype) initWithTableView :(UITableView *)tableView
{
    static NSString *smallVideoCellID = @"smallVideoCell";
    ZHSmallVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:smallVideoCellID];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZHSmallVideoCell" owner:nil options:nil] lastObject];
    }
    return cell;
    
}
+ (instancetype) cellWithTableView :(UITableView *)tableView
{
    return [[self alloc]initWithTableView:tableView];
}

//传入模型进行数据设置
-(void)setSmallVideos:(NSArray *)smallVideos
{
    _smallVideos = smallVideos;
    if (!_smallVideos) {
        return;
    }
    for (int i = 0; i < 3; i++) {
        ZHSmallVideo *smallVideo = (id)smallVideos[i];
        if (i == 0) {
        [self.bigView sd_setImageWithURL:[NSURL URLWithString:smallVideo.source1]placeholderImage:[UIImage imageNamed:@"competution_highlights_default_bg"]];
        self.titleBigL.text = smallVideo.gameweek;
        }
        if (i == 1) {
            [self.topView sd_setImageWithURL:[NSURL URLWithString:smallVideo.source1]placeholderImage:[UIImage imageNamed:@"competution_highlights_default_bg"]];
            self.titleTopL.text = smallVideo.gameweek;
            
        }
        if (i == 2) {
            [self.bottomView sd_setImageWithURL:[NSURL URLWithString:smallVideo.source1]placeholderImage:[UIImage imageNamed:@"competution_highlights_default_bg"]];
            self.titleBottomL.text = smallVideo.gameweek;
            
        }
    }
}
@end
