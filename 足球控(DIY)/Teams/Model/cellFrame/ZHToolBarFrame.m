//
//  ZHToolBarFrame.m
//  无道博博
//
//  Created by Aaron on 15/12/24.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import "ZHToolBarFrame.h"

@implementation ZHToolBarFrame
+(instancetype)toolBarFrameWithStatus:(ZHStatus *)status
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
#warning 计算工具条中子控件的frame
- (void)setupFrame:(ZHStatus *)status
{
    
    
}
@end
