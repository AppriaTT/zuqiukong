//
//  ZHMyFavs.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/7.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZHFavourite;
@interface ZHMyFavs : NSObject
/**
 *  里面保存着favrioute的模型
 */
@property (nonatomic ,strong) NSMutableArray *myFavs;


/**
 *  此时被选中的球队
 */
@property (nonatomic,strong)  ZHFavourite *selectedTeam;
/**
 *  创建单例 我的关注们
 */
+(instancetype)defaultMyFavs;
/**
 *  添加关注
 */
+(void)addObj:(ZHFavourite *)fav;
/**
 *  减少关注
 */
+(void)deleteObj:(ZHFavourite*)fav;

/**
 *  一键返回关注的数组
 */
+(NSMutableArray *)myFavs;
/**
 *  设置现在被选中的球队
 *
 *  @param zhfavourite
 */
+(void)setSelTeam:(ZHFavourite *)fav;
/**
 *  返回 被选中的球队
 *
 *  @return zhfavourite
 */
+(ZHFavourite*)selectedTeam;






@end
