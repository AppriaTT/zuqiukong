//
//  ZHTrophies.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/16.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHTrophy : NSObject
/**
 *  联赛id
 */
@property (nonatomic ,copy) NSString *competition_id;

/**
 *  冠军
 */
@property (nonatomic ,copy) NSString *winner_count;
/**
 *  亚军
 */
@property (nonatomic ,copy) NSString *runnerup_count;

@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *winner_name;
@property (nonatomic ,copy) NSString *winner_team_id;
@property (nonatomic ,copy) NSString *runnerup_team_id;
@property (nonatomic ,copy) NSString *runnerup_name;

@end
