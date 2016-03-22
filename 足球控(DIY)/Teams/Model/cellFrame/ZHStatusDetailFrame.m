//
//  ZHStatusDetailFrame.m
//  无道博博
//
//  Created by Aaron on 15/12/23.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//
#import "ZHStatusDetailFrame.h"
#import "NSString+Extension.h"
#import "ZHStatus.h"
@implementation ZHStatusDetailFrame
+(instancetype)detailFrameWithStatus:(ZHStatus*)status
{
    return [[self alloc]initWithStatus:status];
}

-(instancetype)initWithStatus:(ZHStatus *)status
{
    if (self = [super init]) {
        self.originalFrame = [ZHStatusOriginalFrame originalFrameWithStatus:status];
        
        if (status.retweeted_status) {
            self.retweetedFrame = [ZHStatusRetweetedFrame retweetedFrameWithStatus:status.retweeted_status];
        }
        else
        {
            _retweetedFrame.viewHeight = 0;
        }
        
        //0.分割线
        self.lineFrame = CGRectMake(leftMargin / 2,self.originalFrame.viewHeight + self.retweetedFrame.viewHeight, screenW - leftMargin, 1);
        
    
        //1.头像
        CGFloat iconX = leftMargin / 2 ;
        CGFloat iconY = topMargin / 2 + self.originalFrame.viewHeight + self.retweetedFrame.viewHeight;
        CGFloat iconW = 20;
        CGFloat iconH = 20;
        
        self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
        //2.名字
       
        CGFloat nameX = CGRectGetMaxX(self.iconFrame) + leftMargin;
        CGFloat nameW = [status.user.name sizeWithFont:textFont maxSize:CGSizeMake(screenW - 2 * leftMargin, CGFLOAT_MAX)].width;
        CGFloat nameH = [status.user.name sizeWithFont:textFont maxSize:CGSizeMake(screenW - 2 * leftMargin, CGFLOAT_MAX)].height;
         CGFloat nameY = (iconH + leftMargin - nameH) / 2 + self.originalFrame.viewHeight + self.retweetedFrame.viewHeight;
        
        self.nameFrame = CGRectMake(nameX, nameY, nameW, nameH);
        //3.来源图标
        
        CGFloat sourceW = 13;
        CGFloat sourceX = screenW - leftMargin - sourceW;
        CGFloat sourceH = 13;
        CGFloat sourceY = (iconH + leftMargin - sourceH) / 2 + self.originalFrame.viewHeight + self.retweetedFrame.viewHeight;
        self.sourceFrame = CGRectMake(sourceX, sourceY, sourceW, sourceH);
        //4.时间
        
        //时间转换
        CGFloat timeW = [[NSString changeTime:status.created_at] sizeWithFont:timeFont maxSize:CGSizeMake(screenW - 2 * leftMargin, CGFLOAT_MAX)].width;
        CGFloat timeX = CGRectGetMidX(self.sourceFrame) - leftMargin - timeW;
        CGFloat timeH = [[NSString changeTime:status.created_at] sizeWithFont:timeFont maxSize:CGSizeMake(screenW - 2 * leftMargin, CGFLOAT_MAX)].height;
        CGFloat timeY = (iconH + leftMargin - timeH) / 2 + self.originalFrame.viewHeight + self.retweetedFrame.viewHeight;
        self.timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
        self.viewHeight =iconH + leftMargin + self.originalFrame.viewHeight + self.retweetedFrame.viewHeight;
        
    }

    return self;
}
@end
