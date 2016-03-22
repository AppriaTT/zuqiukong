//
//  ZHCountry.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/13.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHCountry : NSObject
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *area_id;
//这里保存着这个国家所有的联赛
@property (nonatomic ,strong) NSMutableArray *leagues;

/**
 *  保存着是否被打开
 */
@property (nonatomic,assign,getter=isOpen)BOOL open;
@end
