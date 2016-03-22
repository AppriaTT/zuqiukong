//
//  ZHMyFavs.m
//  足球控(DIY)
//
//  Created by Aaron on 16/1/7.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import "ZHMyFavs.h"
#import "ZHTools.h"
#import "ZHFavourite.h"
@implementation ZHMyFavs

+(instancetype)defaultMyFavs
{
    static ZHMyFavs *favs=nil;
    if (!favs) {
        favs = [[ZHMyFavs alloc]init];
//        favs.myFavs = [NSMutableArray array];
    }
    return favs;
}
+(void)addObj:(ZHFavourite *)fav
{
    ZHMyFavs *favs = [ZHMyFavs defaultMyFavs];
    //去重
    for (ZHFavourite *favourite in favs.myFavs) {
        if ([favourite.team_id isEqualToString:fav.team_id]) {
            return;
        }
    }
    [favs.myFavs addObject:fav];
}
+(void)deleteObj:(ZHFavourite*)fav
{
    ZHMyFavs *favs = [ZHMyFavs defaultMyFavs];
    for (int i = 0;i < favs.myFavs.count;i++) {
        ZHFavourite *favourite = favs.myFavs[i];
        if ([favourite.team_id isEqualToString:fav.team_id]) {
            [favs.myFavs removeObject:favourite];
            return;
        }
    }
}
+(NSMutableArray *)myFavs
{
    ZHMyFavs *favs = [ZHMyFavs defaultMyFavs];
    //为空就从沙河中读取
    if (!favs.myFavs) {
        favs.myFavs = [NSMutableArray arrayWithArray:[ZHTools unarchiveObjectsWithFile:[NSString stringWithFormat:@"%@/%@",[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"],@"myFavs.data"]]];
    }
    return favs.myFavs;
}

+(void)setSelTeam:(ZHFavourite *)fav
{
    ZHMyFavs *favs = [ZHMyFavs defaultMyFavs];
    favs.selectedTeam = fav;
}
+(ZHFavourite*)selectedTeam
{
    ZHMyFavs *favs = [ZHMyFavs defaultMyFavs];
    return favs.selectedTeam;
}
@end
