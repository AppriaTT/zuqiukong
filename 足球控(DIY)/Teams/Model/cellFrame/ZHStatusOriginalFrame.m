//
//  ZHStatusOriginalFrame.m
//  无道博博
//
//  Created by Aaron on 15/12/23.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import "ZHStatusOriginalFrame.h"
#import "NSString+Extension.h"
#import "ZHStatus.h"
@implementation ZHStatusOriginalFrame
+(instancetype)originalFrameWithStatus:(ZHStatus *)status
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
    //判断 是否包含这个数据 如果是就为特殊cell
    if ([status.source containsString:@"IFTTT_Official"]) {
        //1.图片
        CGFloat bgViewW = screenW;
        CGFloat bgViewH = bgViewW - 20;
        self.picFrame = CGRectMake(0, 0,bgViewW , bgViewH);
        //2.文字
        CGFloat textW = [status.text sizeWithFont:textFont maxSize:CGSizeMake(screenW - 2 * leftMargin, CGFLOAT_MAX)].width;
        CGFloat textH = [status.text sizeWithFont:textFont maxSize:CGSizeMake(screenW - 2 * leftMargin, CGFLOAT_MAX)].height;
        CGFloat textX = leftMargin ;
        CGFloat textY = bgViewH - 30 -textH - leftMargin ;
        self.textFrame = CGRectMake(textX, textY, textW, textH);
        //3.计算总高度
        self.viewHeight = bgViewH - 30 ;
        
        CGFloat x = textX - leftMargin;
        CGFloat y = CGRectGetMinY(self.textFrame) - leftMargin;
        CGFloat w = screenW;
        CGFloat h = textH + 30 + 3 * leftMargin + 30 ;
        self.hudViewFrame = CGRectMake(x, y, w, h);
        return ;
    }
    //1.文字
    CGFloat textX = leftMargin ;
    CGFloat textY = leftMargin ;
    CGFloat textW = [status.text sizeWithFont:textFont maxSize:CGSizeMake(screenW - 2 * leftMargin, CGFLOAT_MAX)].width;
    CGFloat textH = [status.text sizeWithFont:textFont maxSize:CGSizeMake(screenW - 2 * leftMargin, CGFLOAT_MAX)].height;
    
    self.textFrame = CGRectMake(textX, textY, textW, textH);
    
    //2.图片
    if (status.thumbnail_pic) {
        self.picFrame = CGRectMake(textX, CGRectGetMaxY(self.textFrame) + leftMargin,imgW , imgH);
    }else
    {
        self.picFrame = CGRectMake(0, CGRectGetMaxY(self.textFrame), 0, 0);
    }
    //3.计算总高度
    self.viewHeight = CGRectGetMaxY(self.picFrame) + leftMargin ;
//    self.bgView.frame = _originalFrame.bgViewFrame;
}

@end
