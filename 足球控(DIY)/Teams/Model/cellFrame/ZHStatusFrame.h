//
//  ZHStatusFrame.h
//  无道博博
//
//  Created by Aaron on 15/12/23.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHStatusDetailFrame.h"
//#import "ZHStatus.h"
@class ZHStatus;
@interface ZHStatusFrame : NSObject
@property (nonatomic,strong)  ZHStatusDetailFrame *detailFrame;
@property (nonatomic,assign) CGRect toolBarFrame;

/**
 *  这是这个view的高度
 */
@property (nonatomic,assign)CGFloat viewHeight;

+(instancetype)statusFrameWithStatus:(ZHStatus *)status;

@end
