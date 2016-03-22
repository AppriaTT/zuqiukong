//
//  ZHTrophies.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/16.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHTrophy.h"

@implementation ZHTrophy
- (NSString *)description
{
    return [NSString stringWithFormat:@"competition_id%@ win_game%@ runner_game %@",self.competition_id, self.winner_count,self.runnerup_count];
}
@end
