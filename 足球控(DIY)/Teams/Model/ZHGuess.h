//
//  ZHGuess.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/16.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZHUser;
@interface ZHGuess : NSObject
@property (nonatomic ,copy) NSString * team_A_id;

@property (nonatomic ,copy) NSString * team_B_id;

@property (nonatomic ,copy) NSString *imgUrl;

@property (nonatomic ,copy) NSString *title;

@property (nonatomic ,copy) NSString *last_comment_text;

@property (nonatomic,strong)  ZHUser *last_comment_origin_user;
/**
 *  总评论数
 */
@property (nonatomic,assign)NSInteger comment_count;

@property (nonatomic ,copy) NSString *introduction;
@property (nonatomic ,copy) NSString *appLink;

@end
