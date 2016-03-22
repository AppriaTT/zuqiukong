
//
//  ZHStatusRetweetedView.m
//  无道博博
//
//  Created by Aaron on 15/12/23.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import "ZHStatusRetweetedView.h"
#import "UIView+Extension.h"
#import "UIImageView+WebCache.h"
@implementation ZHStatusRetweetedView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = ZHColor(239, 239, 239);
        self.width = screenW;
        //创建子控件 文字
        UILabel *lable = [[UILabel alloc]init];
        lable.font = textFont;
        lable.numberOfLines = 0;
        [self addSubview:lable];
        _titleLable = lable;
        
        //图片
        UIImageView *imgView = [[UIImageView alloc]init];
        _picView = imgView;
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        [self addSubview:imgView];
    }
    return self;
}
-(void)setRetweetedFrame:(ZHStatusRetweetedFrame *)retweetedFrame
{
    _retweetedFrame = retweetedFrame;
    self.titleLable.frame = _retweetedFrame.titleFrame;
    self.picView.frame = _retweetedFrame.picFrame;
    
    self.height = _retweetedFrame.viewHeight;
    
}
//设置数据
//86 174 250 蓝色转发
-(void)setStatus:(ZHStatus *)status
{
    _status =status;
    
    _titleLable.text = [NSString stringWithFormat:@"@%@:%@",status.user.name,status.text];
    
    [self.picView sd_setImageWithURL:[NSURL URLWithString:status.original_pic]];
}

@end
