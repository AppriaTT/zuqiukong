//
//  ZHSettingItem.h
//  足球控(DIY)
//
//  Created by Aaron on 16/1/5.
//  Copyright (c) 2016年 叶无道. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHSettingItem : NSObject
/**
 *  item的标题
 */
@property (nonatomic ,copy) NSString *title;
//副标题
@property (nonatomic ,copy) NSString *subTitle;
/**
 *  将来要执行的代码
 */
@property (nonatomic,copy)void(^optionBlock) (void);

/**
 *  用标题来初始化
 */
- (instancetype)initWithTitle:(NSString *)title;
@end
