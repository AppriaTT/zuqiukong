//
//  ZHSettingButtonItem.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/5.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHSettingButtonItem.h"

@implementation ZHSettingButtonItem
- (instancetype)initWithTitle:(NSString *)title destClass:(Class)destVc iconName :(NSString *)iconName rightTitle :(NSString *)rightTitle
{
    if (self = [super initWithTitle:title]) {
        self.icon = iconName;
        self.rightTitle = rightTitle;
        self.destVC = destVc;
    }
    return self;
}
@end
