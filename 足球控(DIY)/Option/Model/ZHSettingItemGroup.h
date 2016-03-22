//
//  ZHSettingItemGroup.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/5.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHSettingItemGroup : NSObject
/**
 *   头部标题
 */
@property (nonatomic, copy) NSString *headerTitle;
/**
 *  底部标题
 */
@property (nonatomic, copy) NSString *footerTitle;
/**
 *  当前分组中所有行的数据(保存的是ZHSettingItem模型)
 */
@property (nonatomic, strong) NSArray *items;

@end
