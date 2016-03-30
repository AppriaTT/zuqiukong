//
//  ZHStatusDetailView.m
//  无道博博
//
//  Created by Aaron on 15/12/23.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import "ZHStatusDetailView.h"
#import "ZHStatusOriginView.h"
#import "ZHStatusRetweetedView.h"
#import "UIView+Extension.h"
#import "UIImageView+WebCache.h"
#import "NSString+Extension.h"
#import "ZHCircleImageView.h"
@implementation ZHStatusDetailView
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.width  = screenW;
        //添加原微博视图
        self.originView = [[ZHStatusOriginView alloc]init];
        [self addSubview:self.originView];
        //判断是否存在转发微博
     
            //添加转发微博视图
            self.retweetView = [[ZHStatusRetweetedView alloc]init];
            [self addSubview:self.retweetView];
        //添加格线
        UIView *line = [[UIView alloc]init];
        line.height = 1;
        line.width = screenW - 2 * leftMargin;
        line.backgroundColor = [UIColor grayColor];
        line.alpha = 0.5;
        self.line = line;
        [self addSubview:line];
        
        //头像图片
        ZHCircleImageView *imgView = [[ZHCircleImageView alloc]init];
        [self addSubview:imgView];
//        imgView.layer.cornerRadius =
        imgView.cornerRadius = 10;
//        imgView.layer.masksToBounds = YES;
        _iconView = imgView;
        
        //名字
        UILabel *namelable = [[UILabel alloc]init];
        namelable.numberOfLines = 0;
        namelable.font = textFont;
        [self addSubview:namelable];
        _nameLable = namelable;
        
        //时间
        UILabel *timeLable = [[UILabel alloc]init];
        timeLable.font = timeFont;
        timeLable.textColor = [UIColor grayColor];
        [self addSubview:timeLable];
        _timeLable = timeLable;
        //来源图片
        UIImageView *sourceView= [[UIImageView alloc]init];
        [self addSubview:sourceView];
        _sourceView = sourceView;
        
    }
    return self;
}

-(void)setDetailedFrame:(ZHStatusDetailFrame *)detailedFrame
{
    _detailedFrame = detailedFrame;
    _originView.originalFrame = _detailedFrame.originalFrame;
    //如果存在转发的话
    if (_retweetView) {
        _retweetView.hidden = NO;
        _retweetView.retweetedFrame = _detailedFrame.retweetedFrame;
        _retweetView.y = _originView.originalFrame.viewHeight;
    }else
    {//否则高度就设置为0
        _retweetView.retweetedFrame.viewHeight = 0;
        _retweetView.hidden = YES;
    }
    self.line.frame = _detailedFrame.lineFrame;
    self.sourceView.frame = _detailedFrame.sourceFrame;
    self.iconView.frame = _detailedFrame.iconFrame;
    self.nameLable.frame = _detailedFrame.nameFrame;
    self.timeLable.frame = _detailedFrame.timeFrame;

    self.height = _detailedFrame.viewHeight;
}

//设置数据
- (void)setStatus:(ZHStatus *)status
{
    _status = status;
    _originView.status = _status;
    if (_status.retweeted_status) {
        _retweetView.status = _status.retweeted_status;
    }
    
    //来源栏
    _nameLable.text = status.user.name;
    _sourceView.image  = [UIImage imageNamed:@"teams_weibo_ic_logo"];
    [_iconView sd_setImageWithURL:[NSURL URLWithString:status.user.profile_image_url]];
    
    _timeLable.text = [NSString changeTime:status.created_at];//status.created_at;
}

@end
