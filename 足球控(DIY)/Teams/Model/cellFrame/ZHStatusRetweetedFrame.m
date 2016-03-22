//
//  ZHStatusRetweetedFrame.m
//  无道博博
//
//  Created by Aaron on 15/12/23.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import "ZHStatusRetweetedFrame.h"
#import "NSString+Extension.h"
#import "ZHStatus.h"
@implementation ZHStatusRetweetedFrame
+(instancetype)retweetedFrameWithStatus:(ZHStatus *)status
{
    return [[self alloc]initWithStatus:status];
}
- (instancetype)initWithStatus:(ZHStatus *)status
{
    self = [super init];
    if (self) {
        [self setupFrame:status];
        
    }
    return self;
}


- (void)setupFrame:(ZHStatus *)status
{
    //1.名字 + 文字
    CGFloat titleX = leftMargin;
    CGFloat titleY = leftMargin;
    
    NSString *content = [NSString stringWithFormat:@"@%@:%@",status.user.name,status.text];
    CGFloat titleW = [content sizeWithFont:textFont maxSize:CGSizeMake(screenW - 2 * leftMargin, CGFLOAT_MAX)].width;
    CGFloat titleH = [content sizeWithFont:textFont maxSize:CGSizeMake(screenW - 2 * leftMargin, CGFLOAT_MAX)].height;
    self.titleFrame = CGRectMake(titleX, titleY, titleW, titleH);
    
    //图片
    if (status.thumbnail_pic) {
        self.picFrame = CGRectMake(leftMargin, CGRectGetMaxY(self.titleFrame) + leftMargin, imgW, imgH);
    }else
    {
        self.picFrame = CGRectMake(0, CGRectGetMaxY(self.titleFrame), 0, 0);
    }
    self.viewHeight = CGRectGetMaxY(self.picFrame) + leftMargin;
}
@end
