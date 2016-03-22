//
//  ZHModel.h
//  UIFengzhuang
//
//  Created by Aaron on 15/12/26.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  保存每一次对阵
 */
@class ZHSmallVideo;
@interface ZHMatchVS : NSObject
@property (nonatomic ,copy) NSString *team_A_id;
@property (nonatomic ,copy) NSString *team_A_name;
@property (nonatomic ,copy) NSString *team_B_id;
@property (nonatomic ,copy) NSString *team_B_name;
/**
 *  联赛名字
 */
@property (nonatomic ,copy) NSString *name;
/**
 *  全场A队得分
 */
@property (nonatomic ,copy) NSString *fs_A;
/**
 *  全场B队得分
 */
@property (nonatomic ,copy) NSString *fs_B;
/**
 *  比赛时间
 */
@property (nonatomic ,copy) NSString *time_utc;
/**
 *  比赛日期
 */
@property (nonatomic ,copy) NSString *date_utc;
/**
 *  比赛集锦
 */
@property (nonatomic,strong)  ZHSmallVideo *recommend_video;
@end
