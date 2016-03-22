//
//  ZHStatusRetweetedView.h
//  无道博博
//
//  Created by Aaron on 15/12/23.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHStatus.h"
#import "ZHStatusRetweetedFrame.h"
@interface ZHStatusRetweetedView : UIView
@property (nonatomic,strong)  ZHStatusRetweetedFrame *retweetedFrame;

@property (nonatomic,weak) UILabel *titleLable;
@property (nonatomic,weak) UIImageView *picView;

@property (nonatomic,strong)  ZHStatus *status;
@end
