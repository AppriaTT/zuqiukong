//
//  ZHStatusDetailView.h
//  无道博博
//
//  Created by Aaron on 15/12/23.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHStatus.h"
#import "ZHStatusRetweetedView.h"
#import "ZHStatusOriginView.h"
#import "ZHStatusDetailFrame.h"
@interface ZHStatusDetailView : UIView

@property (nonatomic,strong)  ZHStatusOriginView *originView;
@property (nonatomic,strong) ZHStatusRetweetedView *retweetView;

@property (nonatomic,weak) UIImageView *sourceView;
@property (nonatomic,weak) UILabel *timeLable;
@property (nonatomic,weak) UIImageView *iconView;
@property (nonatomic,weak) UILabel *nameLable;
/**
 *  分割线
 */
@property (nonatomic,strong)  UIView *line;

/**
 *  细节的具体frame
 */
@property (nonatomic,strong)ZHStatusDetailFrame * detailedFrame;
@property (nonatomic,strong)  ZHStatus *status;

@end
