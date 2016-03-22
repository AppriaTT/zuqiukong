//
//  ZHSectionHeaderView.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/5.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHSectionHeaderView.h"

@implementation ZHSectionHeaderView

- (IBAction)rightMoreClick {
    self.moreClickblock();
}

- (IBAction)rightNewsClick {
    self.newsClickblock();
}

+(instancetype)headerViewWithIndex:(NSInteger)index
{
    return [[NSBundle mainBundle]loadNibNamed:@"ZHSectionHeaderView" owner:nil options:nil][index];
}

@end
