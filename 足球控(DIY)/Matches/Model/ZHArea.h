//
//  ZHArea.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/13.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  这是大洲模型
 */
@interface ZHArea : NSObject
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *area_id;
/**
 *里面存放着 league模型
 */
@property (nonatomic ,strong) NSMutableArray *area;
@end
