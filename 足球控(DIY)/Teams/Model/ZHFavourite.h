//
//  ZHTeam.h
//  足球控(DIY)
//
//  Created by Aaron on 15/12/30.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import <Foundation/Foundation.h>
//保存着左边栏被关注对象的topview数据 和首页各种数据

@interface ZHFavourite : NSObject<NSCoding>

/**
 *  球队id号
 */
@property (nonatomic ,copy) NSString *team_id;
/**
 *  球队名字
 */
@property (nonatomic ,copy) NSString *club_name;
/**
 *  大图标的名字 拼接上iconURL
 */
@property (nonatomic ,copy) NSString *logourl;
/**
 *  小图标的名字
 */
@property (nonatomic ,copy) NSString *slogourl;
/**
 *  锦标数模型组,里面都是zhtrophy模型
 */
@property (nonatomic,copy)  NSArray *trophies;
//顶部栏数据模型
//首页状态模型
//赛季
//游乐场
//球员

//归档 解档
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (id)initWithCoder:(NSCoder *)aDecoder;

@end
