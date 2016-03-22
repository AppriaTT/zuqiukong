//
//  ZHPerson.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/11.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZHLStatics;
@class ZHTransfer;
@interface ZHPerson : NSObject
@property (nonatomic ,copy) NSString *team_id;
@property (nonatomic ,copy) NSString *team_name;
/**
 *  球员id
 */
@property (nonatomic ,copy) NSString *person_id;
@property (nonatomic ,copy) NSString *club_name;
@property (nonatomic ,copy) NSString *position;
/**
 *  球衣号码
 */
@property (nonatomic ,copy) NSString *shirtnumber;
/**
 *  球员名字
 */
@property (nonatomic ,copy) NSString *name;
/**
 *  球员背景图片
 */
@property (nonatomic ,copy) NSString *person_background_img;
@property (nonatomic ,copy) NSString *reason;
/**
 *  类型,球员or教练
 */
@property (nonatomic ,copy) NSString *type;
@property (nonatomic,strong)ZHLStatics *league_statistics;
@property (nonatomic ,copy) NSString *date_of_birth;
//转会数据
@property (nonatomic ,copy) NSString *from_club_name;
@property (nonatomic ,copy) NSString *value;

@property (nonatomic,strong)  ZHTransfer *transfer;
@end
