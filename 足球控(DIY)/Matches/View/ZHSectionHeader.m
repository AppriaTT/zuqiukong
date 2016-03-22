//
//  ZHHeaderSection.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/7.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHSectionHeader.h"
#import "UIView+Extension.h"
#import "TotalAPI.h"
#import "ZHSkinTool.h"
@implementation ZHSectionHeader
+(instancetype)header
{
    return [[self alloc]init];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
//        ZHSectionHeader *view = [[ZHSectionHeader alloc]initWithFrame:CGRectMake(0, 0, 375, 40)];
        self.frame = CGRectMake(0, 0, 375, 40);
        UILabel *lable = [[UILabel alloc]init];
        [self addSubview:lable];
        self.titleLable = lable;
        self.titleLable.textAlignment = NSTextAlignmentCenter;
        lable.size = CGSizeMake(100, 30);
        lable.center = CGPointMake(lable.center.x, self.height/ 2);
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeTheme) name:@"theme" object:nil];
        [self changeTheme];
        
        lable.alpha = 0.8;
        lable.text = @"时间最近";
        lable.textColor = [UIColor whiteColor];
    }
    return self;
}
- (void)changeTheme
{
    self.titleLable.backgroundColor = [ZHSkinTool skinToolWithNorBGColor];
}
#pragma mark dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
