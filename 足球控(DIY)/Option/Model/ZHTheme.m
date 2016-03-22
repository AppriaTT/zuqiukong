//
//  ZHTheme.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/17.
//  Copyright © 2016年 叶无道. All rights reserved.
//

#import "ZHTheme.h"

@implementation ZHTheme
+ (instancetype)themeWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.teamId = dict[@"teamId"];
        self.address = dict[@"address"];
    }
    return self;
}
@end
