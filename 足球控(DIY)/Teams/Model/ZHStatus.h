//
//  ZHModel.h
//  UIFengzhuang
//
//  Created by Aaron on 15/12/26.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

//基础宏
#define leftMargin 10
#define topMargin 10
#define textFont [UIFont systemFontOfSize:17]
#define timeFont [UIFont systemFontOfSize:15]
#define screenW [UIScreen mainScreen].bounds.size.width
#define picViewTotolCol 3
//固定图片大小
#define imgH 100
#define imgW 100
#import "ZHUser.h"
#import "ZHComment.h"
#import "ZHStatusFrame.h"
#import <Foundation/Foundation.h>

@class ZHStatus;
@interface ZHStatus : NSObject
@property (nonatomic ,copy) NSString *text;
/**
 *  转发的微博
 */
@property (nonatomic,strong)  ZHStatus *retweeted_status;
/**
 *  原图
 */
@property (nonatomic ,copy) NSString *original_pic;
/**
 *  小图
 */
@property (nonatomic ,copy) NSString *thumbnail_pic;
/**
 *  来源,为IFTTT_Official就要有背景图
 */
@property (nonatomic ,copy) NSString *source;
/**
 *  创建时间
 */
@property (nonatomic ,copy) NSString *created_at;
/**
 *  作者
 */
@property (nonatomic ,strong) ZHUser *user;
/**
 *  评论数量
 */
@property (nonatomic ,copy) NSNumber *comment_count;
/**
 *  上一条评论
 */
@property (nonatomic ,strong) ZHComment *last_commet;

@property (nonatomic,strong)  ZHStatusFrame *statusFrame;
/**
 *  微博的ID号
 */
@property (nonatomic ,copy) NSString *idstr;

@end
