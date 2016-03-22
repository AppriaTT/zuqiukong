//
//  ZHSettingArrowItem.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/5.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHSettingArrowItem.h"

@implementation ZHSettingArrowItem
- (instancetype)initWithTitle:(NSString *)title destClass:(Class)destVc
{
    if (self = [super initWithTitle:title]) {
        self.destVC = destVc;
    }
    return self;
}
@end
