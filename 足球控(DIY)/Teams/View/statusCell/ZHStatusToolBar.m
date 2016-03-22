//
//  ZHStatusToolBar.m
//  无道博博
//
//  Created by Aaron on 15/12/23.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import "ZHStatusToolBar.h"
#import "ZHStatusDetailView.h"
#import "UIView+Extension.h"
#import "UIImageView+WebCache.h"
#warning 工具条设置子控件的frame
@implementation ZHStatusToolBar
- (IBAction)commentClick:(id)sender {
}

+(instancetype)toolBarComment
{
    return [[[NSBundle mainBundle]loadNibNamed:@"ZHStatusToolBar" owner:nil options:nil]firstObject];
}
+(instancetype)toolBarShowMsg
{
    return [[[NSBundle mainBundle]loadNibNamed:@"ZHStatusToolBar" owner:nil options:nil]lastObject];
}
//设置toolBarframe
-(void)setToolBarFrame:(CGRect)toolBarFrame
{
    _toolBarFrame = toolBarFrame;
   
}
-(void)setStatus:(ZHStatus *)status
{
    _status =status;
    //给子控件加载数据
    self.nameLable.text = status.last_commet.displayName;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:status.last_commet.headImage_leanImgUrl]];
    self.titleLable.text = status.last_commet.last_comment_text;
    self.commentNumL.text = [status.comment_count stringValue];
}
@end
