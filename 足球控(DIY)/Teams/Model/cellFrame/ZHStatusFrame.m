//
//  ZHStatusFrame.m
//  无道博博
//
//  Created by Aaron on 15/12/23.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import "ZHStatusFrame.h"
#import "ZHStatusToolBar.h"
#import "UIView+Extension.h"
@implementation ZHStatusFrame
+(instancetype)statusFrameWithStatus:(ZHStatus *)status
{
    return [[self alloc]initWithStatus:status];
}
- (instancetype)initWithStatus:(ZHStatus *)status
{
    self = [super init];
    if (self) {
        self.detailFrame = [ZHStatusDetailFrame detailFrameWithStatus:status];
        self.toolBarFrame = CGRectMake(0, self.detailFrame.viewHeight, 375, 40);
        self.viewHeight = self.detailFrame.viewHeight + self.toolBarFrame.size.height;
    }
    return self;
}



@end
