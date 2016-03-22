//
//  ZHStatusDetailFrame.h
//  无道博博
//
//  Created by Aaron on 15/12/23.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHStatusRetweetedFrame.h"
#import "ZHStatusOriginalFrame.h"
@class ZHStatus;// "ZHStatus.h"

@interface ZHStatusDetailFrame : NSObject

@property (nonatomic,strong)  ZHStatusOriginalFrame *originalFrame;
@property (nonatomic,strong)  ZHStatusRetweetedFrame *retweetedFrame;

@property (nonatomic,assign)CGRect nameFrame;
@property (nonatomic,assign)CGRect timeFrame;
@property (nonatomic,assign)CGRect iconFrame;
@property (nonatomic,assign)CGRect picFrame;
@property (nonatomic,assign)CGRect sourceFrame;

@property (nonatomic,assign)CGRect lineFrame;
/**
 *  这是这个view的高度
 */
@property (nonatomic,assign)CGFloat viewHeight;
+(instancetype)detailFrameWithStatus:(ZHStatus*)status;
@end
