//
//  ZHStatusOriginView.h
//  无道博博
//
//  Created by Aaron on 15/12/23.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHStatus.h"
#import "ZHStatusOriginalFrame.h"

@interface ZHStatusOriginView : UIView
@property (nonatomic,strong)  ZHStatusOriginalFrame *originalFrame;


@property (nonatomic,weak) UILabel *textLable;
@property (nonatomic,weak) UIImageView *picView;
/**
 *  渐变彩色蒙版图层
 */
@property (nonatomic,weak)  UIView *bgView;


@property (nonatomic,strong)  ZHStatus *status;

@end
