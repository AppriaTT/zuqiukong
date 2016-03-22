//
//  ZHTeamPerformance.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/13.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <Foundation/Foundation.h>
//保存了整个赛季为止球队的表现
@interface ZHTeamPerformance : NSObject
/*
"area_id": "176",
"club_name": "\u9a6c\u62c9\u52a0",
"countrycode": "ESP",
"goals_against": "15",
"goals_pro": "14",
"last_rank": "11",
"matches_draw": "6",
"matches_lost": "7",
"matches_total": "19",
"matches_won": "6",
"ow_team_id": "182",
"points": "24",
"rank": "10",
"team_id": "2024"
 */
/**
*  排名
*/
@property (nonatomic ,copy) NSString *rank;
@property (nonatomic ,copy) NSString *club_name;
@property (nonatomic ,copy) NSString *team_id;
@property (nonatomic ,copy) NSString *matches_total;
@property (nonatomic ,copy) NSString *matches_won;
@property (nonatomic ,copy) NSString *matches_draw;
@property (nonatomic ,copy) NSString *matches_lost;

@property (nonatomic ,copy) NSString *goals_pro;
@property (nonatomic ,copy) NSString *goals_against;
@property (nonatomic ,copy) NSString *points;








@end
