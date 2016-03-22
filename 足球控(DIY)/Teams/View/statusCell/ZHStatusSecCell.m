//
//  ZHStatusSecCell.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/8.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHStatusSecCell.h"
#import "ZHHttpTool.h"
#import "TotalAPI.h"
#import "ZHFavourite.h"
#import "UIView+Extension.h"
#import "UIImageView+WebCache.h"
@implementation ZHStatusSecCell
- (instancetype) initWithTableView :(UITableView *)tableView
{
    static NSString *StatusSecCell = @"StatusSecCell";
    ZHStatusSecCell *cell = [tableView dequeueReusableCellWithIdentifier:StatusSecCell];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZHStatusSecCell" owner:nil options:nil] lastObject];
        
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
    [ZHHttpTool Get:ZHTeamsSecCellURL(_favourite.team_id) parameters:nil acceptableContentTypes:@"application/json" success:^(id responseObject) {
        if ((responseObject[@"data"] == [NSNull null])) {
            return ;
        }
        if (responseObject[@"data"][@"title"]) {
            self.secTitleLable.text = responseObject[@"data"][@"title"];
        }
        if (responseObject[@"data"][@"imgUrl"]) {
            [self.imgView sd_setImageWithURL:[NSURL URLWithString:responseObject[@"data"][@"imgUrl"]]];
            //并在上面加上一层渐变白色图层
            [UIView insertTransparentLayerWithView:self.imgView];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
    self.firTitleLable.text = @"比赛竞猜火热进行中";
}
@end
