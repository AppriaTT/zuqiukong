//
//  ZHSeasonResult.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/15.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <Foundation/Foundation.h>
//保存着一个球队 一个赛季的信息
@interface ZHSeasonResult : NSObject
/**
 *  进球
 */
@property (nonatomic ,assign) NSInteger w_ball_count;
/**
 *  失球
 */
@property (nonatomic ,assign) NSInteger l_ball_count;
@property (nonatomic ,assign) NSInteger points;
/**
 *  冠军数
 */
@property (nonatomic ,copy)NSString * winner_count;
/**
 *  亚军数
 */
@property (nonatomic ,copy) NSString *runnerup_count;
/**
 *  赢
 */
@property (nonatomic ,assign) NSInteger w_game_count;
/**
 *  平
 */
@property (nonatomic ,assign) NSInteger d_game_count;
/**
 *  输
 */
@property (nonatomic ,assign) NSInteger l_game_count;

@end
