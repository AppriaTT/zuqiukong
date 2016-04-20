//
//  ZHNGMainTool.m
//  足球控(DIY)
//
//  Created by Aaron on 16/4/20.
//  Copyright © 2016年 叶无道. All rights reserved.
//

#import "ZHNGMainTool.h"

@implementation ZHNGMainTool
static ZHNGMainTool * _singleton = nil;

+(instancetype)sharedVCTool
{
    if (!_singleton) {
        _singleton = [[ZHNGMainTool alloc]init];
    }
    return _singleton;
}
@end
