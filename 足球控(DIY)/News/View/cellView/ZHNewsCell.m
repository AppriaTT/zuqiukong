//
//  ZHTableViewCell.m
//  tabController
//
//  Created by Aaron on 15/11/11.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import "ZHNewsCell.h"
#import "UIImageView+WebCache.h"
//#import "UiImageView"
@interface ZHNewsCell ()


@end


@implementation ZHNewsCell

- (void)awakeFromNib {
  
}
- (instancetype) initWithTableView :(UITableView *)tableView
{
    static NSString *newsID = @"newsCell";
    ZHNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:newsID];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZHNewsCell" owner:nil options:nil] lastObject];
        
    }
    return cell;
    
}
+ (instancetype) cellWithTableView :(UITableView *)tableView
{
    return [[self alloc]initWithTableView:tableView];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

//传入模型进行数据设置
-(void)setNews:(ZHNews *)news
{
     _news = news;
    self.titleLable.text = news.title;
    self.introLable.text = news.desc;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:news.desImg] placeholderImage:[UIImage imageNamed:@"teams_weibo_list_empty_img"]];
    self.numberLable.text = [news.commentCount stringValue];
    
    if (![news.mark isEqualToString:@""]) {
        self.topicLable.hidden = NO;
        self.topicLable.text = news.mark;
    }
    else
    {
        self.topicLable.hidden = YES;
    }
    
}
@end
