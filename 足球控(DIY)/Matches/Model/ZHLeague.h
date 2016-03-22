//
//  ZHModel.h
//  UIFengzhuang
//
//  Created by Aaron on 15/12/26.
//  Copyright (c) 2015年 叶无道. All rights reserved.
//

#import <Foundation/Foundation.h>
//联赛模型
@class ZHSeasonResult;
@interface ZHLeague : NSObject

@property (nonatomic ,copy) NSString *name;
/**
 *  联赛id用于请求联赛的编号,和联赛图标 加上.png
 */
@property (nonatomic ,copy) NSString *competition_id;

/**
 *  从联赛id中获取 赛季id
 */

@property (nonatomic ,copy) NSString *season_id;
/**
 *  e.g.2015/2016
 */
@property (nonatomic ,copy) NSString *seasonName;

/**
 *  保存有每个赛季的结果
 */
@property (nonatomic,strong) ZHSeasonResult  *result;
@end
