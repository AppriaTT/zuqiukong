//
//  ZHStatusOriginalFrame.h
//  无道博博
//
//  Created by Aaron on 15/12/23.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZHStatus;
@interface ZHStatusOriginalFrame : NSObject

@property (nonatomic,assign)CGRect textFrame;
@property (nonatomic,assign)CGRect picFrame;
/**
 *  这是这个view的高度
 */
@property (nonatomic,assign)CGFloat viewHeight;
@property (nonatomic,assign)CGRect  hudViewFrame;
+(instancetype)originalFrameWithStatus:(ZHStatus *)status;
@end
