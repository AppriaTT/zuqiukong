//
//  ZHTransfer.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/17.
//  Copyright © 2016年 叶无道. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHTransfer : NSObject
@property (nonatomic ,copy) NSString *type;
/*
 *转到的球队
 */
@property (nonatomic ,copy) NSString *to_team_name;

@property (nonatomic ,copy) NSString *from_team_name;

@property (nonatomic ,copy) NSString *value;
@end
