//
//  ZHHeaderSection.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/7.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHSectionHeader : UIView
/**
 *  可以设置文字
 */
@property (nonatomic,weak)  UILabel *titleLable;
+(instancetype)header;
@end
